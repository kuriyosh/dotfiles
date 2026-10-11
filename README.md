# dotfiles

macOS / Linux 向けの個人開発環境を Nix (Home Manager) を中心に宣言的に管理するリポジトリ。

## アーキテクチャ

パッケージとツールの管理は用途別に 3 層に分かれている。

| 層 | 用途 | 設定ファイル |
|---|---|---|
| **Nix (Home Manager)** | CLI utility / バージョン固定でよいもの (`jq`, `ripgrep`, `gh`, `tmux`, `starship` 等)。設定ファイルの symlink と、macOS では defaults の適用も担う | `flake.nix`, `nix/home.nix`, `nix/dotfiles/*.nix` |
| **mise** | バージョン更新が頻繁、または project 単位でバージョンを切り替えたいもの (`node`, `claude`, `gcloud` 等) | `mise/config.toml` (`~/.config/mise/config.toml` に symlink)。マシン固有ツールは `~/.config/mise/config.local.toml` (後述) |
| **Homebrew** (macOS のみ) | macOS GUI cask と、Nix で扱いづらい macOS 特化バイナリ (`trash` 等) | `Brewfile` |

dotfiles の実体はリポジトリ直下のディレクトリ (例: `.emacs.d/`, `tmux/`, `starship/`) に置かれ、Home Manager の `mkOutOfStoreSymlink` で `$HOME` 配下に symlink される。この方式により、設定を直接編集してすぐ反映できる（再ビルド不要）。

## 前提条件

- macOS (Apple Silicon / Intel いずれも可) または Linux (x86_64 / aarch64)
- リポジトリは `~/projects/dotfiles` に clone する (symlink の向き先がこのパスに固定されている)

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
4. (Linux のみ) Nix の zsh を `/etc/shells` に登録し、`chsh` でログインシェルにする (sudo が必要)
5. `mise install` で mise 管理のツールを入れる

## 日常的な更新

```console
# dotfiles 本体の更新を取り込んだあと (--impure は $USER 解決のため必須)
home-manager switch --flake ~/projects/dotfiles --impure

# Nix 依存関係の更新
nix flake update --flake ~/projects/dotfiles

# Homebrew (macOS のみ)
brew bundle --file=~/projects/dotfiles/Brewfile

# mise
mise upgrade
```

## Emacs の日本語設定

- 通常起動と Git 編集用の `cli.el` は、UTF-8 言語環境と UTF-8・LF を使う。
- ①・※・★などの曖昧幅文字は半角幅にする。Ghostty の `legacy` 桁幅に揃える。
- DDSKK は `C-x C-j` または `C-\` で切り替える。起動時は日本語入力を有効にしない。
- OS の IME も使える。DDSKK を使うときは、OS の IME を英数にする。
- `M-x skk-tutorial` で入力方法を練習できる。
- 共有辞書は Home Manager が `~/.local/share/skk/SKK-JISYO.L` に配置する。
- 個人辞書は UTF-8 の `~/.emacs.d/skk-jisyo`。バックアップは `skk-jisyo.bak`。
- DDSKK の `RET` は変換候補を確定する。改行はもう一度 `RET` を押す。
- コードでは、コメントと文字列の外で DDSKK が英字入力に切り替わる。
- 通常入力の括弧補完は smartparens、DDSKK 入力の括弧補完は DDSKK が行う。

辞書は `home-manager switch --flake ~/projects/dotfiles --impure` で反映する。
DDSKK は通常の Emacs 起動時にパッケージをインストールする。
Git 編集用の `cli.el` は OS の IME で入力する。

フォントは macOS では `brew bundle`、Linux では Home Manager で入る。
GUI 版 Emacs は Sarasa Term J を英字と日本語に使う。
アイコンには Symbols Nerd Font Mono を使う。
絵文字には macOS で Apple Color Emoji、Linux で Noto Color Emoji を使う。
GUI フレームを後から開いた場合も設定を適用する。

現在の構成は両 OS とも端末版 Emacs。
端末版のフォントは端末アプリで指定する。
SSH 接続では接続元の端末にフォントを入れる。
Ghostty で字幅を揃える場合は、設定に `font-family = Sarasa Term J` を指定する。
GUI の字幅は `M-: (list (string-pixel-width "a") (string-pixel-width "あ"))` で確認できる。
日本語の幅が英字の幅の 2 倍になることを確認する。

## mise の運用ルール

mise の設定は 2 ファイルに分ける。mise は両方を自動でマージして読む。

| ファイル | 役割 | 管理 |
|---|---|---|
| `mise/config.toml` | 全マシンで必須のツールだけを書く | dotfiles (symlink) |
| `~/.config/mise/config.local.toml` | そのマシンだけで必要なツール | git 管理外。各マシンで直接編集 |

- マシン固有のツールの追加は `mise-local` alias を使う：

  ```console
  mise-local postgres@17
  # 実体: mise use -p ~/.config/mise/config.local.toml postgres@17
  ```

- `mise use -g` は使わない。共有の `config.toml` (= リポジトリの実体) を書き換えてしまうため
- project 固有のツールは各リポジトリの `mise.toml` (共有する場合) か `mise.local.toml` (個人用、global gitignore 済み) に書く

## ディレクトリ構成

```
├── flake.nix               # Nix flake エントリポイント
├── nix/
│   ├── home.nix            # 共通 Home Manager 設定 (packages, programs.git, programs.zsh)
│   └── dotfiles/
│       ├── shared.nix      # クロスプラットフォームな symlink
│       └── darwin.nix      # macOS 固有 (Homebrew, defaults, ghostty 等)
├── Brewfile                # Homebrew cask
├── mise/config.toml        # mise 管理ツール (~/.config/mise/config.toml に symlink)
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

または `-b backup` を付けると既存ファイルを `.backup` に退避して続行する。

**`attribute 'homeConfigurations.xxx' missing` で失敗する**

username を `$USER` から解決しているため、`home-manager switch` には常に `--impure` が必要。

**SSH で commit できない (1Password)**

macOS では `programs.git.signing.signer` が 1Password アプリ (`/Applications/1Password.app/...`) を参照する。1Password の SSH Agent 機能を有効化していること、および `SSH_AUTH_SOCK` が 1Password のソケットを指していることを確認。

Linux では `signer` は設定されず、`ssh-keygen` によるデフォルト署名になるため、鍵を ssh-agent に load しておく。

## アンインストール

```console
nix run home-manager/master -- uninstall
brew bundle cleanup --file=~/projects/dotfiles/Brewfile  # macOS のみ
/nix/nix-installer uninstall  # Nix 自体を消す場合
```
