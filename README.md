# dotenv

This repository contains my dotfiles and development environment setup. It includes configurations for:

- Shell (zsh) with oh-my-zsh
- Homebrew packages and applications
- VS Code/Cursor settings and keybindings
- Development tools and utilities

## Setup

1. Clone this repository
2. Run the installation script:

```console
./install.sh
```

# Rationale

## Terminal

ghostty と warp で悩み中

- ghostty
  - シンプルで無駄がない
  - 補完が微妙 (Kiro CLI だとホバーウィンドウの挙動がおかしい、zsh の補完機能だと使い勝手が悪い)
- warp
  - デフォルトの補完が優秀 
  - prefix key が使える
  - たまに挙動が変、特に subshell 周り
  - AI 機能がたまに便利だが、提案が邪魔なときもある
