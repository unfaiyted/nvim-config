" Directly load the godoc-swagger plugin
lua << EOF
if not pcall(require, 'godoc-swagger') then
  vim.notify('godoc-swagger plugin not found. Make sure it is installed correctly.', vim.log.levels.WARN)
else
  require('godoc-swagger').setup()
end
EOF