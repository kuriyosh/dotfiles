;; ;; Added by Package.el.  This must come before configurations of;
;; installed packages.  Don't delete this line.  If you don't want it,; ;; just

;; ;; You may delete these explanatory comments.

;; ;; ===============================================================
;; ;; Package Setting
;; ;; ===============================================================

(require 'package)

;; list the repositories containing them
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)

; activate all the packages (in particular autoloads)
(package-initialize)

;; ;; ===============================================================
;; ;; Global Setting
;; ;; ===============================================================

;; elispをPATHに設定
(add-to-list 'load-path "~/.emacs.d/elisp/")

(setq default-directory "~/")
;;(toggle-truncate-lines 1)

;; [Mac専用] 右コマンドをhyperキーに変更する
(when (eq system-type 'darwin)
  (setq mac-right-command-modifier 'hyper))

;; Warningがうるさいので出さない
(setq warning-minimum-level :error)

;; 分割したwindowで行の折り返しを
(setq truncate-partial-width-windows nil)

;; ビープ音がうるさい
(setq ring-bell-function 'ignore)

;; タイトルバーの色を変更
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;; カーソルの点滅を止める
(blink-cursor-mode 0)

;;メニューバーを消す
(menu-bar-mode 0)

;;ツールバーを消す
(tool-bar-mode 0)

;; 選択範囲を上書き
(delete-selection-mode t)

;;起動時のメッセージを消す
(setq ihibit-startup-message t)

;;yes,noをy,nで回答可能にする
(defalias 'yes-or-no-p 'y-or-n-p)

;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)

;; スクリーンの大きさ調整 画面の半分くらいに変更
(setq frame-resize-pixelwise t)
(set-frame-position (selected-frame) 0 0)
(set-frame-size (selected-frame) 942 1024 t)

;;TABの表示幅 初期値は8
(setq-default tab-width 4)

;; tab はスペースに置き換える
(setq-default indent-tabs-mode nil)

;; tab 幅はデフォルトは 2 スペース分
(setq-default tab-width 2)

;;対応する括弧を強調して表示する
(show-paren-mode 1)
(setq show-paren-delay 0) ;表示までの秒数
(setq show-paren-style 'mixed)

;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
(setq backup-directory-alist
      (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
			backup-directory-alist))
(setq auto-save-file-name-transforms
      `((".*", (expand-file-name "~/.emacs.d/backup/") t)))

;; ファイルをゴミ箱に移動させる
(setq trash-directory "~/.Trash")
(setq delete-by-moving-to-trash t)

;; 自動ファイルリストとロックファイルは生成しない
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; scratchバッファーについては削除させない
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))

;;スクリプトファイルに実行権限を与えて保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; TODO: macos に関する設定だけ取り出して別ファイルでも良いかもしれない
(if (eq system-type 'darwin)
    (progn
      (defun copy-from-osx ()
        (shell-command-to-string "pbpaste"))
      (defun paste-to-osx (text &optional push)
      (let ((process-connection-type nil))
	    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	      (process-send-string proc text)
    	  (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
    )
    (message "This platform is not mac"))

;; ;; ===============================================================
;; ;; Various Package Setting
;; ;; ===============================================================

;; open-junk-file
(use-package open-junk-file
  :ensure t
  :config
  (setq open-junk-file-format "~/junk/%Y-%m-%d-%H%M%S.")
  :bind
  ("C-x j" . open-junk-file))

;; theme
(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package markdown-mode :ensure t)

;; https://github.com/emacs-helm/helm/issues/2683
(defvar helm-ff-edit-marked-files-fn #'helm-ff-wfnames)

(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("C-x C-r" . helm-mini)
)

;; logview
(use-package logview
  :mode
  ("\\.log$" . logview-mode))

;; smartparen
(use-package smartparens
  :ensure t
  :config
  (sp-pair "「" "」")
  (sp-pair "【" "】")
  (sp-pair "'" "'")
  (progn
    (require 'smartparens-config)
    (sp-local-pair 'org-mode "$" "$")
    (eval-after-load 'org-mode     '(require 'smartparens-org))
    (show-smartparens-global-mode)
    (smartparens-global-mode)))

;; recentfの設定
(use-package recentf
  :ensure t
  :init
  (setq recentf-auto-cleanup 60)
  (setq recentf-exclude '(".recentf" "COMMIT_EDITMSG" "/.?TAGS" "^/sudo:" ".emacs.d/games/*-scores" "output-html/*"))
  (setq recentf-auto-save-timer
		(run-with-idle-timer 60 t 'recentf-save-list))
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (setq recentf-max-saved-items 2000)

  ;; recentf の メッセージをエコーエリア(ミニバッファ)に表示しない
  ;; (*Messages* バッファには出力される)
  (defun recentf-save-list-inhibit-message:around (orig-func &rest args)
	(setq inhibit-message t)
	(apply orig-func args)
	(setq inhibit-message nil)
	'around)
  :config
  (recentf-mode 1)

  (advice-add 'recentf-cleanup   :around 'recentf-save-list-inhibit-message:around)
  (advice-add 'recentf-save-list :around 'recentf-save-list-inhibit-message:around))

;; multiple-cursorsの設定
(use-package multiple-cursors
  :ensure t
  :bind
  ("C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this-symbol)
  ("C-<" . mc/mark-previous-like-this-symbol)
  ("C-c C-<" . mc/mark-all-like-this))

;; ===============================================================
;; Original Function
;; ===============================================================
(defun my-put-file-name-on-clipboard ()
  "クリップボードにアクティブバッファのパスを格納"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

;; seq の設定
(defun count-string-matches (regexp string)
  (with-temp-buffer
    (insert string)
    (count-matches regexp (point-min) (point-max))))

(defun seq (format-string from to)
  "Insert sequences with FORMAT-STRING. FORMAT-STRING is like `format', but it can have multiple %-sequences."
  (interactive
   (list (read-string "Input sequence Format: ")
         (read-number "From: " 1)
         (read-number "To: ")))
  (save-excursion
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

(defun kill-word-at-point ()
  "単語上にカーソルがある時、実行されるとその単語を削除する関数"
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))

(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (backward-kill-word 1) ad-do-it))

;; C-kのkill-line後に次の行のインデントを少なくする
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; macox 専用
(defun finder-current-dir-open()
  "カレントバッファを finder で開く"
  (interactive)
  (shell-command "open ."))

(defun move-beginning-alt()
  " `C-a' でインデント加味して行頭に移動"
  (interactive)
  (if (bolp)
      (back-to-indentation)
    (beginning-of-line)))

;; `next-buffer' `before-buffer' について、閲覧する必要がないbufferをスキップする
(setq skippable-buffers '("*Messages*" "*Help*" "*Shell Command Output*" "shell-pop-?"))

(defun my-next-buffer ()
  "next-buffer that skips certain buffers"
  (interactive)
  (next-buffer)
  (while (member (buffer-name) skippable-buffers)
    (next-buffer)))

(defun my-previous-buffer ()
  "previous-buffer that skips certain buffers"
  (interactive)
  (previous-buffer)
  (while (member (buffer-name) skippable-buffers)
    (previous-buffer)))

(global-set-key [remap next-buffer] 'my-next-buffer)
(global-set-key [remap previous-buffer] 'my-previous-buffer)

;; `quit-window' でwindowsを消した時に、bufferを自動で消す
(defadvice quit-window (before quit-window-always-kill)
  (ad-set-arg 0 t))
(ad-activate 'quit-window)

;; ===============================================================
;; Key-bind (necessary bind-key.el)
;; ===============================================================
(require 'bind-key)

;; 一般的に使うプレフィックスなしキーバインド
(bind-key "M-[" 'replace-string)
(bind-key "M-d" 'kill-word-at-point)
(bind-key "M-g" 'goto-line)
;; (bind-key "M-w" 'easy-kill)
(bind-key "C-;" 'hs-toggle-hiding)
(bind-key "C-h" 'delete-backward-char)
(bind-key* "M-h" 'backward-kill-word)
(bind-key* "C-," 'goto-last-change)
(bind-key* "C-." 'goto-last-change-reverse)
(bind-key "C-M-l" 'hs-show-block)
(bind-key "C-M-h" 'hs-hide-block)
(bind-key "C-:" 'toggle-truncate-lines)
(bind-key "M-n" (kbd "M-5 C-n"))
(bind-key "M-p" (kbd "M-5 C-p"))
(bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)
(unbind-key "C-\\")				 ;Emacsのレイヤーで日本語の入力サポートされたくない
(bind-key "<f1>" 'read-only-mode)
(bind-key "<f9>" 'org-to-md-for-case)
(bind-key "C-a" 'move-beginning-alt)
(bind-key "C-z" 'undo)
(bind-key "C-\\" 'undo-redo)
(unbind-key "M-[")

;; window系とterminal系は共通のプレフィックス `C-t'
(unbind-key "C-t")

(unbind-key "C-q")
(bind-key "C-q C-q" 'quoted-insert)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(open-junk-file smartparens multiple-cursors dracula-theme doom-modeline)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
