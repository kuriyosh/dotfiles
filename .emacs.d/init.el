;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; ===============================================================
;; Global Setting
;; ===============================================================
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

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

(exec-path-from-shell-initialize)

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

;;TABの表示幅　初期値は８
(setq-default tab-width 4)

;;対応する括弧を強調して表示する
(show-paren-mode 1)
(setq show-paren-delay 0) ;表示までの秒数
(show-paren-mode t) ;有効化
(setq show-paren-style 'mixed)

;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
(add-to-list 'backup-directory-alist
			 (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
	  `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

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
(require 'smartparens-config)
(smartparens-global-mode t)
(sp-pair "「" "」")
(sp-pair "'" "'")

;; smart mode line
(require 'smart-mode-line)
(sml/setup)
(setq sml/no-confirm-load-theme t)
(sml/apply-theme 'dark)

;;Elisp関数や変数をエコーエリアへ表示する(Elispmode時)
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))
;;elisp-mode-hookのON/OFF
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)


(require 'company)
(global-company-mode) ;全バッファで有効にする
(setq company-idle-delay 0) ;デフォルトは0.5
(setq company-minimum-prefix-length 1) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(defun edit-category-table-for-company-dabbrev (&optional table)
  (define-category ?s "word constituents for company-dabbrev" table)
  (let ((i 0))
    (while (< i 128)
      (if (equal ?w (char-syntax i))
      (modify-category-entry i ?s table)
    (modify-category-entry i ?s table t))
      (setq i (1+ i)))))
(edit-category-table-for-company-dabbrev)
;; (add-hook 'TeX-mode-hook 'edit-category-table-for-company-dabbrev) ; 下の追記参照
(setq company-dabbrev-char-regexp "\\cs")

;;recentf-extの設定
(require 'recentf-ext)
(when (require 'recentf-ext nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))

;; bmの設定
(setq-default bm-buffer-persistence)
(setq bm-restore-repository-on-load t)
(require 'bm)
(add-hook 'find-file-hook 'bm-buffer-restore)
(add-hook 'kill-buffer-hook 'bm-buffer-save)
(add-hook 'after-save-hook 'bm-buffer-save)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-buffer-save-all)
                              (bm-repository-save)))
(global-set-key (kbd "M-SPC") 'bm-toggle)
(global-set-key (kbd "M-[") 'bm-previous)
(global-set-key (kbd "M-]") 'bm-next)

(require 'goto-chg)

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

;;popwinの設定
;; (require 'popwin)
;; (setq special-display-function 'popwin:special-display-popup-window)
;; (setq popwin:popup-window-position 'bottom)
;; (setq display-buffer-function 'popwin:display-buffer)

;; shackleの設定
(require 'shackle)
(setq shackle-rules
	  '(
        ("*helm mini*" :align below :ratio 0.5)
		("*helm M-x*" :align below :ratio 0.5)
		("*helm find files*" :align below :ratio 0.5)
		("*Help*" :align below :ratio 0.5)
		("*quickrun*" :align below :ratio 0.5)
        ))
(shackle-mode 1)




;;Shellの設定
;; shellの文字化けを回避
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
            ))

;; autoinsertの設定
(require 'autoinsert)
(setq auto-insert-directory "~/.emacs.d/template/")
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . ["template.cpp" my-template])
               ("\\.py$"   . ["template.py" my-template])
			   ("\\.org$"   . ["template.org" my-template])
			   ("\\.tex$"   . ["template.tex" my-template])
			   ("\\.js$"   . ["template.js" my-template])
               ) auto-insert-alist))
(require 'cl)
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
(add-hook 'find-file-not-found-hooks 'auto-insert)

;;undohistの設定
(require 'undohist)
(undohist-initialize)

;;web-modeの設定
(require 'web-mode)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'web-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; CSSにも使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs))
    ))
;; (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))
(defun my-wrap-lines-with-html-tag ($tag)
  (interactive "sTag: ")
  (if (and mark-active transient-mark-mode)
      (shell-command-on-region
       (region-beginning) (region-end)
       (concat "perl -0 -p -w -e \'"
               "s/^([^\\S\\r\\n]*)(\\S.*?)[^\\S\\r\\n]*$/$1<"
               $tag ">$2<\\/" $tag ">/gm\'")
       nil t)))

(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; indent
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  ;; auto tag closing
  ;0=no auto-closing
  ;1=auto-close with </
  ;2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
)
(add-hook 'web-mode-hook 'web-mode-hook)

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

(when (require 'org-bullets nil t)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;;flycheckの設定
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'japanese-latex-mode-hook (lambda () (flycheck-mode nil)))
(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;;helm-flycheckの設定
(require 'helm-flycheck) ;; Not necessary if using ELPA package
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

;; redo+の設定
(when (require 'redo+ nil t)
  (setq undo-no-redo t)
  (global-set-key (kbd "C-/") 'redo))

;; hl-line+の設定
(require 'hl-line+)
(toggle-hl-line-when-idle)
(setq hl-line-idle-interval 3)
(set-face-background 'hl-line "firebrick")

(require 'yasnippet)
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)
(eval-after-load "yasnippet"
  '(progn
     ;; companyと競合するのでyasnippetのフィールド移動は "C-i" のみにする
     (define-key yas-keymap (kbd "<tab>") nil)
     (yas-global-mode 1)))

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
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

(when (require 'py-autopep8 nil t)
  (add-hook 'before-save-hook 'py-autopep8-before-save))

;; ===============================================================
;; Key-bind (necessary bind-key.el)
;; ===============================================================
(require 'bind-key)
(bind-key "C-z" 'undo)
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
(bind-key  "C-x i" 'my-wrap-lines-with-html-tag web-mode-map)
(bind-key  "C-x :" 'toggle-truncate-lines)
(bind-key*  "M-h" 'backward-kill-word)
(bind-key* "C-," 'goto-last-change)
(bind-key* "C-." 'goto-last-change-reverse)
(bind-key "<tab>" 'indent-for-tab-command emmet-mode-keymap)
(bind-key "C-i" 'emmet-expand-line emmet-mode-keymap)

;; TODO: 単語の末尾の時、現状その単語の次の単語を削除しているが、その前の単語を削除するように変更したい
;; defadviceの中でinteractive-pをするとWarningが出るので別関数で定義
(defvar kill-region-interactive-p
  (if (fboundp 'called-interactively-p)
      (lambda () (called-interactively-p 'interactive))
    'interactive-p))

(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (funcall kill-region-interactive-p) transient-mark-mode (not mark-active))
	  (let ((char (char-to-string (char-after (point)))))
        (cond
         ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
         (t (forward-char) (backward-word) (kill-word 1))))
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

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "36619802ccdb9e68a21f11c9baa30d86e25fd46635e48605399bf1cc2689cf39" "d577e33443b26fd3f3c6840ddf8c7aeae0d948b7da4924a8a0c85b38831d54cc" "604648621aebec024d47c352b8e3411e63bdb384367c3dd2e8db39df81b475f5" default)))
 '(org-agenda-files
   (quote
	("~/Documents/Reading/Presentation/NS201803/memo.org" "~/Dropbox/org/todo.org")) t)
 '(package-selected-packages
   (quote
	(js2-mode shackle auctex helm-tramp powerline spacemacs-theme company goto-chg js-doc smartparens elscreen bm madhat2r-theme markdown-mode latex-math-preview request exec-path-from-shell magit yatex rainbow-mode emmet-mode mozc-popup hide-comnt open-junk-file google-translate helm-flycheck web-mode multi-term flymake-cppcheck undo-tree undohist flycheck-irony flycheck quickrun helm recentf-ext pdf-tools bind-key))))

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "#AAA"))))
 '(helm-buffer-directory ((t (:foreground "DarkRed"))))
 '(helm-ff-directory ((t (:foreground "Orange")))))
