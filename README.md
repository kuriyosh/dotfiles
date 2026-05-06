# dotfiles

macOS / Linux 向けの個人開発環境を Nix (Home Manager) を中心に宣言的に管理するリポジトリ。

## アーキテクチャ

パッケージとツールの管理は用途別に 3 層に分かれている。

| 層 | 用途 | 設定ファイル |
|---|---|---|
| **Nix (Home Manager)** | CLI utility / バージョン固定でよいもの (`jq`, `ripgrep`, `gh`, `tmux`, `starship` 等)。設定ファイルの symlink と、macOS では defaults の適用も担う | `flake.nix`, `nix/home.nix`, `nix/dotfiles/*.nix` |
| **mise** | バージョン更新が頻繁、または project 単位でバージョンを切り替えたいもの (`node`, `claude-cli`, `gcloud` 等) | `mise.toml` |
| **Homebrew** (macOS のみ) | macOS GUI cask と、Nix で扱いづらい macOS 特化バイナリ (`trash` 等) | `Brewfile` |

dotfiles の実体はリポジトリ直下のディレクトリ (例: `.emacs.d/`, `tmux/`, `starship/`) に置かれ、Home Manager の `mkOutOfStoreSymlink` で `$HOME` 配下に symlink される。この方式により、設定を直接編集してすぐ反映できる（再ビルド不要）。

## 前提条件

- macOS (Apple Silicon / Intel いずれも可) または Linux (x86_64 / aarch64)
- リポジトリを `~/projects/dotfiles` に clone するのが想定配置。別の場所にする場合は `DOTFILES_DIR` 環境変数で指定する

Linux では Homebrew と macOS defaults の層はスキップされ、Nix (Home Manager) + mise のみが適用される。

## 初回セットアップ

```console
git clone https://github.com/kuriyosh/dotfiles ~/projects/dotfiles
cd ~/projects/dotfiles
./install.sh
```

`install.sh` が自動で以下を行う：

1. Nix をインストール (determinate-systems installer を利用)
2. `home-manager switch --flake .` で以下を適用
   - CLI パッケージのインストール
   - dotfiles の symlink 配置
   - oh-my-zsh の配置 (Nix 管理、`programs.zsh.oh-my-zsh`)
   - macOS のみ: Homebrew のインストール、macOS defaults の適用 (Dock / メニューバー等)、ghostty 等の macOS 固有設定

3. (macOS のみ) `brew bundle` で `Brewfile` の GUI アプリを入れる
4. `mise install` で mise 管理のツールを入れる

## 日常的な更新

```console
# dotfiles 本体の更新を取り込んだあと
home-manager switch --flake ~/projects/dotfiles --impure

# Nix 依存関係の更新
nix flake update ~/projects/dotfiles

# Homebrew (macOS のみ)
brew bundle --file=~/projects/dotfiles/Brewfile

# mise
mise upgrade
```

## ディレクトリ構成

```
├── flake.nix               # Nix flake エントリポイント
├── nix/
│   ├── home.nix            # 共通 Home Manager 設定 (packages, programs.git, programs.zsh)
│   └── dotfiles/
│       ├── shared.nix      # クロスプラットフォームな symlink
│       └── darwin.nix      # macOS 固有 (Homebrew, defaults, ghostty 等)
├── Brewfile                # Homebrew cask
├── mise.toml               # mise 管理ツール
├── install.sh              # bootstrap
├── .emacs.d/               # Emacs 設定
├── tmux/                   # tmux 設定
├── starship/               # starship prompt 設定
├── ghostty/, cursor/, vscode/, zed/, karabiner/, macOS/
├── .scripts/               # CLI スクリプト集 (PATH に追加される)
├── docs/
│   └── rationale.md        # ツール選定の理由
└── archives/               # 過去使っていた設定 (item2, warp, hyper)
```

## ツール選定の理由

`docs/rationale.md` を参照。ターミナル / エディタ / 補完 etc. の選定経緯をまとめてある。

## トラブルシューティング

**`home-manager switch` が "file exists" で失敗する**

既存の手書き dotfile (例: `~/.zshrc`) が残っている場合、Home Manager は上書きを拒否する。バックアップしてから削除：

```console
mv ~/.zshrc ~/.zshrc.bak
home-manager switch --flake . --impure
```

**SSH で commit できない (1Password)**

macOS では `programs.git.signing.signer` が 1Password アプリ (`/Applications/1Password.app/...`) を参照する。1Password の SSH Agent 機能を有効化していること、および `SSH_AUTH_SOCK` が 1Password のソケットを指していることを確認。

Linux では `signer` は設定されず、`ssh-keygen` によるデフォルト署名になるため、鍵を ssh-agent に load しておく。

**DOTFILES_DIR が認識されない**

`install.sh` 経由以外で `home-manager switch` を叩くときは `--impure` が必要（`builtins.getEnv "DOTFILES_DIR"` のため）。

## アンインストール

```console
nix run home-manager/master -- uninstall
brew bundle cleanup --file=~/projects/dotfiles/Brewfile  # macOS のみ
/nix/nix-installer uninstall  # Nix 自体を消す場合
```
