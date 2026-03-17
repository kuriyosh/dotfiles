;;; init.el --- Emacs 30.x / macOS GUI  -*- lexical-binding: t; -*-

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
          tab-first-completion 'eol                   ; 行末でのみ補完を開始
          completion-auto-help 'lazy                  ; 補完候補ウィンドウの表示を控えめに
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
  (when (display-graphic-p)
    (pixel-scroll-precision-mode 1))  ; 高精度スクロール (トラックパッド向け・GUI専用)

  (when (fboundp 'editorconfig-mode)
    (editorconfig-mode 1))          ; .editorconfig を自動適用 (Emacs 30+)
  (when (fboundp 'which-key-mode)
    (which-key-mode 1))             ; プレフィックスキーの続き候補を表示 (Emacs 30+)

  (add-hook 'prog-mode-hook #'display-line-numbers-mode) ; プログラミング時に行番号表示
  (add-hook 'prog-mode-hook #'hs-minor-mode)             ; プログラミング時にコード折りたたみ有効化

  ;; scratch バッファーは削除させない
  (with-current-buffer "*scratch*"
    (emacs-lock-mode 'kill))

  ;; スクリプトファイルに実行権限を与えて保存
  (add-hook 'after-save-hook
            #'executable-make-buffer-file-executable-if-script-p)

  ;; スクリーンの大きさ調整 (GUI専用)
  (when (display-graphic-p)
    (set-frame-position (selected-frame) 0 0)
    (set-frame-size (selected-frame) 942 1024 t))

  ;; recentf の保存メッセージを抑制
  (advice-add 'recentf-cleanup   :around
              (lambda (fn &rest args) (let ((inhibit-message t)) (apply fn args))))
  (advice-add 'recentf-save-list :around
              (lambda (fn &rest args) (let ((inhibit-message t)) (apply fn args))))
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t #'recentf-save-list))) ; 30秒アイドルで自動保存

;; ===============================================================
;; macOS specific
;; ===============================================================

(when (eq system-type 'darwin)
  (setq mac-right-command-modifier 'hyper) ; 右コマンドキーを Hyper に
  (when (display-graphic-p)
    (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)) ; タイトルバーを透過
    (add-to-list 'default-frame-alist '(ns-appearance . dark))))      ; ダークモード外観

;; GUI Emacs on macOS は system clipboard と統合済み。
;; terminal Emacs 用の pbcopy/pbpaste ブリッジ。
(when (and (eq system-type 'darwin) (not (display-graphic-p)))
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))
  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx))

;; ===============================================================
;; Various Package Setting
;; ===============================================================

(use-package open-junk-file ; 日付付きの一時ファイルを素早く作成
  :bind ("C-x j" . open-junk-file)
  :custom
  (open-junk-file-format "~/junk/%Y-%m-%d-%H%M%S."))

(use-package markdown-mode) ; Markdown ファイルのメジャーモード

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
  (eval-after-load 'org-mode '(require 'smartparens-org))
  (show-smartparens-global-mode) ; 対応する括弧をハイライト
  (smartparens-global-mode))     ; 全バッファで有効化

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
         ("M-y"   . consult-yank-pop))) ; kill-ring からヤンク

(use-package embark ; 補完候補に対するアクションメニュー
  :bind (("C-." . embark-act)))

(use-package embark-consult ; Embark と Consult の連携
  :after (embark consult))

;; ===============================================================
;; In-buffer completion: Corfu + Cape + Tempel
;; ===============================================================

(use-package corfu ; バッファ内補完のポップアップ UI
  :init
  (global-corfu-mode 1))

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

(use-package treesit-auto ; tree-sitter grammar の自動管理・モード切り替え
  :vc (:url "https://github.com/renzmann/treesit-auto.git")
  :custom
  (treesit-auto-install 'prompt) ; grammar 未導入時にプロンプト表示
  :config
  (treesit-auto-add-to-auto-mode-alist 'all) ; 全言語で ts-mode を優先
  (global-treesit-auto-mode))

(use-package eglot ; LSP クライアント (補完・定義ジャンプ・診断等)
  :ensure nil
  :hook ((python-mode       . eglot-ensure)
         (python-ts-mode    . eglot-ensure)
         (go-mode           . eglot-ensure)
         (go-ts-mode        . eglot-ensure)
         (rust-mode         . eglot-ensure)
         (rust-ts-mode      . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode        . eglot-ensure)))

;; ===============================================================
;; Git
;; ===============================================================

(use-package magit ; Git の操作を Emacs 内で完結させる
  :bind ("C-x g" . magit-status))

;; ===============================================================
;; Theme
;; ===============================================================

(load-theme 'tsdh-dark t)

;; ===============================================================
;; Original Functions
;; ===============================================================

(defun my-put-file-name-on-clipboard ()
  "クリップボードにアクティブバッファのパスを格納."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

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

(define-advice kill-line (:before (&rest _) fixup)
  "kill-line 後に次の行のインデントを減らす."
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

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
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers."
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

(global-set-key [remap next-buffer] #'my-next-buffer)
(global-set-key [remap previous-buffer] #'my-previous-buffer)

;; ===============================================================
;; Key-bind
;; ===============================================================

(require 'bind-key)

(bind-key "M-d" 'kill-word-at-point)                                  ; カーソル上の単語を削除
(bind-key "M-g" 'goto-line)                                           ; 指定行へジャンプ
(bind-key "C-;" 'hs-toggle-hiding)                                    ; コードブロックの折りたたみ切替
(bind-key "C-h" 'delete-backward-char)                                ; Backspace として使用
(bind-key* "M-h" 'backward-kill-word)                                 ; 前方の単語を削除
(bind-key "C-M-l" 'hs-show-block)                                     ; コードブロックを展開
(bind-key "C-M-h" 'hs-hide-block)                                     ; コードブロックを折りたたむ
(bind-key "C-:" 'toggle-truncate-lines)                                ; 行の折り返し切替
(bind-key "M-n" (kbd "M-5 C-n"))                                      ; 5行下へ移動
(bind-key "M-p" (kbd "M-5 C-p"))                                      ; 5行上へ移動
(bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)   ; ミニバッファで前方単語削除
(bind-key "<f1>" 'read-only-mode)                                      ; 読み取り専用モード切替
(bind-key "C-a" 'move-beginning-alt)                                   ; インデント考慮の行頭移動
(bind-key "C-z" 'undo)                                                 ; 元に戻す
(bind-key "C-\\" 'undo-redo)                                           ; やり直し

(unbind-key "C-t")              ; プレフィックスとして解放
(unbind-key "C-q")              ; プレフィックスとして解放
(bind-key "C-q C-q" 'quoted-insert) ; 制御文字の直接入力

;;; init.el ends here
