return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local api = require('nvim-tree.api')
    vim.keymap.set('n', '<leader>tr', api.tree.toggle, {})
    require("nvim-tree").setup({})
  end
}
