# Copilot Instructions

This is a personal Neovim configuration built on the [LazyVim](https://github.com/LazyVim/LazyVim) distribution. All customizations extend or override LazyVim defaults.

## Formatting

Lua files are formatted with [StyLua](https://github.com/JohnnyMorganz/StyLua): 2-space indent, 120 column width. Run with `stylua .` from the repo root.

## Architecture

- `init.lua` — Entry point. Loads `config.lazy` (plugin manager bootstrap) then `config.debug` (LSP lifecycle monitoring).
- `lua/config/` — Core settings: options, keymaps, autocmds, and a custom async formatting module (`conform-async.lua`) that tracks slow-formatting filetypes to avoid repeated timeouts on save.
- `lua/plugins/` — One file per plugin or concern. Each returns a Lua table consumed by lazy.nvim. Plugins are disabled by returning an empty table or wrapping in `enabled = false`.
- `snippets/` — JSON snippet files (markdown, sql).

LazyVim extras are imported in `lua/config/lazy.lua` — check there for which language packs, formatters, and linters are already enabled before adding new ones.

## Conventions

- **Plugin config pattern**: Every plugin file returns a list of spec tables. Use `opts = function(_, opts)` to merge with LazyVim defaults rather than replacing them.
- **Keymaps**: Custom keymaps go in `lua/config/keymaps.lua` using a local `map()` helper. Plugin-specific keymaps use lazy.nvim's `keys` spec.
- **Disabled plugins**: Kept in the repo (not deleted) so they can be re-enabled. Check for `enabled = false` or empty return tables.
- **Pipenv**: Multiple integrations assume pipenv as the Python environment manager — virtualenv auto-switching in autocmds, pipenv-prefixed linter commands, and Overseer task templates that execute via `pipenv run`.
- **Formatting**: Per-filetype formatters are configured in `lua/plugins/formatting.lua` via conform.nvim. SQL is a special case — formatted by an autocmd that shells out to `sqlfluff fix` after write, not through conform.
- **Linting**: Per-filetype linters are configured in `lua/plugins/linting.lua` via nvim-lint. Some linters (e.g., sqlfluff) are invoked through pipenv.

## Key Integrations

- **Obsidian**: Notes live at `~/Documents/Obsidian Vault`. Picker and UI are handled by snacks.nvim, not obsidian.nvim's built-in UI.
- **Tmux**: Navigation and resizing keymaps in `keymaps.lua`; the tmux.nvim plugin itself has default keybindings disabled.
- **Overseer**: Custom task templates for git branch switching, dbt builds, and sqlfluff linting — scoped to a specific project directory (`~/sio/dp/dt`).
