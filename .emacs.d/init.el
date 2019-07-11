;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; TODO: abbrevいらないのでは？

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

(use-package smart-newline
  ;; 本当は:hookで書きたかったのに何故かばぐるのでこう書いた
  :init
  ;; (add-hook 'org-mode-hook
  ;;           (lambda ()
  ;;             (smart-newline-mode t)))
  )

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
			  (expand-file-name (concat user-emacs-directory path))))
		(add-to-list 'load-path default-directory)
		(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
			(normal-top-level-add-subdirs-to-load-path))))))

(toggle-truncate-lines 1)

;; Mac専用右コマンドをhyperキーに変更する
(when (eq system-type 'darwin)
  (setq mac-right-command-modifier 'hyper))

(use-package subword
  :diminish subword-mode
  :config
  (add-hook 'prog-mode-hook (lambda () (subword-mode 1))))

;;elispをPATHに設定
(add-to-load-path "elisp")
(add-to-load-path "elpa")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

;; (use-package exec-path-from-shell
;;   :config
;;   (exec-path-from-shell-initialize))
;;                                         ;TODO: 起動にこの処理を反映させたいけどうまくいかない

;; Warningがうざいので出さない
(setq warning-minimum-level :error)

;; 分割したwindowで行の折り返しを
(setq truncate-partial-width-windows nil)

;; ビープ音がうるさい
(setq ring-bell-function 'ignore)

;; (load-theme 'badwolf t)
(load-theme 'dracula t)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; assuming you are using a dark theme

;; カーソルの点滅を止める
(blink-cursor-mode 0)

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

;; 選択範囲を上書き
(delete-selection-mode t)

;;スクロールバーを消す
(scroll-bar-mode 0)

;;起動時のメッセージを消す
(setq ihibit-startup-message t)

;;yes,noをy,nで回答可能にする
(defalias 'yes-or-no-p 'y-or-n-p)

;;自動インデントモード
(setq c-tab-always-indent nil)

;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)

;; スクリーンの最大化
;; (when (eq system-type 'darwin) ; Mac OS
;;   (set-frame-parameter nil 'fullscreen 'fullboth))
(setq frame-resize-pixelwise t)
(set-frame-position (selected-frame) 0 0)
(set-frame-size (selected-frame) 942 1024 t)

;;TABの表示幅 初期値は8
(setq-default tab-width 4)

;;対応する括弧を強調して表示する
(show-paren-mode 1)
(setq show-paren-delay 0) ;表示までの秒数
(show-paren-mode t) ;有効化
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

(use-package text-adjust)

;; 自動ファイルリストとロックファイルは生成しない
(setq auto-save-list-file-prefix nil)
(setq create-lockfiles nil)

;; scratchバッファーについては削除させない
(with-current-buffer "*scratch*"
  (emacs-lock-mode 'kill))

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
(setenv "LANG" "ja_JP.UTF-8")
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

(setq default-cursor-in-non-selected-windows nil)

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
  (sp-pair "【" "】")
  (sp-pair "'" "'"))

;; newtree
(use-package neotree
  :commands (projectile)
  :init
  (setq neo-show-hidden-files t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :config
  (projectile-global-mode)
  :bind
  ("<f8>" . 'neotree-projectile-action)
  )

(use-package spaceline
  :demand t
  :init
  (setq ns-use-srgb-colorspace nil)
  (setq-default powerline-default-separator 'slant)
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  (spaceline-helm-mode))

(setq ispell-program-name "aspell")

(use-package avy
  :init
  (setq avy-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l ?w ?e ?r ?t ?u ?i ?o ?v ?c ?n ?m))
  (setq avy-style 'at-full)
  (setq avy-background t)
  (setq avy-all-windows nil)
  (setq avy-timeout-seconds 0.4)
  :bind
  ("C-o" . 'avy-goto-word-1)
  ("C-S-o" . 'avy-goto-char-timer)
  ("C-S-l" . 'avy-goto-line)
  )

(use-package company
  :init
  (setq company-idle-delay 0) ; デフォルトは0.5
  (setq company-minimum-prefix-length 1) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
  ;; (setq company-dabbrev-char-regexp "\\cs")
  (setq company-dabbrev-downcase nil)	;string内で大文字と小文字の区別を行う
  :config
  (add-hook 'prog-mode-hook 'company-mode)
  ;; (edit-category-table-for-company-dabbrev)
  (setq company-backends (delete 'company-semantic company-backends))
  )

(use-package diminish
  ;; 各use-package`:diminish'で設定できるのでそっちの方が良いかも
  :config
  (eval-after-load "company"
	'(diminish 'company-mode "Ⓒ"))
  (eval-after-load "yasnippet"
	'(diminish 'yas-minor-mode "Ⓨ"))
  (eval-after-load "flycheck"
	'(diminish 'flycheck-mode "Ⓕ"))
  (eval-after-load "helm-mode"
	'(diminish 'helm-mode "Ⓗ"))
  (eval-after-load "whitespace"
	'(diminish 'global-whitespace-mode "Ⓦ"))
  (eval-after-load "smartparens"
	'(diminish 'smartparens-mode "Ⓢ"))
  (eval-after-load "ace-isearch"
	'(diminish 'ace-isearch-mode "Ⓐ"))
  (eval-after-load "hideshow"
	'(diminish 'hs-minor-mode ""))
  (diminish 'auto-revert-mode "")
  (diminish 'eldoc-mode "")
  (diminish 'smart-newline-mode "")
  )

(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode)
     :config
     (setq doom-modeline-bar-width 3)
     (setq doom-modeline-height 20)
     (setq doom-modeline-icon t)
     (setq doom-modeline-minor-modes t))

(use-package company-c-headers
  :config
  (add-to-list 'company-backends 'company-c-headers)
                                        ;TODO: 以下環境依存な部分もあるため、環境毎に対応させる必要
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0/x86_64-apple-darwin17.7.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include/c++/8.2.0/x86_64-apple-darwin17.7.0")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin17.7.0/8.2.0/include")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/include")
  (add-to-list 'company-c-headers-path-system "/usr/local/Cellar/gcc/8.2.0/lib/gcc/8/gcc/x86_64-apple-darwin17.7.0/8.2.0/include-fixed")
  (add-to-list 'company-c-headers-path-system "/System/Library/Frameworks")
  (add-to-list 'company-c-headers-path-system "/Library/Frameworks"))

;;recentf-extの設定
(use-package recentf-ext
  :init
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  :config
  (recentf-mode 1))

(require 'multi-term)
(defun term-send-forward-char ()
  (interactive)
  (term-send-raw-string "\C-f"))
(defun term-send-backward-char ()
  (interactive)
  (term-send-raw-string "\C-b"))
(defun term-send-previous-line ()
  (interactive)
  (term-send-raw-string "\C-p"))
(defun term-send-next-line ()
  (interactive)
  (term-send-raw-string "\C-n"))
(add-hook 'term-mode-hook
          '(lambda ()
             (let* ((key-and-func
                     `(("\C-p"           term-send-previous-line)
                       ("\C-n"           term-send-next-line)
                       ("\C-b"           term-send-backward-char)
                       ("\C-f"           term-send-forward-char)
                       (,(kbd "C-y")     term-paste)
                       (,(kbd "ESC ESC") term-send-raw)
                       (,(kbd "C-S-p")   multi-term-prev)
                       (,(kbd "C-S-n")   multi-term-next)
                       ;; 利用する場合は
                       ;; helm-shell-historyの記事を参照してください
                       ;; ("\C-r"           helm-shell-history)
                       )))
               (loop for (keybind function) in key-and-func do
                     (define-key term-raw-map keybind function)))))


(add-hook 'c++-mode-hook
          '(lambda()
             (c-set-style "stroustrup")
             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
             ))

;;; これがないとemacs -Qでエラーになる。おそらくバグ。
(require 'compile)

(use-package dumb-jump
  :init
  (setq dumb-jump-default-project "")
  (setq dumb-jump-force-searcher 'ag))

;; auctexの設定
(use-package auctex
  :after (tex reftex)
  :ensure t
  :config
  (setq TeX-default-mode 'japanese-latex-mode)
  (setq japanese-LaTeX-default-style "jarticle")
  (setq TeX-engine-alist '((ptex "pTeX" "eptex" "platex" "eptex")
						   (jtex "jTeX" "jtex" "jlatex" nil)
						   (uptex "upTeX" "euptex" "uplatex" "euptex")))
  (setq TeX-engine 'uptex)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq reftex-plug-into-AUCTeX t)
  (setq-default TeX-master nil)
  (add-hook 'japanese-latex-mode-hook (lambda () (flycheck-mode nil)))
  :bind
  ("C-c r" . reftex-reference)
  ("C-c l" . reftex-label)
  ("C-c c" . reftex-citation))

(add-hook 'LaTeX-mode-hook 'turn-on-reftex) ;auctexの中に入れたいけど何故か機能しない

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

;; multiple-cursorsの設定
(use-package multiple-cursors
  :bind
  ("C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this-symbol)
  ("C-<" . mc/mark-previous-like-this-symbol)
  ("C-c C-<" . mc/mark-all-like-this)
  )

;; shackleの設定
;;TODO: shackleの方が優秀なのかもしれない(https://qiita.com/fujimotok/items/164cd80b89992eeb4efe)
;;TODO: https://github.com/shibayu36/emacs/commit/f096b0ef2698b13a9afa75df588d40695e26b18e
(use-package popwin
  :after (helm)
  :config
  (popwin-mode 1)
  (setq helm-display-function #'display-buffer)
  (setq popwin:special-display-config
    '(("*complitation*" :noselect t)
      ("helm" :regexp t :height 0.4)
	  ))
  (push '("*Agenda Commands*" :regexp t) popwin:special-display-config)
  (push '("^\*Org Agenda*" :regexp t :height 0.4) popwin:special-display-config)
  )

;; (use-package shackle
;;   :init
;;   (setq shackle-rules
;; 		'(
;;           ("*helm mini*" :popup t :align below :ratio 0.5)
;; 		  ("*Helm Swoop*" :popup t :align below :ratio 0.3)
;;           ("*helm M-x*" :popup t :align below :ratio 0.5)
;;           ("*helm find files*" :popup t :align below :ratio 0.5)
;;           ("*Help*" :popup t :align below :ratio 0.5)
;;           ("*quickrun*" :popup t :align below :ratio 0.5)
;; 		  ("*terminal*" :regexp t :popup t :align below :ratio 0.5)
;; 		  ("*Agenda Commands*" :regexp t :popup t :align below :ratio 0.5)
;; 		  ("*Org Agenda*" :regexp t :popup t :align below :ratio 0.5)
;;           ))
;;   :config
;;   (shackle-mode 1))

(use-package shell-pop
  :init
  (setq shell-pop-shell-type (quote ("ansi-term" "*shell-pop-ansi-term*" (lambda nil (ansi-term shell-pop-term-shell)))))
  (setq shell-pop-term-shell "/usr/local/bin/fish")
  (setq shell-pop-window-height 30)
  (setq shell-pop-window-position "bottom")
  :config
  (define-key term-raw-map (kbd "M-x") 'nil)
  )

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
  (setq auto-insert-query nil)
  :config
  (auto-insert-mode 1)
  (setq auto-insert-alist
        (nconc '(
                 ("\\.cpp$" . ["template.cpp" my-template])
				 ;; ("\\.cpp$" . ["template2.cpp" my-template]) ; プロジェクト毎にテンプレートを変更する、新規ファイル作成時にどのテンプレートを利用するか入力するなどしたいが諦めた
                 ("\\.py$"   . ["template.py" my-template])
                 ("\\.org$"   . ["template.org" my-template])
                 ("\\.tex$"   . ["template.tex" my-template])
                 ("\\.js$"   . ["template.js" my-template])
                 ) auto-insert-alist))
  ;; (add-hook 'find-file-not-found-hooks 'auto-insert) ;; HACK: :hookの中に入れたほうがきれい
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

;; auto-insert-choose
(use-package auto-insert-choose)

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
          ;; tabs ; タブ
          spaces ; スペース
          space-mark ; 表示のマッピング
          ;; tab-mark
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

(defun my-wrap-lines-with-html-tag ($tag)
  (interactive "sTag: ")
  (if (and mark-active transient-mark-mode)
      (shell-command-on-region
       (region-beginning) (region-end)
       (concat "perl -0 -p -w -e \'"
               "s/^([^\\S\\r\\n]*)(\\S.*?)[^\\S\\r\\n]*$/$1<"
               $tag ">$2<\\/" $tag ">/gm\'")
       nil t)))

;;web-modeの設定
(use-package web-mode
  :bind
  (:map web-mode-map
        ("C-x i" . my-wrap-lines-with-html-tag)
		("C-;" . web-mode-fold-or-unfold))
  :config
  (setq web-mode-html-offset   2)
  (setq web-mode-style-padding 2)
  (setq web-mode-css-offset    2)
  (setq web-mode-script-offset 2)
  (setq web-mode-java-offset   2)
  (setq web-mode-asp-offset    2)
  ;;tag closing
  ;; 0=no -closing
  ;; 1=auto-close with </
  ;; 2=auto-close with > and </
  (setq web-mode-tag-auto-close-style 2)
  :mode
  (("\\.html?$" . web-mode)
   ("\\.php?$" . web-mode)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode)) ;本当はjs2-modeにしたいけど重すぎる
;; (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))

;;flycheckの設定
(use-package flycheck
  :config
  ;;TODO: globalにflycheckを有効化して、使わないメジャーモードについてdisableにする設定を行いたいけどうまくいかない
  ;; (global-flycheck-mode)
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
  (add-hook 'js-mode-hook #'flycheck-mode)
  (add-hook 'c++-mode-hook #'flycheck-mode)
  (custom-set-variables
   '(flycheck-disabled-checkers '(javascript-jshint javascript-jscs)))
  (flycheck-define-checker c/c++11
	"original C++ checker"
	:command ("g++-8" "-Wall" "-Wextra" "-std=c++11" source)
	:error-patterns  ((error line-start
							 (file-name) ":" line ":" column ":" " Error: " (message)
							 line-end)
                      (error line-start
                             (file-name) ":" line ":" column ":" " Fatal Error: " (message)
							 line-end)
                      (warning line-start
                               (file-name) ":" line ":" column ":" " Warning: " (message)
                               line-end))
	:modes (c-mode c++-mode))
  (add-hook 'c++-mode-hook				;originalのチェッカーをデフォルトに変更。競プロ用なのでdir-localでもいいかも
			'(lambda()
               (flycheck-select-checker 'c/c++11)))
  )

;; helmの設定
(use-package helm
  :config
  (helm-mode 1)
  :bind
  ("C-x C-r" . helm-mini)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("M-x" . 'helm-M-x)
  (:map helm-map
        ("C-z" . helm-select-action)
		:map helm-find-files-map
        ("<tab>" . helm-execute-persistent-action)
		:map helm-read-file-map
        ("<tab>" . helm-execute-persistent-action)))

;;helm-flycheckの設定
(use-package helm-flycheck
  :bind
  (:map flycheck-mode-map
        ("C-c f" . helm-flycheck))
  )

(use-package helm-swoop
  :init
  (setq helm-swoop-split-window-function 'display-buffer)
  :bind
  ("C-S-s" . helm-swoop)
  )

;; redo+の設定
(use-package redo+
  :bind
  ("C-/" . redo)
  :config
  (setq undo-no-redo t)					;redo+が使えるときにはundoの挙動をストレートにする
  )

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
  ;; companyのtabと競合しているのでC-iと使い分ける
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
(add-hook 'js-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'js2-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))
(add-hook 'ruby-mode-hook
          '(lambda ()
             (hs-minor-mode 1)))

;; ===============================================================
;; org-mode
;; ===============================================================
(use-package org-bullets
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )
(use-package org
  :init
  (setq org-startup-truncated nil)		;org折返し
  (setq org-use-speed-commands t)		;speed-commandをONにする
  (setq org-startup-with-inline-images t) ;インラインで画像表示
  (setq org-agenda-files '("~/Dropbox/org/todo.org"))
  (setq org-capture-templates
		'(("t" "Task" entry
           (file+headline "~/Dropbox/org/todo.org" "Task")
           "* TODO %? \n ADDED: %t")
		  ("m" "Memo" entry
           (file+headline "~/Dropbox/org/memo.org" "Memo")
           "* %u %?\n%i\n")
		  ))
  ;; org-agendaでaを押したら予定表とTODOリストを表示
  (setq org-agenda-custom-commands
		'(("a" "Agenda and TODO"
           ((agenda "")
			(alltodo "")))))
  (setq org-agenda-start-on-weekday nil)
  (setq org-hide-emphasis-markers t)
  :config
  (add-to-list 'org-emphasis-alist
               '("*" (:foreground "red")
				 ))
  :bind
  ("C-c c" . org-capture)
  ("C-c a" . org-agenda))

(setq org-publish-project-alist
      '(("Case"
         :base-directory "~/Documents/Case/Log/"
         :recursive t
		 :auto-sitemap t
         :publishing-directory "~/Documents/Case/html/"
         :publishing-function org-html-publish-to-html)))

;; ===============================================================
;; js-mode
;; ===============================================================
(use-package js2-mode
  :init
  (setq js2-idle-timer-delay 2)
  )

;; ===============================================================
;; rjsx-mode
;; ===============================================================
(use-package rjsx-mode
  :init
  (setq js-indent-level 2)
  (setq js2-strict-missing-semi-warning nil)
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

;; ===============================================================
;; Original Function
;; ===============================================================
(defun kill-word-at-point ()
  (interactive)
  (let ((char (char-to-string (char-after (point)))))
    (cond
     ((string= " " char) (delete-horizontal-space))
     ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
     (t (forward-char) (backward-word) (kill-word 1)))))

(defun window-resizer ()
  "ウィンドウのサイズをhjklで変更する関数"
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

(defun my-term-switch-line-char ()
  "`ansi-term'内で`term-in-line-mode'と`term-in-char-mode'を入れ替える"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

(defadvice kill-region (around kill-word-or-kill-region activate)
  (if (and (called-interactively-p 'interactive) transient-mark-mode (not mark-active))
      (backward-kill-word 1) ad-do-it))

;; C-kのkill-line後に次の行のインデントを少なくする
(defadvice kill-line (before kill-line-and-fixup activate)
  (when (and (not (bolp)) (eolp))
    (forward-char)
    (fixup-whitespace)
    (backward-char)))

;; Hyperキー+任意キーでavyを起動させる
(defun one-prefix-avy (prefix c &optional mode)
  (define-key global-map
    (read-kbd-macro (concat prefix (string c)))
    `(lambda ()
       (interactive)
       (funcall (if (eq ',mode 'char)
                    #'avy-goto-word-1
                  #'avy-goto-char) ,c))))
(loop for c from ?! to ?~ do (one-prefix-avy "H-" c))

(defun finder-current-dir-open()
  (interactive)
  (shell-command "open ."))
;; ===============================================================
;; Key-bind (necessary bind-key.el)
;; ===============================================================
(require 'bind-key)
;; 一般的に使うプレフィックスなしキーバインド
(bind-key "C-z" 'undo)
(bind-key "M-[" 'replace-string)
(bind-key "M-d" 'kill-word-at-point)
(bind-key "M-g" 'goto-line)
(bind-key "M-w" 'easy-kill)
(bind-key "C-;" 'hs-toggle-hiding)
(bind-key* "C-h" 'delete-backward-char)
(bind-key* "M-h" 'backward-kill-word)
(bind-key* "C-," 'goto-last-change)
(bind-key* "C-." 'goto-last-change-reverse)
(bind-key "C-M-l" 'hs-show-block)
(bind-key "C-M-h" 'hs-hide-block)
(bind-key "C-S-n" (lambda () (interactive) (scroll-up 3)))
(bind-key "C-S-p" (lambda () (interactive) (scroll-down 3)))
(bind-key "C-:" 'toggle-truncate-lines)
(bind-key "C-S-a" 'back-to-indentation)
(bind-key "C-S-b" 'backward-word)
(bind-key "C-S-f" 'forward-word)
(bind-key* "C-S-h" 'backward-kill-word)
(bind-key* "C-S-d" 'kill-word-at-point)
(bind-key "M-n" (kbd "M-5 C-n"))
(bind-key "M-p" (kbd "M-5 C-p"))
(bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)
(unbind-key "C-\\")				 ;Emacsのレイヤーで日本語の入力サポートされたくない

;; Mac 依存のキーバインド
(bind-key "s-k" 'kill-this-buffer)
(bind-key "s-o" 'finder-current-dir-open)
(bind-key "s-." 'next-buffer)
(bind-key "s-," 'previous-buffer)
(bind-key "s-=" 'text-scale-adjust)
(bind-key "s--" 'text-scale-adjust)

;; window系とterminal系は共通のプレフィックス `C-t'
(unbind-key "C-t")
(bind-key* "C-t h" 'windmove-left)
(bind-key* "C-t j" 'windmove-down)
(bind-key* "C-t k" 'windmove-up)
(bind-key* "C-t l" 'windmove-right)
(bind-key* "C-t -" 'split-window-below)
(bind-key* "C-t |" 'split-window-right)
(bind-key* "C-t t" 'shell-pop)
(bind-key* "C-t C-r" 'window-resizer)
(bind-key* "C-t [" 'my-term-switch-line-char term-raw-map)
(bind-key* "C-t [" 'my-term-switch-line-char term-mode-map)
                                        ;押しやすいキーなのでプレフィックスにする
(unbind-key "C-q")		
(bind-key "C-q C-q" 'quoted-insert)		 ;押しやすいキーなのでプレフィックスにする

;; ファイル系のプレフィックス `C-x'
(bind-key "C-x j" 'open-junk-file)

;; TODO: MAP依存は各use-package以内に書いたほうが良いかな？
;; → あるパッケージを無効化したい時に、複数箇所コメントアウトする必要があるので、use-package内に記述していた方がよい
;; → globalな設定もとい、他のパッケージ依存の設定はここに書かない
(unbind-key "M-n" company-active-map)
(unbind-key "M-p" company-active-map)
(unbind-key "C-h" company-active-map)
(bind-key "C-n" 'company-select-next company-active-map)
(bind-key "C-p" 'company-select-previous company-active-map)
(bind-key "<tab>" 'company-complete-common-or-cycle company-active-map)

;; HACK: 何故か2度呼び出すとうまくいくから書いてる。ちなみに上のやつ消してもだめ、絶対2回
(exec-path-from-shell-initialize)

(put 'upcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
