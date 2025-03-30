--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--
vim.cmd [[autocmd BufNewFile,BufRead *.postcss set filetype=scss]]

vim.filetype.add {
  extension = {
    postcss = 'scss', -- Using SCSS as it handles most PostCSS features better
  },
}

local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.postcss = parser_config.scss

-- RAG Service

-- -- In your init.lua or another appropriate file
-- local rag_service = require 'avante.rag_service'
--
-- -- Function to set up and start the RAG service
-- function SetupRAG()
--   -- Launch the service
--   rag_service.launch_rag_service(function()
--     vim.notify 'RAG service is running!'
--
--     -- Add resources to index (adjust the path as needed)
--     rag_service.add_resource 'file:///home/faiyt/codebase/your-project/'
--
--     -- Monitor indexing status
--     vim.defer_fn(function()
--       local status = rag_service.indexing_status 'file:///home/faiyt/codebase/suasor/'
--       vim.notify('Indexing status: ' .. vim.inspect(status))
--     end, 5000)
--   end)
-- end
--
-- -- Create command to start RAG service
-- vim.api.nvim_create_user_command('RAGStart', function()
--   SetupRAG()
-- end, {})
--
-- -- Create command to query the RAG service
-- vim.api.nvim_create_user_command('RAGQuery', function(opts)
--   local query = opts.args
--   local results, err = rag_service.retrieve('file:///home/faiyt/codebase/suasor/', query)
--
--   if results then
--     -- Display results in a floating window
--     local buf = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(results.response, '\n'))
--
--     local width = math.min(120, vim.o.columns - 4)
--     local height = math.min(30, vim.o.lines - 4)
--
--     vim.api.nvim_open_win(buf, true, {
--       relative = 'editor',
--       width = width,
--       height = height,
--       row = (vim.o.lines - height) / 2,
--       col = (vim.o.columns - width) / 2,
--       style = 'minimal',
--       border = 'rounded',
--     })
--   else
--     vim.notify('Error: ' .. (err or 'Unknown error'), vim.log.levels.ERROR)
--   end
-- end, { nargs = '+' })
--
-- -- Create command to stop RAG service
-- vim.api.nvim_create_user_command('RAGStop', function()
--   rag_service.stop_rag_service()
--   vim.notify 'RAG service stopped'
-- end, {})
