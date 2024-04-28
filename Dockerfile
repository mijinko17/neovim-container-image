FROM node:bookworm-slim as base

RUN apt-get update && \
    apt-get install git -y && \
    apt-get install curl -y  && \
    apt-get install ripgrep -y && \
    apt-get install xz-utils -y && \
    apt-get clean

WORKDIR /neovim
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    ln -s /neovim/squashfs-root/AppRun /usr/bin/nvim && \
    rm ./nvim.appimage

ARG user="neovim"
ARG uid
RUN userdel node && \
    useradd --uid $uid -m $user
USER $user

COPY --chown=$user container-files/.config/ /home/$user/.config
COPY --chmod=0755 --chown=$user container-files/bin/copy.sh /home/$user/bin/copy.sh
COPY --chmod=0755 --chown=$user container-files/bin/paste.sh /home/$user/bin/paste.sh
ENV PATH $PATH:/home/$user/bin

RUN nvim --headless -c 'Lazy install' -c qall
RUN nvim --headless -c 'MasonInstall lua-language-server shellcheck shfmt prettier' -c qall

FROM base as default

FROM base as rust

RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH $PATH:/home/$user/.cargo/bin

USER root
RUN apt-get update && \
    apt-get install build-essential -y && \
    apt-get clean
USER $user
RUN nvim --headless -c 'MasonInstall rust-analyzer' -c qall
