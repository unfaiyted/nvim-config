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
    
    -- Automatically use free version on startup
    local api = require('supermaven-nvim.api')
    vim.defer_fn(function()
      if api.is_running() then
        api.use_free_version()
      end
    end, 1000)
  end,
}
