diff --git a/.emacs.d/init.el b/.emacs.d/init.el
index 9b361b6..548b42d 100644
--- a/.emacs.d/init.el
+++ b/.emacs.d/init.el
@@ -24,9 +24,10 @@
 (use-package smart-newline
   ;; 本当は:hookで書きたかったのに何故かばぐるのでこう書いた
   :init
-  (add-hook 'org-mode-hook
-            (lambda ()
-              (smart-newline-mode t))))
+  ;; (add-hook 'org-mode-hook
+  ;;           (lambda ()
+  ;;             (smart-newline-mode t)))
+  )

 (defun add-to-load-path (&rest paths)
   (let (path)
@@ -43,7 +44,6 @@
 (when (eq system-type 'darwin)
   (setq mac-right-command-modifier 'hyper))

-;; (add-hook 'prog-mode-hook (lambda () (subword-mode 1)))
 (use-package subword
   :diminish subword-mode
   :config
@@ -56,10 +56,10 @@
 (setq custom-file "~/.emacs.d/custom.el")
 (load custom-file 'noerror)

-(use-package exec-path-from-shell
-  :config
-  (exec-path-from-shell-initialize))
-                                        ;TODO: 起動にこの処理を反映させたいけどうまくいかない
+;;(use-package exec-path-from-shell
+;;  :config
+;;  (exec-path-from-shell-initialize))	
+;;TODO: 起動にこの処理を反映させたいけどうまくいかない

 ;; Warningがうざいので出さない
 (setq warning-minimum-level :error)
@@ -74,6 +74,9 @@
 (load-theme 'dracula t)
 (add-hook 'prog-mode-hook 'highlight-numbers-mode)

+(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
+(add-to-list 'default-frame-alist '(ns-appearance . dark)) ;; assuming you are using a dark theme
+
 ;; カーソルの点滅を止める
 (blink-cursor-mode 0)

@@ -130,9 +133,14 @@

 ;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
 (setq backup-directory-alist
-      '((".*" . "~/.emacs.d/backups/")))
+  (cons (cons ".*" (expand-file-name "~/.emacs.d/backup"))
+        backup-directory-alist))
 (setq auto-save-file-name-transforms
-      '((".*" "~/.emacs.d/backups/" t)))
+  `((".*", (expand-file-name "~/.emacs.d/backup/") t)))
+
+;; ファイルをゴミ箱に移動させる
+(setq trash-directory "~/.Trash")
+(setq delete-by-moving-to-trash t)

 ;; 自動ファイルリストとロックファイルは生成しない
 (setq auto-save-list-file-prefix nil)
@@ -187,11 +195,15 @@
 ;; Various Package Setting
 ;; ===============================================================

+;; text-adjust
+(use-package text-adjust)
+
 ;; smartparen
 (use-package smartparens
   :config
   (smartparens-global-mode t)
   (sp-pair "「" "」")
+  (sp-pair "【" "】")
   (sp-pair "'" "'"))

 ;; newtree
@@ -214,19 +226,8 @@
   :config
   (require 'spaceline-config)
   (spaceline-emacs-theme)
-  (spaceline-helm-mode))
-
-;; Elisp関数や変数をエコーエリアへ表示する(Elispmode時)
-(defun elisp-mode-hooks ()
-  "lisp-mode-hooks"
-  (when (require 'eldoc nil t)
-    (setq eldoc-idle-deHlay 0.2)
-    (setq eldoc-echo-area-use-multiline-p t)
-    (turn-on-eldoc-mode)z))
-;;elisp-mode-hookのON/OFF
-(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)
-
-(setq ispell-program-name "aspell")
+  (spaceline-helm-mode)
+  )

 (use-package avy
   :init
@@ -254,8 +255,6 @@
   (setq company-backends (delete 'company-semantic company-backends))
   )

-(require 'es6-snippets)
-
 (use-package diminish
   ;; 各use-package`:diminish'で設定できるのでそっちの方が良いかも
   :config
@@ -266,7 +265,7 @@
   (eval-after-load "flycheck"
 	'(diminish 'flycheck-mode "Ⓕ"))
   (eval-after-load "helm-mode"
-	'(diminish 'helm-mode "Ⓗ"))
+  	'(diminish 'helm-mode "Ⓗ"))
   (eval-after-load "whitespace"
 	'(diminish 'global-whitespace-mode "Ⓦ"))
   (eval-after-load "smartparens"
@@ -280,6 +279,16 @@
   (diminish 'smart-newline-mode "")
   )

+(use-package doom-modeline
+      :ensure t
+      :hook (after-init . doom-modeline-mode)
+	  :config
+	  (setq doom-modeline-bar-width 3)
+	  (setq doom-modeline-height 20)
+	  (setq doom-modeline-icon t)
+	  (setq doom-modeline-minor-modes t)
+	  )
+
 (use-package company-c-headers
   :config
   (add-to-list 'company-backends 'company-c-headers)
@@ -303,46 +312,6 @@
   :config
   (recentf-mode 1))

-(require 'multi-term)
-(defun term-send-forward-char ()
-  (interactive)
-  (term-send-raw-string "\C-f"))
-(defun term-send-backward-char ()
-  (interactive)
-  (term-send-raw-string "\C-b"))
-(defun term-send-previous-line ()
-  (interactive)
-  (term-send-raw-string "\C-p"))
-(defun term-send-next-line ()
-  (interactive)
-  (term-send-raw-string "\C-n"))
-(add-hook 'term-mode-hook
-          '(lambda ()
-             (let* ((key-and-func
-                     `(("\C-p"           term-send-previous-line)
-                       ("\C-n"           term-send-next-line)
-                       ("\C-b"           term-send-backward-char)
-                       ("\C-f"           term-send-forward-char)
-                       (,(kbd "C-y")     term-paste)
-                       (,(kbd "ESC ESC") term-send-raw)
-                       (,(kbd "C-S-p")   multi-term-prev)
-                       (,(kbd "C-S-n")   multi-term-next)
-                       ;; 利用する場合は
-                       ;; helm-shell-historyの記事を参照してください
-                       ;; ("\C-r"           helm-shell-history)
-                       )))
-               (loop for (keybind function) in key-and-func do
-                     (define-key term-raw-map keybind function)))))
-
-
-(add-hook 'c++-mode-hook
-          '(lambda()
-             (c-set-style "stroustrup")
-             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
-             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
-             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
-             ))
-
 ;;; これがないとemacs -Qでエラーになる。おそらくバグ。
 (require 'compile)

@@ -402,38 +371,26 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   ("C-c C-<" . mc/mark-all-like-this)
   )

-;; shackleの設定
-;;TODO: shackleの方が優秀なのかもしれない(https://qiita.com/fujimotok/items/164cd80b89992eeb4efe)
-;;TODO: https://github.com/shibayu36/emacs/commit/f096b0ef2698b13a9afa75df588d40695e26b18e
+;; popwinの設定
 (use-package popwin
   :after (helm)
   :config
   (popwin-mode 1)
   (setq helm-display-function #'display-buffer)
   (setq popwin:special-display-config
-    '(("*complitation*" :noselect t)
-      ("helm" :regexp t :height 0.4)
-	  ))
-  (push '("*Agenda Commands*" :regexp t) popwin:special-display-config)
+  		'(("*complitation*" :noselect t)
+  		  ("helm" :regexp t :height 0.4)
+  		  ))
+  (push '("^\*Agenda Commands*" :regexp t) popwin:special-display-config)
   (push '("^\*Org Agenda*" :regexp t :height 0.4) popwin:special-display-config)
   )

-;; (use-package shackle
-;;   :init
-;;   (setq shackle-rules
-;; 		'(
-;;           ("*helm mini*" :popup t :align below :ratio 0.5)
-;; 		  ("*Helm Swoop*" :popup t :align below :ratio 0.3)
-;;           ("*helm M-x*" :popup t :align below :ratio 0.5)
-;;           ("*helm find files*" :popup t :align below :ratio 0.5)
-;;           ("*Help*" :popup t :align below :ratio 0.5)
-;;           ("*quickrun*" :popup t :align below :ratio 0.5)
-;; 		  ("*terminal*" :regexp t :popup t :align below :ratio 0.5)
-;; 		  ("*Agenda Commands*" :regexp t :popup t :align below :ratio 0.5)
-;; 		  ("*Org Agenda*" :regexp t :popup t :align below :ratio 0.5)
-;;           ))
-;;   :config
-;;   (shackle-mode 1))
+;; helmを無理やりbufferの候補から外す
+(defun my-buffer-predicate (buffer)
+  (if (string-match "helm" (buffer-name buffer))
+      nil
+    t))
+(set-frame-parameter nil 'buffer-predicate 'my-buffer-predicate)

 (use-package shell-pop
   :init
@@ -495,6 +452,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   :config
   (undohist-initialize))

+;; whitespaceの設定
 (use-package whitespace
   :init
   (setq whitespace-style
@@ -530,6 +488,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
                       :underline nil)
   )

+;; emmetの設定
 (use-package emmet-mode
   :init
   (setq emmet-indentation 2)
@@ -576,7 +535,6 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
    ("\\.php?$" . web-mode)))

 (add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode)) ;本当はjs2-modeにしたいけど重すぎる
-;; (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))

 ;;flycheckの設定
 (use-package flycheck
@@ -606,7 +564,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
                (flycheck-select-checker 'c/c++11)))
   )

-;; helmの設定
+helmの設定
 (use-package helm
   :config
   (helm-mode 1)
@@ -616,8 +574,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 		:map helm-find-files-map
         ("<tab>" . helm-execute-persistent-action)
 		:map helm-read-file-map
-        ("<tab>" . helm-execute-persistent-action))
-  )
+        ("<tab>" . helm-execute-persistent-action)))

 ;;helm-flycheckの設定
 (use-package helm-flycheck
@@ -626,6 +583,11 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
         ("C-c f" . helm-flycheck))
   )

+;; ivyの設定
+;; (ivy-mode 1) ;; デフォルトの入力補完がivyになる
+;; (setq ivy-use-virtual-buffers t)
+;; (setq enable-recursive-minibuffers t)
+
 (use-package helm-swoop
   :init
   (setq helm-swoop-split-window-function 'display-buffer)
@@ -648,6 +610,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   (set-face-background 'hl-line "firebrick")
   )

+;; yasnippetの設定
 (use-package yasnippet
   :bind
   ;; companyのtabと競合しているのでC-iと使い分ける
@@ -658,7 +621,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   (push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
   )

-
+;; helm-c-yasnippetの設定
 (use-package helm-c-yasnippet
   :init
   (setq helm-yas-space-match-any-greedy t)
@@ -704,18 +667,26 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 ;; org-mode
 ;; ===============================================================
 (use-package org-bullets
-  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
-  )
+  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))
+
+(require 'org-indent)
+(org-indent-mode -1)
+
 (use-package org
   :init
   (setq org-startup-truncated nil)		;org折返し
   (setq org-use-speed-commands t)		;speed-commandをONにする
   (setq org-startup-with-inline-images t) ;インラインで画像表示
   (setq org-agenda-files '("~/Dropbox/org/todo.org"))
+  (setq org-export-with-sub-superscripts nil)
+  (setq org-export-preserve-breaks t)
+  (setq org-startup-indented nil)
   (setq org-capture-templates
 		'(("t" "Task" entry
            (file+headline "~/Dropbox/org/todo.org" "Task")
-           "* TODO %? \n ADDED: %t")
+           "* TODO %? \n")
+		  ("k" "Knowledge" entry
+           (file+headline "~/Dropbox/org/knowledge.org" "Knowledge"))
 		  ("m" "Memo" entry
            (file+headline "~/Dropbox/org/memo.org" "Memo")
            "* %u %?\n%i\n")
@@ -736,6 +707,14 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   ("C-c a" . org-agenda)
   )

+(setq org-publish-project-alist
+      '(("Case"
+         :base-directory "~/Documents/Case/Log/"
+         :recursive t
+		 :auto-sitemap t
+         :publishing-directory "~/Documents/Case/html/"
+         :publishing-function org-html-publish-to-html)))
+
 ;; ===============================================================
 ;; js-mode
 ;; ===============================================================
@@ -765,9 +744,24 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
   (setq c-basic-offset 4))
 (add-hook 'c++-mode-hook 'my-c-c++-mode-init)

+(add-hook 'c++-mode-hook
+          '(lambda()
+             (c-set-style "stroustrup")
+             (setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
+             (c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
+             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
+             ))
+
 ;; ===============================================================
 ;; Original Function
 ;; ===============================================================
+(defvar org-export-directory nil)
+
+(defun org-export-output-file-name--set-directory (orig-fn extension &optional subtreep pub-dir)
+  (setq pub-dir (or pub-dir org-export-directory))
+  (funcall orig-fn extension subtreep pub-dir))
+(advice-add 'org-export-output-file-name :around 'org-export-output-file-name--set-directory)
+
 (defun kill-word-at-point ()
   (interactive)
   (let ((char (char-to-string (char-after (point)))))
@@ -838,6 +832,10 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
                   #'avy-goto-char) ,c))))
 (loop for c from ?! to ?~ do (one-prefix-avy "H-" c))

+(defun finder-current-dir-open()
+  (interactive)
+  (shell-command "open ."))
+
 ;; ===============================================================
 ;; Key-bind (necessary bind-key.el)
 ;; ===============================================================
@@ -848,8 +846,6 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 (bind-key "M-d" 'kill-word-at-point)
 (bind-key "M-g" 'goto-line)
 (bind-key "M-w" 'easy-kill)
-(bind-key "M-y" 'helm-show-kill-ring)
-(bind-key "M-x" 'helm-M-x)
 (bind-key "C-;" 'hs-toggle-hiding)
 (bind-key* "C-h" 'delete-backward-char)
 (bind-key* "M-h" 'backward-kill-word)
@@ -857,11 +853,10 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 (bind-key* "C-." 'goto-last-change-reverse)
 (bind-key "C-M-l" 'hs-show-block)
 (bind-key "C-M-h" 'hs-hide-block)
-(bind-key "C-x C-f" 'helm-find-files)
 (bind-key "C-S-n" (lambda () (interactive) (scroll-up 3)))
 (bind-key "C-S-p" (lambda () (interactive) (scroll-down 3)))
 (bind-key "C-:" 'toggle-truncate-lines)
-(bind-key "C-S-a" 'back-to-indentation)
+(bind-key "M-a" 'back-to-indentation)
 (bind-key "C-S-b" 'backward-word)
 (bind-key "C-S-f" 'forward-word)
 (bind-key* "C-S-h" 'backward-kill-word)
@@ -871,6 +866,15 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 (bind-key "C-w" 'backward-kill-word minibuffer-local-completion-map)
 (unbind-key "C-\\")				 ;Emacsのレイヤーで日本語の入力サポートされたくない

+;; Mac 依存のキーバインド
+(bind-key "s-k" 'kill-this-buffer)
+(bind-key "s-o" 'finder-current-dir-open)
+(bind-key "s-." 'next-buffer)
+(bind-key "s-," 'previous-buffer)
+(bind-key "s-w" 'kill-current-buffer)
+(bind-key "s-=" 'text-scale-adjust)
+(bind-key "s--" 'text-scale-adjust)
+
 ;; window系とterminal系は共通のプレフィックス `C-t'
 (unbind-key "C-t")
 (bind-key* "C-t h" 'windmove-left)
@@ -885,13 +889,14 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 (bind-key* "C-t [" 'my-term-switch-line-char term-mode-map)
 (bind-key "C-S-s" 'helm-swoop)

-                                        ;押しやすいキーなのでプレフィックスにする
-(unbind-key "C-q")		
-(bind-key "C-q C-q" 'quoted-insert)		 ;押しやすいキーなのでプレフィックスにする
+(unbind-key "C-q")						;押しやすいキーなのでプレフィックスにする
+(bind-key "C-q C-q" 'quoted-insert)

 ;; ファイル系のプレフィックス `C-x'
 (bind-key "C-x C-r" 'helm-mini)
 (bind-key "C-x C-f" 'helm-find-files)
+(bind-key "M-y" 'helm-show-kill-ring)
+(bind-key "M-x" 'helm-M-x)
 (bind-key "C-x j" 'open-junk-file)

 ;; TODO: MAP依存は各use-package以内に書いたほうが良いかな？
@@ -905,7 +910,7 @@ FORMAT-STRING is like `format', but it can have multiple %-sequences."
 (bind-key "<tab>" 'company-complete-common-or-cycle company-active-map)

 ;; HACK: 何故か2度呼び出すとうまくいくから書いてる。ちなみに上のやつ消してもだめ、絶対2回
-(exec-path-from-shell-initialize)
+;; (exec-path-from-shell-initialize)

 (put 'upcase-region 'disabled nil)
 (put 'set-goal-column 'disabled nil)
