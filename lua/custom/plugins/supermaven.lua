--- @type LazySpec
return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {

      log_level = 'off',
      keymaps = {
        accept_suggestion = '<C-b>',
        clear_suggestion = '<C-S-b>',
      },
    }
  end,
}
