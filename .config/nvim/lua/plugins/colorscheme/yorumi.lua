return {
  {
    'yorumicolors/yorumi.nvim',
    priority = 1000,
    config = function()
      ---@diagnostic disable-next-line: missing-fields

      -- Load the colorscheme here.
      vim.cmd.colorscheme 'yorumi'

      vim.api.nvim_set_hl(0, 'IblWhitespace', { bg = 'NONE', fg = 'NONE' })
    end,
  },
}
