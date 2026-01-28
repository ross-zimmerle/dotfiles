# Modular Neovim Configuration

A clean, modular, and maintainable Neovim configuration written in Lua.

## Structure

```
~/.config/nvim/
├── init.lua              # Bootstrap and entry point
├── README.md             # You are here
├── lua/
│   ├── config/           # Core options, keymaps, autocmds
│   ├── plugins/          # Plugin specifications (Lazy.nvim)
│   │   ├── init.lua      # General/Misc plugins
│   │   ├── ui.lua        # Colorscheme and Statusline
│   │   ├── telescope.lua # Fuzzy finder
│   │   ├── project.lua   # Project management
│   │   ├── treesitter.lua# Syntax highlighting
│   │   ├── lsp.lua       # Language Server Protocol
│   │   ├── completion.lua# Autocompletion (CMP)
│   │   ├── formatting.lua# Autoformatting (Conform)
│   │   └── git.lua       # Git integration
│   └── util/             # Helper functions
└── after/
    └── ftplugin/         # Filetype specific settings
```

## Prerequisites

- **Neovim** >= 0.9.0
- **Git**
- **Ripgrep** (for Telescope grep)
- **Node.js & npm** (for Mason to install some LSPs/Formatters)
- **Python/Pip** (for Python LSPs)
- **C Compiler** (gcc/clang, for Treesitter parsers)
- **Nerd Font** (recommended for icons)

### Check prerequisites:
```sh
# macOS
brew install neovim ripgrep node python
```

## Installation

1. Backup your existing configuration:
   ```sh
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   ```

2. Clone/Copy this configuration to `~/.config/nvim`.

3. Start Neovim:
   ```sh
   nvim
   ```
   *Lazy.nvim will automatically install all plugins.*

4. Run `:checkhealth` to ensure everything is working.

## Keymaps Cheatsheet

Leader key: `<Space>`

### General
- `<Space>qq`: Quit all
- `<C-s>`: Save file
- `<C-h/j/k/l>`: Window navigation
- `<S-h/l>`: Buffer navigation

### Find (Telescope)
- `<Space>fp`: Projects
- `<Space>ff`: Find files
- `<Space>fg`: Live grep
- `<Space>fb`: Buffers
- `<Space>fh`: Help tags

### Git
- `<Space>hs`: Stage hunk
- `<Space>hr`: Reset hunk
- `<Space>hb`: Blame line

### LSP & Code
- `gd`: Go to definition
- `gr`: References
- `K`: Hover documentation
- `<Space>rn`: Rename
- `<Space>ca`: Code action
- `<Space>cf`: Format file

### Toggles
- `<Space>tf`: Toggle format on save

## Adding Languages

1. **LSP**: Edit `lua/plugins/lsp.lua` and add the server to `ensure_installed` in `mason-lspconfig` setup.
2. **Formatting**: Edit `lua/plugins/formatting.lua` and add the filetype to `formatters_by_ft`.
3. **Treesitter**: Edit `lua/plugins/treesitter.lua` and add the language to `ensure_installed`.

## Troubleshooting

- **Icons missing?** Ensure you are using a Nerd Font in your terminal.
- **LSP not attaching?** Run `:LspInfo` to check status. Ensure the server is installed via Mason (`:Mason`).
- **Formatting not working?** Run `:ConformInfo`.

## Design Decisions

- **Lazy.nvim**: Fastest and most modern plugin manager.
- **Vtsls**: Chosen over `tsserver` for better performance in large TypeScript projects.
- **Ruff**: Extremely fast Python linter and formatter.
- **Tokyonight**: Clean, high-contrast, professional theme.
