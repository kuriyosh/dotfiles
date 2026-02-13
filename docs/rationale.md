# Rationale

## Terminal

- **(採用)ghostty**
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

- **(採用) VS Code**
  - Cursor の起動が重いのが気になってきた。Claude code しか使わないので VSCode である必要性が薄れた
- Cursor
  - Claude code 中心になったので利用機会が減った
  - 並列開発時にエディタの起動の遅さやそもそも動作の重さが気になる
- Zed
  - 体感でわかるレベルで軽量
  - エディタのエコシステムが未成熟
  - VS Code/Cursor からの移行コストが高い

## 補完

- Kiro CLI
  - 補完だけに使うにはオーバースペックな気がしてきた
  - ポップアップが頻繁にずれるのが鬱陶しい
- **(採用)zsh-automplete**
  - 補完表示で目がちらつくが慣れればこちらの方が早そうなので採用
