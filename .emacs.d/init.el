;;Loadund-pathを追加する関数を定義
;;load-path:サブディレクトリを含めディレクトリをPATHに設定する関数

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;C-xC-f の find-file のdefault directoryを "~/" にする
(setq default-directory "~/")
(setq command-line-default-directory "~/")

;; この辺よくわからんからコメントアウト
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/emacs-mozc")ふぁ
;; (require 'mozc)
;; (require 'mozc-popup)
;; (set-language-environment "Japanese")
;; (setq default-input-method "japanese-mozc")
;; (prefer-coding-system 'utf-8)

(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8-hfs)
(setq mozc-candidate-style 'popup)

(toggle-truncate-lines 1)

;; mac用ちらつかせ防止
(setq redisplay-dont-pause nil)

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
;;elispをPATHに設定
(add-to-load-path "elisp")
(add-to-load-path "elpa")

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))

;;dashboardの設定(OFF推奨)
;;(dashboard-setup-startup-hook)

;;終了時の確認
(setq confirm-kill-emacs 'y-or-n-p)

;;メニューバーを消す
(menu-bar-mode 0)

;;ツールバーを消す
(tool-bar-mode 0)

;;起動時のメッセージを消す
(setq ihibit-startup-message t)

;;yes,noをy,nで回答可能にする
(defalias 'yes-or-no-p 'y-or-n-p)

;;自動インデントモード
(setq c-tab-always-indent nil)

;;起動時のメッセージを非表示にする
(setq inhibit-startup-message t)

;; スクリーンの最大化
(set-frame-parameter nil 'fullscreen 'fullboth)

;; 行番号を表示
(global-linum-mode t)
 
;; character code 設定
(set-keyboard-coding-system 'cp932)
 
;;(prefer-coding-system 'utf-8-dos)
(prefer-coding-system 'utf-8-unix)
 
(set-file-name-coding-system 'cp932)
(setq default-process-coding-system '(cp932 . cp932))

;;TABの表示幅　初期値は８
(setq-default tab-width 4)

;;カラーテーマの設定
(load-theme 'manoj-dark)

;;日本語フォントをメイリオに
(set-fontset-font
 nil 'japanese-jisx0208
 (font-spec :family "メイリオ"))

;;現在行のハイライトの設定
(defface my-hl-line-face
  '((((class color) (background dark))
	(:background "NavyBlue" t))
   (((class color) (background light))
	(:background "LightGoldenodYellow" t))
   (t (:bold t)))
  "hl-line's my face")
(setq hl-line-face 'my-hl-line-face)
;;ハイライトのON/OFF
(global-hl-line-mode t)

;;対応する括弧を強調して表示する
(setq show-paren-delay 0) ;表示までの秒数
(show-paren-mode t) ;有効化
;;括弧内の強調表示
(setq show-paren-style 'expression)
;;フェイスを変更する
(set-face-attribute 'show-paren-match-face nil
                    :background nil :foreground nil
                    :underline "#ffff00" :weight 'extra-bold)


;;括弧の対応付け
(electric-pair-mode 1)

;;バックアップファイルとオートセーブファイルを~/.emacs.d/backupsへ集める
(add-to-list 'backup-directory-alist
			 (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
	  `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;;スクリプトファイルに実行権限を与えて保存
(add-hook 'after-save-hook
		  'executable-make-buffer-file-executable-if-script-p)

;;Elisp関数や変数をエコーエリアへ表示する(Elispmode時)
(defun elisp-mode-hooks ()
  "lisp-mode-hooks"
  (when (require 'eldoc nil t)
	(setq eldoc-idle-delay 0.2)
	(setq eldoc-echo-area-use-multiline-p t)
	(turn-on-eldoc-mode)))
;;elisp-mode-hookのON/OFF
(add-hook 'emacs-lisp-mode-hook 'elisp-mode-hooks)

;;プロキシの設定
(setq url-http-proxy-basic-auth-storage
    (list (list "proxy.com:8080"
                (cons "Input your LDAP UID !"
                      (base64-encode-string "LOGIN:PASSWORD")))))

;;tabbarの設定
(require 'tabbar)
(tabbar-mode 1)


;; Disable grouping
(setq tabbar-buffer-groups-function nil)

;; Not use images
(setq tabbar-use-images nil)

;; Disable button
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
	       tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
;; Color setting
(set-face-attribute  ; バー自体の色
 'tabbar-default nil
 :family "Consolas"
 :height 1.0
 )
(set-face-attribute  ; 非アクティブなタブ
 'tabbar-unselected nil
 :background "#00bfff"
 :foreground "#2F3744"
 :box nil
 )

;; Disable mouse wheel on tabbar
(tabbar-mwheel-mode -1)

;; Space between tabs
(setq tabbar-separator '(0.2))

(set-face-attribute
 'tabbar-button nil
 :box nil)

(set-face-attribute
 'tabbar-separator nil
 :background "#2F3744"
 :height 1.0)

;; 表示させたくないバッファ
(defun my-tabbar-buffer-list ()
  (delq nil
        (mapcar #'(lambda (b)
                    (cond
                     ;; Always include the current buffer.
                     ((eq (current-buffer) b) b)
                     ((buffer-file-name b) b)
                     ((char-equal ?\  (aref (buffer-name b) 0)) nil)
                     ((equal "*Completions*" (buffer-name b)) nil)
					 ((equal "*scratch*" (buffer-name b)) nil)
					 ((char-equal ?* (aref (buffer-name b) 0)) nil)
                     ((equal "*Messages*" (buffer-name b)) nil)
                     ((buffer-live-p b) b)))
                (buffer-list))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)

;;auto-completeの設定
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'text-mode)
(add-to-list 'ac-modes 'yatex-mode)
(setq ac-use-menu-map t)
(setq ac-use-fuzzy t)
;;(global-auto-complete-mode t)

;;recentf-extの設定
(require 'recentf-ext)
(when (require 'recentf-ext nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))
;; 起動画面で recentf を開く
(add-hook 'after-init-hook (lambda()
    (recentf-open-files)))



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

(defun window-resizer ()
  "Control window size and position."
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
        (cond ((= c ?f)
               (enlarge-window-horizontally dx))
              ((= c ?b)
               (shrink-window-horizontally dx))
              ((= c ?p)
               (enlarge-window dy))
              ((= c ?n)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

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
(require 'popwin)
(setq special-display-function 'popwin:special-display-popup-window)
(setq popwin:popup-window-position 'bottom)
(setq display-buffer-function 'popwin:display-buffer)

;;google-translateの設定
(require 'google-translate)
(require 'google-translate-default-ui)
(push '(*Google Translate*) popwin:special-display-config)

(defvar google-translate-english-chars "[:ascii:]"
  "これらの文字が含まれているときは英語とみなす")
(defun google-translate-enja-or-jaen (&optional string)
  "regionか現在位置の単語を翻訳する。C-u付きでquery指定も可能"
  (interactive)
  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring (region-beginning) (region-end)))
              (t
               (thing-at-point 'word))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate
     (if asciip "en" "ja")
     (if asciip "ja" "en")
     string)))

(push '("\*Google Translate\*" :height 0.5 :stick t) popwin:special-display-config)
(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)

;;shellの設定
;; shellの文字化けを回避
(add-hook 'shell-mode-hook
          (lambda ()
            (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
            ))

;;autoinsertの設定
(require 'autoinsert)
(setq auto-insert-directory "~/.emacs.d/template/")
(setq auto-insert-alist
      (nconc '(
               ("\\.cpp$" . ["template.cpp" my-template])
               ("\\.py$"   . ["template.py" my-template])
			   ("\\.org$"   . ["template.org" my-template])
			   ("\\.tex$"   . ["template.tex" my-template])
               ) auto-insert-alist))
(require 'cl)
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%time%" . (lambda () (format-time-string "%Y-%m-%d")))
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

;;undotreeの設定
(require 'undo-tree)
(global-undo-tree-mode t)

;;web-modeの設定
(require 'web-mode)
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'web-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; CSSにも使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開
(add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
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
;; 色の設定
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(web-mode-comment-face ((t (:foreground "#D9333F"))))
 '(web-mode-css-at-rule-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground "#FF7F00"))))
 '(web-mode-css-rule-face ((t (:foreground "#A0D8EF"))))
 '(web-mode-doctype-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-attr-name-face ((t (:foreground "#C97586"))))
 '(web-mode-html-attr-value-face ((t (:foreground "#82AE46"))))
 '(web-mode-html-tag-face ((t (:foreground "#E6B422" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground "#D9333F")))))

;;org-modeの設定
(setq org-startup-truncated nil)
(setq org-startup-with-inline-images t)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
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
;; org-agendaで扱うファイルは複数可だが、
;; TODO・予定用のファイルのみ指定
(setq org-agenda-files '("~/Dropbox/org/todo.org"))
;; TODOリストに日付つきTODOを表示しない
(setq org-agenda-todo-ignore-with-date t)
;; 今日から予定を表示させる
(setq org-agenda-start-on-weekday nil)

;;flycheckの設定
(add-hook 'after-init-hook #'global-flycheck-mode)
;;flycheck-pop-tips
(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(require 'helm-config)
(helm-mode 1)
(define-key helm-map (kbd "C-z")  'helm-select-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;;helm-flycheckの設定
(require 'helm-flycheck) ;; Not necessary if using ELPA package
(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

(require 'yasnippet)
(require 'helm-c-yasnippet)
(setq helm-yas-space-match-any-greedy t)
(global-set-key (kbd "C-c y") 'helm-yas-complete)
(push '("emacs.+/snippets/" . snippet-mode) auto-mode-alist)
(yas-global-mode 1)

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


;;Key-bind (necessary bind-key.el)
(require 'bind-key)
(bind-key "C-z" 'undo)
(bind-key* "C-/" 'undo-tree-redo)
(bind-key "C-t" 'other-window)
(bind-key* "C-." 'tabbar-forward-tab)
(bind-key* "C-," 'tabbar-backward-tab)
(bind-key "M-n" (kbd "C-u 5 C-n"))
(bind-key "M-p" (kbd "C-u 5 C-p"))
(bind-key "M-h" 'backward-kill-word)
(bind-key "M-g" 'goto-line)
(bind-key "C-m" 'newline-and-indent)
(bind-key "C-x C-r" 'helm-mini)
(bind-key "C-x C-f" 'helm-find-files)
(bind-key "M-w" 'easy-kill)
(bind-key "M-y" 'helm-show-kill-ring)
(bind-key* "C-j" 'toggle-input-method)
(bind-key "C-x j" 'open-junk-file)
(bind-key "M-x" 'helm-M-x)
(bind-key "C-;" 'hs-toggle-hiding)
(bind-key "C-h" 'delete-backward-char)
(bind-key  "C-x i" 'my-wrap-lines-with-html-tag web-mode-map)
(bind-key  "C-x :" 'toggle-truncate-lines)


(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(package-selected-packages
   (quote
	(latex-math-preview magit yatex rainbow-mode emmet-mode mozc-popup hide-comnt open-junk-file google-translate helm-flycheck web-mode multi-term flymake-cppcheck undo-tree undohist flycheck-irony flycheck-pos-tip flycheck quickrun helm recentf-ext pdf-tools bind-key dashboard))))

(put 'set-goal-column 'disabled nil)
