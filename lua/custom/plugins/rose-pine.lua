-- lua/plugins/rose-pine.lua
return {
  'rose-pine/neovim',
  name = 'rose-pine',
  config = function()
    require('rose-pine').setup {
      -- Choose one of these options:

      -- Option 1: Use variant's existing colors but make the separator more visible
      highlight_groups = {
        WinSeparator = { fg = 'love' }, -- Use Rose Pine's 'love' color
      },
    }

    vim.cmd 'colorscheme rose-pine'
  end,
}
