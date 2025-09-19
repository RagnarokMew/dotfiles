return {
  'nvim-flutter/flutter-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'stevearc/snacks.nvim',
  },
  config = function()
    require('flutter-tools').setup {
      fvm = true,

      -- Force using FVM for both flutter and dart
      flutter_path = 'fvm',
      dart_path = 'fvm',

      lsp = {
        cmd = { 'fvm', 'dart', 'language-server', '--protocol=lsp' },
      },
    }
  end,
}
