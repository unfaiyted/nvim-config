return {
  {
    'HiPhish/jinja.vim',
    ft = { 'jinja', 'jinja2', 'j2', 'html.j2', 'yaml.j2', 'yml.j2', 'json.j2', 'xml.j2', 'python.j2', 'cfg.j2', 'conf.j2', 'config.j2', 'ini.j2', 'sql.j2', 'sh.j2', 'bash.j2' },
    config = function()
      vim.filetype.add {
        extension = {
          j2 = function(path)
            local base = vim.fn.fnamemodify(path, ':r')
            local ext = vim.fn.fnamemodify(base, ':e')
            if ext == 'yml' then
              return 'yml.j2'
            elseif ext == 'yaml' then
              return 'yaml.j2'
            elseif ext == 'html' then
              return 'html.j2'
            elseif ext == 'json' then
              return 'json.j2'
            elseif ext == 'xml' then
              return 'xml.j2'
            elseif ext == 'sql' then
              return 'sql.j2'
            elseif ext == 'sh' or ext == 'bash' then
              return 'sh.j2'
            elseif ext == 'py' or ext == 'python' then
              return 'python.j2'
            elseif ext == 'cfg' then
              return 'cfg.j2'
            elseif ext == 'conf' then
              return 'conf.j2'
            elseif ext == 'config' then
              return 'config.j2'
            elseif ext == 'ini' then
              return 'ini.j2'
            else
              return 'jinja2'
            end
          end,
          jinja = 'jinja',
          jinja2 = 'jinja2',
        },
        pattern = {
          ['.*%.jinja'] = 'jinja',
          ['.*%.jinja2'] = 'jinja2',
          ['.*%.j2'] = function(path)
            local base = vim.fn.fnamemodify(path, ':r')
            local ext = vim.fn.fnamemodify(base, ':e')
            if ext and ext ~= '' then
              return ext .. '.j2'
            else
              return 'jinja2'
            end
          end,
        },
      }
      
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '*.j2', '*.jinja', '*.jinja2' },
        callback = function()
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      -- Ensure proper syntax for composite j2 files
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'yml.j2', 'yaml.j2' },
        callback = function()
          -- Set composite syntax (base language + jinja)
          vim.cmd('runtime! syntax/yaml.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'html.j2' },
        callback = function()
          vim.cmd('runtime! syntax/html.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'python.j2' },
        callback = function()
          vim.cmd('runtime! syntax/python.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'cfg.j2', 'conf.j2', 'config.j2' },
        callback = function()
          vim.cmd('runtime! syntax/conf.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'ini.j2' },
        callback = function()
          vim.cmd('runtime! syntax/dosini.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'json.j2' },
        callback = function()
          vim.cmd('runtime! syntax/json.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'xml.j2' },
        callback = function()
          vim.cmd('runtime! syntax/xml.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'sql.j2' },
        callback = function()
          vim.cmd('runtime! syntax/sql.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
      
      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'sh.j2', 'bash.j2' },
        callback = function()
          vim.cmd('runtime! syntax/sh.vim')
          vim.cmd('runtime! syntax/jinja.vim')
          vim.bo.commentstring = '{# %s #}'
        end,
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.jinja_lsp = {
        cmd = { 'jinja-lsp' },
        filetypes = { 'jinja', 'jinja2', 'j2', 'html.j2', 'yaml.j2', 'yml.j2', 'json.j2', 'xml.j2', 'sql.j2', 'sh.j2', 'bash.j2', 'python.j2', 'cfg.j2', 'conf.j2', 'config.j2', 'ini.j2' },
        root_dir = function(fname)
          return require('lspconfig.util').find_git_ancestor(fname) or vim.fn.getcwd()
        end,
        init_options = {
          templates = './templates',
          backend = { './src', './app' },
          lang = 'python',
        },
        settings = {
          jinja = {
            templates = {
              searchPaths = { './templates', '.', './src/templates' },
            },
          },
        },
      }
      return opts
    end,
  },
}
