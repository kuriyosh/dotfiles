{ config, pkgs, lib, username, homeDirectory, dotfilesDir, ... }:

let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/${path}";
  inherit (pkgs.stdenv) isDarwin;
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    # utilities
    colordiff
    jq
    lesspipe
    nkf
    sourceHighlight
    inetutils
    ripgrep
    tree
    bat
    eza
    duckdb
    btop

    # git
    pkgs.git-lfs
    gh

    # cloud
    awscli2

    # shell
    starship
    zoxide
    carapace
    tmux

    # dev tools
    mise
  ] ++ lib.optionals isDarwin [
    mas
  ];

  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJWSr+IAxFWhQcgJcbQ6mYIZuIL4hjgyvSR9FKflvr5F";
      signByDefault = true;
      format = "ssh";
    } // lib.optionalAttrs isDarwin {
      signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };
    lfs.enable = true;
    settings = {
      user = {
        name = "kuriyosh";
        email = "yosyos0306@gmail.com";
      };
      alias = {
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        co = "checkout";
        c = "commit";
        sw = "switch";
        st = "status -sb";
        b = "branch";
        aicm = "!f() { COMMITMSG=$(claude -p 'Generate ONLY a one-line Git commit message in English, using imperative mood, summarizing what was changed and why, based strictly on the contents of `git diff --cached`. You MUST follow the conventional commit format. Do not add explanation or a body. Output only the commit summary line.'); git commit -m \"$COMMITMSG\" -e; }; f";
      };
      core = {
        quotepath = false;
        editor = "emacs";
        ignorecase = false;
      };
      init.defaultBranch = "main";
      push.default = "current";
      commit.template = "~/.gitmessage";
    };
    ignores = [
      ".envrc"
      "venv"
      ".kuriyosh"
      "mise.local.toml"
      ".DS_Store"
      ".clinerules"
      "**/.claude/settings.local.json"
      ".serena"
      ".wtp.yml"
    ];
  };

  home.file.".gitmessage".source = mkSymlink "git/.gitmessage";

  home.sessionVariables = {
    EDITOR = "emacsclient -nw -a ''";
    CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" ];
      theme = "";
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # fpath (must be before compinit)
        fpath=($HOME/.docker/completions $fpath)
      '')
      ''
        # completion (after oh-my-zsh to avoid being overwritten)
        zmodload zsh/complist
        zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
        source <(carapace _carapace)
        [ -f ~/.pnpm-completion.zsh ] && source ~/.pnpm-completion.zsh
        zstyle ':completion:*' menu select
        bindkey '^n' menu-complete

        # paths
        export PATH="$HOME/.local/bin:$PATH"
        export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
        export PATH="$PATH:$HOME/.cache/lm-studio/bin"

        # keybindings
        bindkey -r "^G" # unbind list-expand to free ^G prefix

        # mise
        eval "$(mise activate zsh)"

        # starship
        eval "$(starship init zsh)"

        # zoxide
        eval "$(zoxide init --cmd cd zsh)"
      ''
    ];
    shellAliases = {
      e = ''emacsclient -nw -a ""'';
      ekill = ''emacsclient -e "(kill-emacs)"'';
      cr = "cd $(git rev-parse --show-toplevel)";
      ccr = "code $(git rev-parse --show-toplevel)";
      o = "open";
      pull = "git pull";
      push = "git push";
      diff = "colordiff";
      c = "code";
      ls = "eza --grid --color auto --icons --sort=type";
      ll = "eza -la --icons --group-directories-first --git";
      la = "eza --grid --all --color auto --icons --sort=type";
      lt = "eza --tree --level=2 --icons";
      rgf = "rg --files | rg";
      ssh-pass = "ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no";
    } // lib.optionalAttrs isDarwin {
      rm = "trash";
    };
  };

  programs.home-manager.enable = true;
}
