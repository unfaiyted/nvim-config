local M = {}

M.fold_expr = function(lnum)
  local line = vim.fn.getline(lnum)

  -- Start fold at log statements
  if line:match 'log%.[^%(]+%(%)' then
    return '>1' -- Start a fold at level 1
  end

  -- End fold after Msg()
  if line:match '%.Msg%(' then
    -- Check if next line doesn't continue the fold
    local next_line = vim.fn.getline(lnum + 1)
    if not next_line:match 'Uint64' and not next_line:match 'Str' then
      return '<1' -- End fold
    end
  end

  return '=' -- Keep current fold level
end

return M
