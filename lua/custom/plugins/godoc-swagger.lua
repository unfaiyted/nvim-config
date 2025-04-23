return {
  dir = vim.fn.stdpath 'config' .. '/lua/custom/plugins/godoc-swagger',
  name = 'godoc-swagger',
  config = function()
    require('custom.plugins.godoc-swagger').setup()
  end,
}
