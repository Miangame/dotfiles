# Dotfiles

A collection of dotfiles, aliases, and ZSH plugins to enhance your shell experience.

## Features

### 🎯 Aliases

- Custom Git aliases for improved workflow
- Additional shell shortcuts and commands

### 🔧 ZSH Enhancement (Auto-installed for ZSH users)

- **Oh My Zsh**: The most popular ZSH framework (installed automatically if not present)
- **fzf**: Fuzzy finder for enhanced history search
  - 🔍 Improved `Ctrl+R` with interactive search
  - 📋 Preview and filter through command history
  - ⚡ Fast and intuitive fuzzy matching
- **zsh-syntax-highlighting**: Real-time syntax highlighting for commands
  - ✅ Valid commands appear in green
  - ❌ Invalid commands appear in red
  - 💡 Example: `mkdir folder` → `mkdir` appears in green
- **zsh-autosuggestions**: Intelligent command suggestions based on history

## Installation

You can download and install these dotfiles with a single command:

```bash
bash <(curl -s https://raw.githubusercontent.com/Miangame/dotfiles/refs/heads/main/install.sh)
```

This will automatically:

- Install Oh My Zsh if you're using ZSH and don't have it yet
- Download and set up all configurations and aliases
- Install ZSH plugins if you're using ZSH
- Configure your shell for an enhanced experience
- Install ZSH plugins if you're using ZSH
- Configure your shell for an enhanced experience

## Manual ZSH Plugin Installation

If you want to install only the ZSH plugins:

```bash
bash <(curl -s https://raw.githubusercontent.com/Miangame/dotfiles/main/zsh/setup.sh)
```

## What gets installed?

- **Oh My Zsh**: Framework for ZSH (if using ZSH and not already installed)
- **fzf**: Fuzzy finder for enhanced search (if using ZSH)
- **Aliases**: Stored in `~/.custom_aliases`
- **ZSH Plugins**: Installed in `~/.zsh-plugins/` (if using ZSH)
  - `zsh-syntax-highlighting`
  - `zsh-autosuggestions`
- **Configuration**: Added to your `.zshrc` or `.bashrc`

## Usage

After installation, restart your terminal or run:

```bash
source ~/.custom_aliases
source ~/.zshrc  # if using ZSH
```

Your shell will now have:

- 🎨 Colorized command syntax
- 💡 Smart autosuggestions
- 🔍 Enhanced history search with fuzzy finder (`Ctrl+R`)
- ⚡ Useful aliases for common tasks

## Troubleshooting

### If `Ctrl+R` doesn't show the enhanced fzf search:

```bash
bash <(curl -s https://raw.githubusercontent.com/Miangame/dotfiles/main/zsh/fix-fzf.sh)
```

Then restart your terminal or run `source ~/.zshrc`.
