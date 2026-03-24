;;; init.el --- Emacs 30.x  -*- lexical-binding: t; -*-

;; ===============================================================
;; Custom file
;; ===============================================================

(setq custom-file (locate-user-emacs-file "custom.el")) ; custom-set-variables を別ファイルに分離
(load custom-file 'noerror)

;; ===============================================================
;; Package Setting
;; ===============================================================

(require 'package)
(setopt package-archives
        '(("gnu"    . "https://elpa.gnu.org/packages/")
          ("nongnu" . "https://elpa.nongnu.org/nongnu/")
          ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)
(require 'use-package)
(setopt use-package-always-ensure t) ; use-package で自動インストール

;; ===============================================================
;; Global Setting
;; ===============================================================

(use-package emacs
  :ensure nil
  :bind (("M-d"   . kill-word-at-point)       ; カーソル上の単語を削除
         ("M-g"   . goto-line)                ; 指定行へジャンプ
         ("C-h"   . delete-backward-char)     ; Backspace として使用
         ("C-:"   . toggle-truncate-lines)    ; 行の折り返し切替
         ("<f1>"  . read-only-mode)           ; 読み取り専用モード切替
         ("C-a"   . move-beginning-alt)       ; インデント考慮の行頭移動
         ("C-z"   . undo)                     ; 元に戻す
         ("C-/"   . undo-redo)                ; やり直し
         ("C-q C-q" . quoted-insert)          ; 制御文字の直接入力
         ("C-q f"   . project-find-file)      ; プロジェクト横断ファイル名検索
         :map minibuffer-local-completion-map
         ("C-w" . backward-kill-word))        ; ミニバッファで前方単語削除
  :bind* (("M-h" . backward-kill-word))       ; 前方の単語を削除 (全モード優先)
  :init
  (add-to-list 'load-path (locate-user-emacs-file "elisp")) ; 自作 elisp の読み込みパス
  (make-directory (locate-user-emacs-file "backup/") t)      ; バックアップ用ディレクトリを作成

  (setq default-directory "~/")
  (setq-default indent-tabs-mode nil ; タブをスペースに置き換え
                tab-width 2)         ; タブ幅は2スペース

  (setopt inhibit-startup-message t                    ; 起動メッセージを非表示
          use-short-answers t                          ; yes/no を y/n で回答可能に
          ring-bell-function 'ignore                   ; ビープ音を無効化
          truncate-partial-width-windows nil            ; 分割ウィンドウで行を折り返す
          frame-resize-pixelwise t                     ; フレームサイズをピクセル単位で調整可能に
          delete-by-moving-to-trash t                  ; 削除時にゴミ箱へ移動
          trash-directory "~/.Trash"                   ; ゴミ箱のパス
          create-lockfiles nil                         ; ロックファイルを生成しない
          auto-save-list-file-prefix nil               ; 自動保存リストファイルを生成しない
          backup-directory-alist                       ; バックアップファイルの保存先
          `(("." . ,(locate-user-emacs-file "backup/")))
          auto-save-file-name-transforms              ; オートセーブファイルの保存先
          `((".*" ,(locate-user-emacs-file "backup/") t))
          recentf-auto-cleanup 60                     ; recentf を60秒ごとにクリーンアップ
          recentf-max-saved-items 2000                ; 最近開いたファイルの最大記録数
          recentf-exclude '(".recentf"                ; recentf から除外するパターン
                            "COMMIT_EDITMSG"
                            "/.?TAGS"
                            "^/sudo:"
                            ".emacs.d/games/.*-scores"
                            "output-html/.*")
          tab-always-indent 'complete                 ; TABでまずインデント、次に補完
          completion-auto-help 'always                ; 補完候補を常に表示
          global-auto-revert-non-file-buffers t)      ; Dired等の非ファイルバッファも自動更新

  :config
  (blink-cursor-mode -1)            ; カーソルの点滅を止める
  (menu-bar-mode -1)                ; メニューバーを非表示
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))             ; ツールバーを非表示

  (delete-selection-mode 1)         ; 選択範囲を上書き入力可能に
  (recentf-mode 1)                  ; 最近開いたファイルの記録を有効化
  (savehist-mode 1)                 ; ミニバッファの履歴を保存
  (global-auto-revert-mode 1)       ; 外部変更を自動で反映
  (winner-mode 1)                   ; ウィンドウレイアウトの undo/redo
  (repeat-mode 1)                   ; リピートキーで prefix 省略可能に

  (when (fboundp 'editorconfig-mode)
    (editorconfig-mode 1))          ; .editorconfig を自動適用 (Emacs 30+)
  (when (fboundp 'which-key-mode)
    (which-key-mode 1))             ; プレフィックスキーの続き候補を表示 (Emacs 30+)

  (show-paren-mode -1)                   ; smartparens 側でハイライトするため無効化
  (global-display-line-numbers-mode 1)   ; 全モードで行番号表示

  ;; scratch バッファーは削除させない
  (with-current-buffer "*scratch*"
    (emacs-lock-mode 'kill))

  ;; スクリプトファイルに実行権限を与えて保存
  (add-hook 'after-save-hook
            #'executable-make-buffer-file-executable-if-script-p)

  ;; recentf の保存メッセージを抑制
  (advice-add 'recentf-cleanup   :around
              (lambda (fn &rest args) (let ((inhibit-message t)) (apply fn args))))
  (advice-add 'recentf-save-list :around
              (lambda (fn &rest args) (let ((inhibit-message t)) (apply fn args))))
  (defvar recentf-auto-save-timer nil)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t #'recentf-save-list)) ; 30秒アイドルで自動保存

  (unbind-key "C-t")   ; tmux プレフィックスと競合しないように解放
  (unbind-key "C-q")   ; プレフィックスとして解放
  (bind-key "M-n" (lambda () (interactive) (forward-line 5)))   ; 5行下へ移動
  (bind-key "M-p" (lambda () (interactive) (forward-line -5)))) ; 5行上へ移動

;; ===============================================================
;; macOS specific
;; ===============================================================

(when (eq system-type 'darwin)
  (setq dired-use-ls-dired nil)            ; macOS の ls は --dired 非対応
  (when (display-graphic-p)
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)) ; タイトルバーを透過
    (add-to-list 'default-frame-alist '(ns-appearance . dark))))      ; ダークモード外観

;; terminal Emacs 用のクリップボード連携 (GUI は標準で統合済み)
(use-package xclip
  :unless (display-graphic-p)
  :config
  (xclip-mode 1))

;; ===============================================================
;; Appearance settings
;; ===============================================================

(use-package nerd-icons) ; Nerd Fonts アイコン表示

(use-package nerd-icons-dired ; Dired にアイコン表示
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package nerd-icons-completion ; Vertico/Marginalia にアイコン表示
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu ; Corfu 補完候補にアイコン表示
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package doom-modeline ; doom-modeline は nerd-icons を自動利用
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 18)
  (doom-modeline-bar-width 3)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project))

(use-package doom-themes
  :custom
  ;; Global settings (defaults)
  (doom-themes-enable-bold t)   ; if nil, bold is universally disabled
  (doom-themes-enable-italic t) ; if nil, italics is universally disabled
  :config
  (load-theme 'doom-one t)

  ;; カレント行の行番号を特別扱いしない
  (face-spec-set 'line-number-current-line '((t (:inherit line-number))))

  ;; ターミナルの背景色をそのまま使う
  (unless (display-graphic-p)
    (set-face-background 'default "unspecified-bg")))

;; ===============================================================
;; Various Package Setting
;; ===============================================================

(use-package hideshow ; コードブロックの折りたたみ
  :hook (prog-mode . hs-minor-mode)    ; プログラミング時にコード折りたたみ有効化
  :bind (("C-;"   . hs-toggle-hiding)  ; 折りたたみ切替
         ("C-M-l" . hs-show-block)     ; 展開
         ("C-M-h" . hs-hide-block)))   ; 折りたたむ

(use-package open-junk-file ; 日付付きの一時ファイルを素早く作成
  :bind ("C-x j" . open-junk-file)
  :custom
  (open-junk-file-format "~/junk/%Y-%m-%d-%H%M%S."))

(use-package logview ; ログファイルの閲覧用モード
  :mode ("\\.log\\'" . logview-mode))

(use-package multiple-cursors ; 複数カーソル編集
  :bind (("C-S-c"   . mc/edit-lines)                ; 選択行に一括カーソル
         ("C->"     . mc/mark-next-like-this-symbol) ; 次の同一シンボルをマーク
         ("C-<"     . mc/mark-previous-like-this-symbol) ; 前の同一シンボルをマーク
         ("C-c C-<" . mc/mark-all-like-this)))       ; 全ての同一シンボルをマーク

;; smartparens — カスタムペア (「」/【】/'') が必要なので維持
(use-package smartparens ; 括弧の自動補完・操作
  :config
  (require 'smartparens-config)
  (sp-pair "「" "」") ; 日本語かぎ括弧
  (sp-pair "【" "】") ; 日本語すみ付き括弧
  (sp-pair "'" "'")   ; シングルクォート
  (sp-local-pair 'org-mode "$" "$") ; Org mode で数式用
  (with-eval-after-load 'org-mode (require 'smartparens-org))
  (show-smartparens-global-mode)   ; 対応する括弧をハイライト
  (smartparens-global-mode))       ; 全バッファで有効化

(use-package treemacs ; ファイルツリー (必要時にポップアップ、ファイル選択後に自動クローズ)
  :bind* (("C-o" . treemacs-select-window)) ; 全モードで優先
  :custom
  (treemacs-position 'right)
  (treemacs-width 35)
  :config
  (treemacs-project-follow-mode 1) ; カレントプロジェクトに自動追従
  ;; ファイル選択後に treemacs ウィンドウを自動で閉じる
  (advice-add 'treemacs-visit-node-default :after
              (lambda (&rest _)
                (when-let* ((w (treemacs-get-local-window)))
                  (unless (eq (selected-window) w) ; ディレクトリ展開時は閉じない
                    (delete-window w))))))

(use-package treemacs-nerd-icons ; treemacs に nerd-icons アイコンを表示
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

(use-package avy ; 画面内の任意の位置にジャンプ
  :bind (("C-j" . avy-goto-word-1)   ; 文字入力で候補を絞りジャンプ
         ("M-l" . avy-goto-line))  ; 行番号でジャンプ
  :custom
  (avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l
                 ?w ?e ?r ?u ?i ?o
                 ?x ?c ?v ?n ?m)))

(use-package undo-fu-session ; ファイルを閉じても undo 履歴を保持
  :init
  (undo-fu-session-global-mode 1))


(use-package goto-chg ; 最後の変更箇所にジャンプ
  :bind (("C-," . goto-last-change)))

;; ===============================================================
;; Completion: Vertico + Orderless + Marginalia + Consult + Embark
;; ===============================================================

(use-package vertico ; ミニバッファの縦リスト補完 UI
  :init
  (vertico-mode 1))

(use-package orderless ; スペース区切りの順不同マッチング
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion))))) ; ファイルパスは部分一致も許可

(use-package marginalia ; 補完候補に注釈を付与 (キーバインド、ファイルサイズ等)
  :init
  (marginalia-mode 1))

(use-package consult ; 高機能な検索・移動コマンド集
  :bind (("C-s"   . consult-line)       ; バッファ内インクリメンタル検索
         ("C-x b" . consult-buffer)     ; バッファ切り替え (プレビュー付き)
         ("M-y"   . consult-yank-pop)   ; kill-ring からヤンク
         ("C-q s" . consult-ripgrep))   ; プロジェクト横断テキスト検索
  )

(use-package embark ; 補完候補に対するアクションメニュー
  :bind (("C-." . embark-act))
  ;; MEMO: embark の操作に慣れたらいくつか外す
  ;; :custom
  ;; (embark-confirm-act-all nil) ; act-all 実行時の確認を省略
  )

(use-package embark-consult ; Embark と Consult の連携
  :after (embark consult))

;; ===============================================================
;; In-buffer completion: Corfu + Cape + Tempel
;; ===============================================================

(use-package corfu ; バッファ内補完のポップアップ UI
  :demand t
  :custom
  (corfu-auto t)           ; 入力中に自動で補完候補を表示
  (corfu-auto-delay 0.2)   ; 表示までの遅延 (秒)
  (corfu-auto-prefix 2)    ; 2文字入力で補完開始
  :config
  (global-corfu-mode 1))

(use-package corfu-terminal ; ターミナル Emacs で Corfu ポップアップを表示
  :unless (display-graphic-p)
  :after corfu
  :config
  (corfu-terminal-mode 1))

(use-package cape ; 補完ソースの拡張 (ファイルパス、dabbrev 等)
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)    ; ファイルパス補完
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)) ; バッファ内の単語補完

(use-package tempel ; 軽量テンプレート/スニペット展開
  :bind ("M-+" . tempel-complete)
  :init
  (add-to-list 'completion-at-point-functions #'tempel-complete))

;; ===============================================================
;; Programming: Eglot + tree-sitter
;; ===============================================================

(use-package treesit ; tree-sitter grammar の管理・モード切り替え
  :ensure nil
  :custom
  (treesit-language-source-alist
   '((python     "https://github.com/tree-sitter/tree-sitter-python")
     (go         "https://github.com/tree-sitter/tree-sitter-go")
     (gomod      "https://github.com/camdencheek/tree-sitter-go-mod")
     (rust       "https://github.com/tree-sitter/tree-sitter-rust")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (tsx        "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (toml       "https://github.com/tree-sitter/tree-sitter-toml")
     (yaml       "https://github.com/tree-sitter/tree-sitter-yaml")
     (json       "https://github.com/tree-sitter/tree-sitter-json")
     (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile")
     (prisma     "https://github.com/victorhqc/tree-sitter-prisma")))
  (major-mode-remap-alist              ; 従来モード → ts-mode へのリマップ
   '((python-mode     . python-ts-mode)
     (go-mode         . go-ts-mode)
     (rust-mode       . rust-ts-mode)
     (typescript-mode . typescript-ts-mode)
     (json-mode       . json-ts-mode)
     (yaml-mode       . yaml-ts-mode)
     (toml-mode       . toml-ts-mode)
     (dockerfile-mode . dockerfile-ts-mode)))
  :config
  ;; 未インストールの grammar を自動インストール
  (dolist (lang (mapcar #'car treesit-language-source-alist))
    (unless (treesit-language-available-p lang)
      (treesit-install-language-grammar lang)))
  ;; ts/tsx は auto-mode-alist で直接設定
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode)))

(use-package prisma-ts-mode ; Prisma schema ファイルのメジャーモード
  :mode "\\.prisma\\'")

(use-package markdown-mode ; Markdown ファイルのメジャーモード
  :mode ("\\.md\\'" . gfm-mode))

(use-package terraform-mode
  :hook (terraform-mode . terraform-format-on-save-mode))

(use-package eglot ; LSP クライアント (補完・定義ジャンプ・診断等)
  :ensure nil
  :hook ((python-mode       . eglot-ensure)
         (python-ts-mode    . eglot-ensure)
         (go-mode           . eglot-ensure)
         (go-ts-mode        . eglot-ensure)
         (rust-mode         . eglot-ensure)
         (rust-ts-mode      . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode        . eglot-ensure)
         (terraform-mode     . eglot-ensure)
         (dockerfile-ts-mode . eglot-ensure)))

;; ===============================================================
;; Git
;; ===============================================================

(use-package magit ; Git の操作を Emacs 内で完結させる
  :bind ("C-x g" . magit-status)
  :config
  (bind-key "C-h" 'transient-help transient-map)) ; transient 内では C-h をヘルプに戻す

(use-package diff-hl ; 変更行をフリンジにカラー表示
  :hook
  ((magit-pre-refresh  . diff-hl-magit-pre-refresh)   ; magit 操作前に更新
   (magit-post-refresh . diff-hl-magit-post-refresh)) ; magit 操作後に更新
  :init
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  (diff-hl-margin-mode))

;; ===============================================================
;; Original Functions
;; ===============================================================

(defun my:copy-relative-filename-with-line ()
  "Copy the buffer's project-relative path to the kill ring.
When a region is active, append #L<start>-L<end> line range."
  (interactive)
  (let* ((filename (if (equal major-mode 'dired-mode)
                       default-directory
                     (buffer-file-name)))
         (root (when filename
                 (if-let ((proj (project-current)))
                     (project-root proj)
                   (file-name-directory filename))))
         (relpath (when filename
                    (file-relative-name filename root)))
         (result (when relpath
                   (if (use-region-p)
                       (format "%s#L%d-L%d" relpath
                               (line-number-at-pos (region-beginning))
                               (line-number-at-pos (region-end)))
                     relpath))))
    (when result
      (kill-new result)
      (message result))))

(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))

(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING.
FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (cl-loop for i from from to to do
             (insert (apply #'format format-string
                            (make-list (count-string-matches "%[^%]" format-string) i))
                     "\n")))
  (end-of-line))

(defun kill-word-at-point ()
  "単語上にカーソルがある時、その単語を削除する."
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\\t\\n -@\\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))

;; defadvice → define-advice (modern advice system)

(define-advice kill-region (:around (orig-fn beg end &rest args) kill-word-or-region)
  "選択範囲がなければ backward-kill-word する."
  (if (and (called-interactively-p 'interactive)
           transient-mark-mode
           (not mark-active))
      (backward-kill-word 1)
    (apply orig-fn beg end args)))

(define-advice quit-window (:around (orig-fn &optional _kill window) always-kill)
  "quit-window 時にバッファを常に kill する."
  (funcall orig-fn t window))

(defun finder-current-dir-open ()
  "カレントバッファを Finder で開く."
  (interactive)
  (shell-command "open ."))

(defun move-beginning-alt ()
  "`C-a' でインデント加味して行頭に移動."
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

;; next-buffer / previous-buffer で不要バッファをスキップ
(defvar skippable-buffers '("*Messages*" "*Help*" "*Shell Command Output*"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers."
  (interactive)
  (let ((start (current-buffer)))
    (next-buffer)
    (while (and (member (buffer-name) skippable-buffers)
                (not (eq (current-buffer) start)))
      (next-buffer))))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers."
  (interactive)
  (let ((start (current-buffer)))
    (previous-buffer)
    (while (and (member (buffer-name) skippable-buffers)
                (not (eq (current-buffer) start)))
      (previous-buffer))))

(global-set-key [remap next-buffer] #'my-next-buffer)
(global-set-key [remap previous-buffer] #'my-previous-buffer)

;;; init.el ends here
