-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Disable line wrapping
vim.opt.wrap = false

-- Enable break indent (only applies when wrap is enabled)
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- vim: ts=2 sts=2 sw=2 et
--
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.filetype.add {
  extension = {
    ['http'] = 'http',
  },
}

vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldcolumn = '0'
vim.opt.signcolumn = 'no'

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.yml.j2,*.yaml.j2',
  callback = function()
    vim.bo.filetype = 'yaml.jinja2'
  end,
})
--
--
--
--
-- Jinja2 support ish
vim.filetype.add {
  extension = {
    ['j2'] = function(path, bufnr)
      if path:match '%.ya?ml%.j2$' then
        return 'yaml.jinja2'
      -- json.j2
      elseif path:match '%.json%.j2$' then
        return 'json.jinja2'
      end
    end,
  },
}

-- vim.filetype.add {
-- pattern = {
--   -- Detect ansible playbooks
--   ['.*/playbooks/.*%.yml'] = 'yaml.ansible',
--   ['.*/roles/.*%.yml'] = 'yaml.ansible',
--   ['.*/tasks/.*%.yml'] = 'yaml.ansible',
--   ['.*/handlers/.*%.yml'] = 'yaml.ansible',
--   ['.*ansible.*%.yml'] = 'yaml.ansible',
--   ['.*%.ansible%.yml'] = 'yaml.ansible',
-- },
-- }
