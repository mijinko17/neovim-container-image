return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    vim.keymap.set('n', '<leader>tm', '<cmd>ToggleTerm direction=horizontal<CR>')
    vim.keymap.set('n', '<leader>tmf', '<cmd>ToggleTerm direction=float<CR>')
    require("toggleterm").setup({})
  end,
}
