;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; ===============================================================
;; Global Setting
;; ===============================================================
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; (let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH")))
;;   (exec-path-from-shell-copy-envs envs))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
          (expand-file-name (concat user-emacs-directory path))))
    (add-to-list 'load-path default-directory)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))))

(toggle-truncate-lines 1)

;;elispをPATHに設定
(add-to-load-path "elisp")
(add-to-load-path "elpa")

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))
;TODO: 起動にこの処理を反映させたいけどうまくいかない


;; Warningがうざいので出さない
(setq warning-minimum-level :error)

;; ビープ音がうるさい
(setq ring-bell-function 'ignore)

(load-theme 'badwolf t)

;; Mac用ちらつかせ防止
(setq redisplay-dont-pause nil)

;; コマンドの履歴を保存する
(setq desktop-globals-to-save '(extended-command-history))
(setq desktop-files-not-to-save "")
(desktop-save-mode 1)

;;終了時の確認
(setq confirm-kill-emacs 'y-or-n-p)

;;メニューバーを消す
(menu-bar-mode 0)

;;ツールバーを消す
(tool-bar-mode 0)

;;スクロールバーを消す
(scroll-bar-mode 0)

(setq truncate-partial-width-windows t)

;;起動時のメッセージを消す
(setq ihibit-startup-message t)

;;yes,noをy,nで回答可能にする
(defalias 'yes-or-no-p 'y-or-n-p)

;;自動インデントモード
(setq c-tab-always-indent nil)

;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)

;; スクリーンの最大化
(when (eq system-type 'darwin) ; Mac OS
  (set-frame-parameter nil 'fullscreen 'fullboth))

;;TABの表示幅　初期値は8
(setq-default tab-width 4)

;;対応する括弧を強調して表示する
(show-paren-mode 1)
(setq show-paren-delay 0) ;表示までの秒数
(show-paren-mode t) ;有効化
(setq show-paren-style 'mixed)

;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
(setq backup-directory-alist
      '((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
      '((".*" "~/.emacs.d/backups/" t)))

;; 自動ファイルリストとロックファイルは生成しない
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;;スクリプトファイルに実行権限を与えて保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; ===============================================================
;; Shell Setting
;; ===============================================================

;; fishをデフォルトシェルに
(defun skt:shell ()
  (or (executable-find "fish")
      (executable-find "bash")
      (error "can't find 'shell' command in PATH!!")))
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; ===============================================================
;; Language Setting
;; ===============================================================
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)

(when (eq system-type 'gnu/linux) ; Linux OS
  (set-frame-parameter nil 'fullscreen 'maximized)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "メイリオ"))

;; character code 設定
(set-keyboard-coding-system 'cp932)

(prefer-coding-system 'utf-8-unix)

(set-file-name-coding-system 'cp932)
(setq default-process-coding-system '(cp932 . cp932))

;; ===============================================================
;; Various Package Setting
;; ===============================================================

;; smartparen
(use-package smartparens
  :config
  (smartparens-global-mode t)
  (sp-pair "「" "」")
  (sp-pair "'" "'"))

;; smart mode line
(use-package smart-mode-line
  :config
  (sml/setup)
  (setq sml/no-confirm-load-theme t)
  (sml/apply-theme 'dark))

;;Elisp関数や変数をエコーエリアへ表示する(Elispmode時)
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
    (setq eldoc-idle-delay 0.2)
    (setq eldoc-echo-area-use-multiline-p t)
    (turn-on-eldoc-mode)))
;;elisp-mode-hookのON/OFF
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)


;; どっかからもらった関数で何してるのかわからん
(defun edit-category-table-for-company-dabbrev (&optional table)
  (define-category ?s "word constituents for company-dabbrev" table)
  (let ((i 0))
    (while (< i 128)
      (if (equal ?w (char-syntax i))
      (modify-category-entry i ?s table)
    (modify-category-entry i ?s table t))
      (setq i (1+ i)))))

(use-package company
  :init
  (setq company-idle-delay 0) ;デフォルトは0.5
  (setq company-minimum-prefix-length 1) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  (setq company-dabbrev-char-regexp "\\cs")
  :config
  (global-company-mode) ;全バッファで有効にする
  (edit-category-table-for-company-dabbrev)
  )

;;recentf-extの設定
(use-package recentf-ext
  :init
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  :config
  (recentf-mode 1)
  )


(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
             ))

;;; これがないとemacs -Qでエラーになる。おそらくバグ。
(require 'compile)

(setq TeX-parse-self t)  ; ファイルを開いた時に自動パース

;;yatexの設定
(setq auto-mode-alist
  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(add-hook 'yatex-mode-hook
         '(lambda ()
         (YaTeX-define-key "p" 'latex-math-preview-expression)
         (YaTeX-define-key "\C-p" 'latex-math-preview-save-image-file)
         (YaTeX-define-key "j" 'latex-math-preview-insert-symbol)
         (YaTeX-define-key "\C-j" 'latex-math-preview-last-symbol-again)
         (YaTeX-define-key "\C-b" 'latex-math-preview-beamer-frame)))
(setq latex-math-preview-in-math-mode-p-func 'YaTeX-in-math-mode-p)

;; seqの設定
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
    (loop for i from from to to do
          (insert (apply 'format format-string
                         (make-list (count-string-matches "%[^%]" format-string) i))
                  "\n")))
  (end-of-line))

;; shackleの設定
(use-package shackle
  :init
  (setq shackle-rules
      '(
        ("*helm mini*" :align below :ratio 0.5)
        ("*helm M-x*" :align below :ratio 0.5)
        ("*helm find files*" :align below :ratio 0.5)
        ("*Help*" :align below :ratio 0.5)
        ("*quickrun*" :align below :ratio 0.5)
        ))
  :config
  (shackle-mode 1))

;;Shellの設定
;; shellの文字化けを回避
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
            ))

;; autoinsertの設定
(use-package autoinsert
  :init
  (setq auto-insert-directory "~/.emacs.d/template/")
  :config
  (setq auto-insert-alist
        (nconc '(
                 ("\\.cpp$" . ["template.cpp" my-template])
                 ("\\.py$"   . ["template.py" my-template])
                 ("\\.org$"   . ["template.org" my-template])
                 ("\\.tex$"   . ["template.tex" my-template])
                 ("\\.js$"   . ["template.js" my-template])
                 ) auto-insert-alist))
  (add-hook 'find-file-not-found-hooks 'auto-insert) ;; HACK: :hookの中に入れたほうがきれい
  )

(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%time%" . (lambda () (format-time-string "%Y-%m-%d")))
    ("%mtg-timeformat%" . (lambda () (format-time-string "%m%d")))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))
(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

;;undohistの設定
(use-package undohist
  :config
  (undohist-initialize))

(use-package whitespace
  :init
  (setq whitespace-style
        '(
          face ; faceで可視化
          trailing ; 行末
          tabs ; タブ
          spaces ; スペース
          space-mark ; 表示のマッピング
          tab-mark
          ))
  (setq whitespace-display-mappings
        '(
          (space-mark ?\u3000 [?\u2423])
          (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
          ))
  (setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")
  (setq whitespace-space-regexp "\\(\u3000+\\)")
  (setq whitespace-action '(auto-cleanup))
  :config
  (global-whitespace-mode)
  (set-face-attribute 'whitespace-trailing nil
                      :foreground "RoyalBlue4"
                      :background "RoyalBlue4"
                      :underline nil)
  (set-face-attribute 'whitespace-tab nil
                      :foreground "yellow4"
                      :background "yellow4"
                      :underline nil)
  (set-face-attribute 'whitespace-space nil
                      :foreground "gray40"
                      :background "gray20"
                      :underline nil)
  )

(use-package emmet-mode
  :init
  (setq emmet-indentation 2)
  :bind
  (:map emmet-mode-keymap
        ("C-j" . nil)
        ("<tab>" . indent-for-tab-command)
        ("C-i" . emmet-expand-line)
    )
  :hook
  (sgml-mode web-mode css-mode-hook)
  )

;;web-modeの設定
(use-package web-mode
  :bind
  (:map web-mode-map
        ("C-x i" . my-wrap-lines-with-html-tag))
  :config
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  ;; auto tag closing
  ;; 0=no auto-closing
  ;; 1=auto-close with </
  ;; 2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
  :mode ("\\.html?$")
  )

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode)) ;本当はjs2-modeにしたいけど重すぎる
;; (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))

;; この関数なんで追加したかまじで忘れた
;; (defun my-wrap-lines-with-html-tag ($tag)
;;   (interactive "sTag: ")
;;   (if (and mark-active transient-mark-mode)
;;       (shell-command-on-region
;;        (region-beginning) (region-end)
;;        (concat "perl -0 -p -w -e \'"
;;                "s/^([^\\S\\r\\n]*)(\\S.*?)[^\\S\\r\\n]*$/$1<"
;;                $tag ">$2<\\/" $tag ">/gm\'")
;;        nil t)))


;;org-modeの設定
(setq org-startup-truncated nil)
(setq org-startup-with-inline-images t)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(setq org-agenda-files '("~/Dropbox/org/todo.org"))
;; org-captureで2種類のメモを扱うようにする
(setq org-capture-templates
      '(("t" "New TODO" entry
         (file+headline "~/Dropbox/org/todo.org" "予定")
         "* TODO %?\n\n")
        ("m" "Memo" entry
         (file+headline "~/Dropbox/org/memo.org" "メモ")
         "* %U%?\n%i\n%a")))
;; org-agendaでaを押したら予定表とTODOリストを表示
(setq org-agenda-custom-commands
      '(("a" "Agenda and TODO"
         ((agenda "")
          (alltodo "")))))
;; TODO・予定用のファイルのみ指定
;; TODOリストに日付つきTODOを表示しない
;; (setq org-agenda-todo-ignore-with-date t)
;; 今日から予定を表示させる
(setq org-agenda-start-on-weekday nil)

(use-package org-bullets
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

;;flycheckの設定
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'japanese-latex-mode-hook (lambda () (flycheck-mode nil)))
(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
    ))

;; helmの設定
(use-package helm
  :config
  (helm-mode 1)
  :bind
  (:map helm-map
        ("C-z" . helm-select-action)
  :map helm-find-files-map
        ("<tab>" . helm-execute-persistent-action)
  :map helm-read-file-map
        ("<tab>" . helm-execute-persistent-action))
  )

;;helm-flycheckの設定
(use-package helm-flycheck
  :bind
  (:map flycheck-mode-map
        ("C-c ! h" . helm-flycheck))
  )

;; redo+の設定
(use-package redo+
  :bind ("C-/" . redo))

;; hl-line+の設定
(use-package hl-line+
  :init
  (setq hl-line-idle-interval 2)
  :config
  (toggle-hl-line-when-idle)
  (set-face-background 'hl-line "firebrick")
  )

(use-package yasnippet
  :bind
  (:map yas-keymap
        ("<tab>" . nil))
  :config
  (yas-global-mode 1)
  (push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
  )


(use-package helm-c-yasnippet
  :init
  (setq helm-yas-space-match-any-greedy t)
  :bind
  ("C-c y" . helm-yas-complete)
  )


(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")
(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

;; hs-modeの設定
(add-hook 'c++-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'c-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'lisp-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'python-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'js2-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;; (use-package
;;   :config
;;   (add-hook 'before-save-hook 'py-autopep8-before-save)
;;   )

;; ===============================================================
;; js-mode
;; ===============================================================
(use-package js2-mode
  :init
  (setq js2-idle-timer-delay 2)
  )

;; ===============================================================
;; C/C++ setting
;; ===============================================================
(defun my-c-c++-mode-init ()
  (setq c-tab-always-indent t)
  (setq c-auto-newline t)
  (setq c-hungry-delete-key t)
  (setq indent-tabs-mode t)
  (c-toggle-auto-hungry-state -1)
  (setq c-basic-offset 4))
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)


;; ironyがあまりにも重いので使わない
;; (require 'irony)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-to-list 'company-backends 'company-irony) ; backend追加

;; ignoramusの設定
;; TODO: helm-miniで無視されないので使う価値を感じない
;; (require 'dired-x)
;; (require 'ignoramus)
;; (defun ignoramus-do-ignore-helm ()
;;   "Tell `helm-mini' to ignore unwanted files."
;;   (setq helm-source-buffers-list (list ignoramus-boring-file-regexp)))
;; (ignoramus-setup)



;; ===============================================================
;; Key-bind (necessary bind-key.el)
;; ===============================================================
(require 'bind-key)
(bind-key "C-z" 'undo)
(bind-key "M-[" 'replace-string)
(bind-key* "C-t h" 'windmove-left)
(bind-key* "C-t j" 'windmove-down)
(bind-key* "C-t k" 'windmove-up)
(bind-key* "C-t l" 'windmove-right)
(bind-key* "C-t -" 'split-window-below)
(bind-key* "C-t |" 'split-window-right)
(bind-key* "C-S-<tab>" 'prev-window)
(bind-key "M-n" (kbd "C-u 5 C-n"))
(bind-key "M-p" (kbd "C-u 5 C-p"))
(bind-key "M-g" 'goto-line)
(bind-key "C-m" 'newline-and-indent)
(bind-key "C-x C-r" 'helm-mini)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "M-w" 'easy-kill)
(bind-key "M-y" 'helm-show-kill-ring)
(bind-key "C-x j" 'open-junk-file)
(bind-key "M-x" 'helm-M-x)
(bind-key "C-;" 'hs-toggle-hiding)
(bind-key "C-h" 'delete-backward-char)
(bind-key  "C-x :" 'toggle-truncate-lines)
(bind-key*  "M-h" 'backward-kill-word)
(bind-key* "C-," 'goto-last-change)
(bind-key* "C-." 'goto-last-change-reverse)
(bind-key "C-M-l" 'hs-show-block)
(bind-key "C-M-h" 'hs-hide-block)

(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (interactive-p) transient-mark-mode (not mark-active))
      (backward-kill-word 1)
    ad-do-it))

(bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)

;; C-kのkill-line後に次の行のインデントを少なくする
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

(define-key company-active-map (kbd "M-n") nil)
(define-key company-active-map (kbd "M-p") nil)
(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
;; HACK: 何故か2度呼び出すとうまくいくから書いてる。ちなみに上のやつ消してもだめ、絶対2回
(exec-path-from-shell-initialize)

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "36619802ccdb9e68a21f11c9baa30d86e25fd46635e48605399bf1cc2689cf39" "d577e33443b26fd3f3c6840ddf8c7aeae0d948b7da4924a8a0c85b38831d54cc" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" default)))
 '(flycheck-disabled-checkers (quote (javascript-jshint javascript-jscs)))
 '(org-agenda-files
   (quote
	("~/Documents/Reading/Presentation/NS201803/memo.org" "~/Dropbox/org/todo.org")) t)
 '(package-selected-packages
   (quote
	(multiple-cursors js3-mode use-package ignoramus js2-refactor js2-mode shackle auctex helm-tramp powerline spacemacs-theme company goto-chg js-doc smartparens elscreen madhat2r-theme markdown-mode latex-math-preview request exec-path-from-shell magit yatex rainbow-mode emmet-mode mozc-popup hide-comnt open-junk-file google-translate helm-flycheck web-mode multi-term flymake-cppcheck undo-tree undohist flycheck-irony flycheck quickrun helm recentf-ext pdf-tools bind-key))))

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "yellow1"))))
 '(helm-buffer-directory ((t (:foreground "DarkRed"))))
 '(helm-ff-directory ((t (:foreground "Orange")))))

