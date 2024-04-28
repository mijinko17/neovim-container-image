return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    local cmp = require 'cmp'
    local luasnip = require("luasnip")
    require 'cmp'.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = { { name = 'path' }, { name = 'nvim_lsp' }, { name = 'luasnip' } }
    })
  end
}
