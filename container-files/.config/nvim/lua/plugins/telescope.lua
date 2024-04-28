return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>p', function() builtin.find_files({ hidden = true }) end, {})
    vim.keymap.set('n', '<leader>ff', builtin.live_grep, {})
    vim.keymap.set('n', 'gr', builtin.lsp_references, {})
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = {
          "^.git/"
        }
      },
      pickers = {
        live_grep = {
          additional_args = function()
            return { "--with-filename", "--hidden" }
          end
        },
      },
    }
  end
}
