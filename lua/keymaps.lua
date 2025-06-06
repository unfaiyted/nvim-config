-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
--
-- In your lua/config/keymaps.lua:
local keymap = vim.keymap

vim.keymap.set('n', '<A-h>', '^', { desc = 'Go to start of line' })
vim.keymap.set('n', '<A-l>', '$', { desc = 'Go to end of line' })
vim.keymap.set('v', '<A-h>', '^', { desc = 'Go to start of line' })
vim.keymap.set('v', '<A-l>', '$', { desc = 'Go to end of line' })

-- Custom keybindings for splitting buffers
vim.keymap.set('n', '<leader>-', ':split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>_', ':vsplit<CR>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>\\', ':vsplit<CR>', { desc = 'Vertical Split' })

-- Or for even faster movement (10 lines):
vim.keymap.set('n', '<A-S-j>', '12j', { noremap = true, silent = true })
vim.keymap.set('n', '<A-S-k>', '12k', { noremap = true, silent = true })

-- Add this to your init.lua or other config file
vim.keymap.set('n', 'gb', '<C-o>', { noremap = true, desc = 'Go back to last cursor position' })
vim.keymap.set('n', 'gf', '<C-i>', { noremap = true, desc = 'Go forward to next cursor position' })
-- In lua/config/keymaps.lua

-- Goes to the next error
keymap.set('n', 'ge', function()
  local has_errors = false

  -- First check if there are any errors
  for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      has_errors = true
      break
    end
  end

  -- If there are errors, go to next error, otherwise go to next diagnostic
  if has_errors then
    vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
  else
    vim.diagnostic.goto_next()
  end
end, { desc = '[G]o to next [e]rror or diagnostic' })

-- Yanks the diagnostic message of the current line
vim.keymap.set('n', '<leader>ce', function()
  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line '.' - 1 })
  if #diagnostics > 0 then
    local message = diagnostics[1].message
    vim.fn.setreg('+', message)
    print('Diagnostic copied to clipboard: ' .. message)
  else
    print 'No diagnostic at current line'
  end
end, { desc = 'Copy current line diagnostic to clipboard' })

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>e', '<CMD>Neotree source=filesystem  position=float<CR>')
vim.keymap.set('n', '<leader><leader>', '<CMD>Neotree source=buffers  position=float<CR>')
-- vim.keymap.set('n', '<leader>e', '<CMD>Neotree source=buffers position=float<CR>')
-- vim.keymap.set('n', '<leader>e', '<CMD>Neotree position=float<CR>')

-- Function to toggle mouse support
local function toggle_mouse()
  if vim.o.mouse == '' then
    vim.o.mouse = 'a'
    vim.notify('Mouse enabled', vim.log.levels.INFO)
  else
    vim.o.mouse = ''
    vim.notify('Mouse disabled', vim.log.levels.INFO)
  end
end

vim.o.mouse = ''
-- Keymap to toggle mouse support
vim.keymap.set('n', '<leader>tm', toggle_mouse, { desc = 'Toggle mouse' })

-- Window resizing with Ctrl+w hjkl
-- These override default navigation keys when pressed after Ctrl+w
vim.keymap.set('n', '<C-w>h', '<cmd>vertical resize -5<CR>', { desc = 'Decrease window width', silent = true })
vim.keymap.set('n', '<C-w>l', '<cmd>vertical resize +5<CR>', { desc = 'Increase window width', silent = true })
vim.keymap.set('n', '<C-w>j', '<cmd>resize -3<CR>', { desc = 'Decrease window height', silent = true })
vim.keymap.set('n', '<C-w>k', '<cmd>resize +3<CR>', { desc = 'Increase window height', silent = true })

-- Window maximize toggle with Ctrl+w +
local maximized = false
function ToggleMaximize()
  if maximized then
    vim.cmd 'wincmd ='
    maximized = false
  else
    vim.cmd 'wincmd _|wincmd |'
    maximized = true
  end
end

vim.keymap.set('n', '<C-w>+', ToggleMaximize, { desc = 'Toggle window maximize', silent = true })

-- Window mode with global mappings
local window_mode = {
  active = false,
  timer_id = nil,
  timeout = 3000, -- milliseconds
  original_mappings = {}, -- Store original mappings
}

-- Function to enter window mode
local function enter_window_mode()
  if window_mode.active then
    -- Already in window mode, just reset the timer
    if window_mode.timer_id then
      vim.fn.timer_stop(window_mode.timer_id)
    end
  else
    -- Enter window mode
    window_mode.active = true

    -- Show window mode indicator
    vim.api.nvim_echo({ { ' WINDOW MODE ', 'IncSearch' } }, false, {})

    -- Save original mappings and create temporary global mappings
    local keys = { 'h', 'l', 'j', 'k', '=', '+', '<Esc>', 'q' }
    for _, key in ipairs(keys) do
      -- Save any existing mappings
      local existing = vim.fn.maparg(key, 'n', false, true)
      if existing and existing.rhs and existing.rhs ~= '' then
        window_mode.original_mappings[key] = existing
      end

      -- Clear existing mappings
      pcall(function()
        vim.keymap.del('n', key)
      end)
    end

    -- Create temporary mappings for window mode
    vim.keymap.set('n', 'h', function()
      vim.cmd 'vertical resize -5'
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', 'l', function()
      vim.cmd 'vertical resize +5'
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', 'j', function()
      vim.cmd 'resize -3'
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', 'k', function()
      vim.cmd 'resize +3'
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', '=', function()
      vim.cmd 'wincmd ='
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', '+', function()
      ToggleMaximize()
      reset_window_timer()
    end, { nowait = true, silent = true })

    vim.keymap.set('n', '<Esc>', exit_window_mode, { nowait = true, silent = true })
    vim.keymap.set('n', 'q', exit_window_mode, { nowait = true, silent = true })
    -- vim.keymap.set('i', '<Esc>', exit_window_mode, { nowait = true, silent = true })
    -- Create autocmd to handle buffer/window switches
    vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
      callback = function()
        if window_mode.active then
          exit_window_mode()
        end
      end,
      group = vim.api.nvim_create_augroup('WindowModeAutoExit', { clear = true }),
    })
  end

  -- Set timer to exit window mode
  reset_window_timer()
end

-- Function to reset the window mode timer
function reset_window_timer()
  if window_mode.timer_id then
    vim.fn.timer_stop(window_mode.timer_id)
  end

  window_mode.timer_id = vim.fn.timer_start(window_mode.timeout, function()
    exit_window_mode()
  end)
end

-- Function to exit window mode
function exit_window_mode()
  if not window_mode.active then
    return
  end

  window_mode.active = false

  -- Stop the timer
  if window_mode.timer_id then
    vim.fn.timer_stop(window_mode.timer_id)
    window_mode.timer_id = nil
  end

  -- Clear the window mode indicator
  vim.cmd 'echo ""'

  -- Remove temporary mappings
  local keys = { 'h', 'l', 'j', 'k', '=', '+', '<Esc>', 'q' }
  for _, key in ipairs(keys) do
    pcall(function()
      vim.keymap.del('n', key)
    end)

    -- Restore original mappings if they existed
    if window_mode.original_mappings[key] then
      local m = window_mode.original_mappings[key]
      vim.keymap.set(m.mode, m.lhs, m.rhs, {
        silent = m.silent == 1,
        expr = m.expr == 1,
        nowait = m.nowait == 1,
      })
    end
  end

  window_mode.original_mappings = {}
end

-- Map <C-w><C-w> to enter window mode
vim.keymap.set('n', '<C-w><C-w>', enter_window_mode, { desc = 'Enter window mode' })

-- Add this to your Neovim configuration (e.g., init.lua or a separate file)

-- Function to select inside a markdown code block
vim.keymap.set('n', 'vic', function()
  -- Find the start of the code block (```)
  local cur_line = vim.fn.line '.'
  local start_line = cur_line

  while start_line > 0 do
    local line = vim.fn.getline(start_line)
    if line:match '^```' then
      break
    end
    start_line = start_line - 1
  end

  -- Find the end of the code block (```)
  local end_line = cur_line
  local last_line = vim.fn.line '$'

  while end_line <= last_line do
    local line = vim.fn.getline(end_line)
    if end_line > start_line and line:match '^```' then
      break
    end
    end_line = end_line + 1
  end

  -- Select the content inside the code block (excluding the backticks)
  if start_line < end_line then
    vim.cmd(string.format('normal! %dGV%dG', start_line + 1, end_line - 1))
  end
end, { desc = 'Select inside markdown code block' })

-- Function to select around a markdown code block (including the backticks)
vim.keymap.set('n', 'vac', function()
  -- Find the start of the code block (```)
  local cur_line = vim.fn.line '.'
  local start_line = cur_line

  while start_line > 0 do
    local line = vim.fn.getline(start_line)
    if line:match '^```' then
      break
    end
    start_line = start_line - 1
  end

  -- Find the end of the code block (```)
  local end_line = cur_line
  local last_line = vim.fn.line '$'

  while end_line <= last_line do
    local line = vim.fn.getline(end_line)
    if end_line > start_line and line:match '^```' then
      break
    end
    end_line = end_line + 1
  end

  -- Select the content including the code block markers
  if start_line < end_line then
    vim.cmd(string.format('normal! %dGV%dG', start_line, end_line))
  end
end, { desc = 'Select around markdown code block' })

-- Function to yank inside a markdown code block
vim.keymap.set('n', 'yic', function()
  -- Find the start of the code block (```)
  local cur_line = vim.fn.line '.'
  local start_line = cur_line

  while start_line > 0 do
    local line = vim.fn.getline(start_line)
    if line:match '^```' then
      break
    end
    start_line = start_line - 1
  end

  -- Find the end of the code block (```)
  local end_line = cur_line
  local last_line = vim.fn.line '$'

  while end_line <= last_line do
    local line = vim.fn.getline(end_line)
    if end_line > start_line and line:match '^```' then
      break
    end
    end_line = end_line + 1
  end

  -- Select and yank the content inside the code block (excluding the backticks)
  if start_line < end_line then
    -- Use visual mode to select, then yank
    vim.cmd(string.format('normal! %dGV%dGy', start_line + 1, end_line - 1))
    vim.notify(string.format('Yanked %d lines from code block', end_line - start_line - 1), vim.log.levels.INFO)
  end
end, { desc = 'Yank inside markdown code block' })

-- Yank the content inside the code block (excluding the backticks)
vim.keymap.set('n', '<leader>a', 'ggVG', { desc = 'Select entire buffer' })

vim.keymap.set('n', '<A-;>', '<cmd>vertical resize -5<CR>', { desc = 'Move panel divider left', silent = true })
vim.keymap.set('n', "<A-'>", '<cmd>vertical resize +5<CR>', { desc = 'Move panel divider right', silent = true })

vim.keymap.set('n', '<leader>=', '<C-w>=', { desc = 'Equalize window sizes', silent = true })

vim.keymap.set('i', '<C-s>', '<Esc>', { noremap = true })
vim.keymap.set('i', '<Esc>', '<Esc>', { noremap = true })
vim.keymap.set('i', '<C-s>', '<Esc>', { noremap = true })

-- function SafePaste()
--   -- Store the current unnamed register content
--   local saved_reg = vim.fn.getreg '"'
--   local saved_reg_type = vim.fn.getregtype '"'
--
--   -- Perform paste
--   vim.cmd 'normal! p'
--
--   -- Restore the unnamed register to its previous state
--   vim.fn.setreg('"', saved_reg, saved_reg_type)
-- end
-- -- paste from default register does not replace the default register
-- vim.keymap.set('n', '<leader>p', SafePaste, { noremap = true })

-- Mark keymaps
-- vim.keymap.set('n', 'ma', 'mA', { desc = 'Set mark A', noremap = true })
-- vim.keymap.set('n', 'mb', 'mB', { desc = 'Set mark B', noremap = true })
-- vim.keymap.set('n', 'mc', 'mC', { desc = 'Set mark C', noremap = true })
-- vim.keymap.set('n', '`a', '`A', { desc = 'Go to mark A', noremap = true })
-- vim.keymap.set('n', '`b', '`B', { desc = 'Go to mark B', noremap = true })
-- vim.keymap.set('n', '`c', '`C', { desc = 'Go to mark C', noremap = true })

-- Window maximize toggle keymap
vim.keymap.set('n', '+', ToggleMaximize, { desc = 'Toggle window maximize', silent = true })

-- Copy the path of the current buffer to the clipboard
vim.keymap.set('n', '<leader>cp', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied: ' .. path, vim.log.levels.INFO)
end, { desc = 'Copy current buffer path' })

-- Open Nautilus in current buffer directory
vim.keymap.set('n', '<leader>oe', function()
  local dir = vim.fn.expand '%:p:h'
  vim.fn.jobstart('GDK_BACKEND=x11 nautilus ' .. vim.fn.shellescape(dir))
  vim.notify('Opening Nautilus in: ' .. dir, vim.log.levels.INFO)
end, { desc = '[O]pen [E]xplorer in current buffer directory' })

-- Open Nautilus in current buffer directory
vim.keymap.set('n', '<leader>oz', function()
  local path = vim.fn.expand '%:p'
  vim.fn.jobstart('~/Applications/Zen.AppImage ' .. vim.fn.shellescape(path))
  vim.notify('Opening Zen file: ' .. path, vim.log.levels.INFO)
end, { desc = '[O]pen [Z]en in current buffer directory' })

local function copy_buffer_diagnostics()
  local diagnostics = vim.diagnostic.get(0) -- 0 = current buffer
  local lines = {}

  for _, diagnostic in ipairs(diagnostics) do
    local line = string.format('L%d:%d: %s', diagnostic.lnum + 1, diagnostic.col + 1, diagnostic.message)
    table.insert(lines, line)
  end

  vim.fn.setreg('+', table.concat(lines, '\n'))
  print(string.format('Copied %d diagnostics', #diagnostics))
end

vim.keymap.set('n', '<leader>cd', copy_buffer_diagnostics, { desc = 'Copy buffer diagnostics' })
