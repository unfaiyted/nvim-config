-- Setup without lazy.nvim specifics
-- Return a dummy placeholder that won't be used
-- The actual plugin is loaded from the runtime path directly
return {
  dir = '~/codebase/godoc-swagger.nvim',
  config = true,
  event = { 'BufReadPre *.go', 'BufNewFile *.go' },
}

