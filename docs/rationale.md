# Rationale

## パッケージ管理 (Nix / mise / Homebrew の 3 層)

このリポジトリではツールを 3 種類のパッケージマネージャに分けて管理する。どこに入れるか迷ったら以下の基準で判断する。

### Nix (`nix/home.nix` の `home.packages`)

- 対象: CLI utility 系で、バージョン固定で問題ないもの
- 例: `jq`, `ripgrep`, `bat`, `eza`, `gh`, `awscli2`, `tmux`, `starship`, `zoxide`, `carapace`
- 理由: 宣言的・再現可能。`home-manager switch` で全 Mac が同じ状態になる

### mise (`mise.toml`)

- 対象: バージョン更新が頻繁、またはプロジェクト単位でバージョンを切り替えたいもの
- 例: `node`, `python`, `pnpm`, `gcloud`, `claude-cli`, `terraform`
- 理由: `.tool-versions` / `mise.toml` で project-local にバージョンを上書きできる。nixpkgs の更新タイムラグの影響を受けない
- Nix と違って `mise upgrade` だけで最新版に追従できる

### Homebrew (`Brewfile`)

- 対象: macOS GUI アプリ cask、および Nix で扱いづらい macOS 特化バイナリ
- 例: Docker Desktop, 1Password, Slack, Ghostty, `trash`
- 理由: Nix cask は Linux 寄りで macOS GUI の面倒を見る体制が薄い。cask なら GUI アプリの自動更新も brew が担当してくれる

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
