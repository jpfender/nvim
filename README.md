My custom Neovim config using [LazyVim](https://github.com/LazyVim/LazyVim).

## Pipenv projects

Launch plain `nvim` from a monorepo root; there is no need to use `pipenv run nvim`.
Python and SQL tooling searches upward from the file being edited for the nearest
`Pipfile`, including nested Pipfiles, without changing Neovim's working directory,
`PATH`, or `VIRTUAL_ENV`.

- **ty** uses a separate LSP root and an explicit Python interpreter per Pipfile.
- **SQLFluff** runs as a module of that environment's Python, with the
  Pipfile directory as its working directory. SQL formatting still runs after saving.
- **Neotest** selects Python from the test file or directory being run, not the
  currently focused buffer. Run tests within each Pipfile project separately;
  one directory-wide pytest invocation cannot span multiple Python environments.
- The statusline shows the current buffer's Pipfile directory name.

Install Pipenv on your normal `PATH`, create each project's environment with
`pipenv install --dev`, and install its required tools (`sqlfluff`,
`pytest`, and any SQLFluff templater plugins) there. Missing environments produce
errors rather than falling back to the parent project's environment. Files with
no ancestor Pipfile retain normal tool defaults.

Successful environment lookups are cached per Pipfile and refreshed when the
Pipfile changes or its cached interpreter disappears. Use `:PipenvClearCache`
after relocating or recreating an environment; restart Neovim to refresh running
LSP clients. Global Pipenv activation and venv-selector are disabled to avoid
cross-project interference. Project-scoped Overseer tasks keep their existing
task-directory-based Pipenv behavior.

Run the environment regression tests with:

```sh
nvim --headless -u NONE -l tests/pipenv.lua
```
