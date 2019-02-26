;; yes/noをy/nで返答
(defalias 'yes-or-no-p 'y-or-n-p)

;; menu bar
(menu-bar-mode 0)

;; 起動時のメッセージ
(setq ihibit-startup-message t)

;; tabの幅
(setq-default tab-width 4)

;; バックアップファイル・自動保存ファイルの保存先
(setq backup-directory-alist
	  '((".*" . "~/.emacs.d/backups/")))
(setq auto-save-file-name-transforms
	  '((".*" "~/.emacs.d/backups/" t)))

;; 言語周り
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)

;; autoinsertによるテンプレート
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

;; 括弧の対応
(electric-pair-mode t)

;; Key bindings
;; (global-set-key (kbd "C-z") 'undo)
;; (global-set-key (kbd "C-h") 'delete-backward-char)
;; (global-set-key (kbd "C-x :") 'toggle-truncate-lines)
;; (global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
;; (global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))
;; (global-set-key (kbd "M-g") 'goto-line)
;; (global-set-key (kbd "M-h") 'backward-kill-word)

(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "M-[") 'replace-string)
(global-set-key (kbd "M-d") 'kill-word-at-point)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-;") 'hs-toggle-hiding)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)
(global-set-key (kbd "C-M-l") 'hs-show-block)
(global-set-key (kbd "C-M-h") 'hs-hide-block)
(global-set-key (kbd "C-:") 'toggle-truncate-lines)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-S-a") 'move-beginning-of-line)
(global-set-key (kbd "C-S-b") 'backward-word)
(global-set-key (kbd "C-S-f") 'forward-word)
(global-set-key (kbd "C-S-h") 'backward-kill-word)
(global-set-key (kbd "C-S-d") 'kill-word-at-point)
(global-set-key (kbd "M-n") (kbd "M-5 C-n"))
(global-set-key (kbd "M-p") (kbd "M-5 C-p"))

