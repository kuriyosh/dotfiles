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

- ghostty
  - シンプルで無駄がない
  - 補完が微妙 (Kiro CLI だとホバーウィンドウの挙動がおかしい時がある、zsh の補完機能だと使い勝手が悪い)
    - https://github.com/kirodotdev/Kiro/issues/4635
  - claude code 利用中に間違ってウィンドウ閉じた時に止めてくれるのが良い
- warp
  - デフォルトの補完が優秀 (Kiro CLI よりも優秀)
  - prefix key が使える
  - たまに挙動が変、特に subshell 周り
  - AI 機能がたまに便利だが、提案が邪魔なときもある
  - 日本語入力時の挙動が若干違和感

## Editor

- VS Code
  - Cursor にしない理由がないので一旦不要
- Cursor
  - Claude code 中心になったので利用機会が減った
  - 並列開発時にエディタの起動の遅さやそもそも動作の重さが気になる
- Zed
  - 体感でわかるレベルで軽量
  - エディタのエコシステムが未成熟
  - VS Code/Cursor からの移行コストが高い
