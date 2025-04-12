# Neovim Config Guidelines

## Commands
- Test: No specific test commands for this Neovim config
- Lint: `:checkhealth kickstart` to diagnose issues
- Format: Run `:ConformInfo` to check formatters

## Style Guidelines
- Indentation: 2 spaces (tabstop=2, softtabstop=2, shiftwidth=2, expandtab=true)
- Line endings: Unix-style (LF)
- Formatting: Uses stylua for Lua files
- Naming: Follow Lua conventions (snake_case for variables/functions)
- Comments: Include function purpose, parameters, and return values
- File structure: Place plugins in lua/custom/plugins/
- Function style: Prefer local functions when appropriate
- Error handling: Use pcall for operations that might fail
- Imports: Use require with the full module path
- Module pattern: Return table of plugin specs from plugin files

## Plugin Conventions
- Each plugin spec should be a table with plugin URL as first element
- Use event/cmd for lazy-loading when possible
- Set related plugins as dependencies
- Include configuration in opts or config function