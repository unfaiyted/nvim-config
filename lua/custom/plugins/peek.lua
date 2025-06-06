--- @type LazySpec
return {
  'toppair/peek.nvim',
  event = { 'VeryLazy' },
  build = 'deno task --quiet build:fast',
  config = function()
    require('peek').setup {
      app = 'browser',
      -- app = { 'browser', '--new-window' },
      filetype = { 'markdown' },
      update_on_change = true,
    }
    vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
    vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})

    local is_open = false
    vim.keymap.set('n', '<leader>op', function()
      if is_open then
        require('peek').close()
        vim.notify 'Peek closed'
        is_open = false
      else
        require('peek').open()
        vim.notify 'Peek opened'
        is_open = true
      end
    end, { desc = 'Peek' })
  end,
}
