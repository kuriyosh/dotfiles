;; ;; ===============================================================
;; ;; Global Setting
;; ;; ===============================================================

(defalias 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode 0)						; menu bar off
(setq ihibit-startup-message t)			; start message off
(setq-default tab-width 4)				; tab-width = space 4
(setq backup-directory-alist 			; back up file
	  '((".*" . "~/.emacs.d/backup/")))
(setq auto-save-file-name-transforms	; auto save file
	  '((".*" "~/.emacs.d/backup/" t)))
(set-language-environment "Japanese")	; language settings
(prefer-coding-system 'utf-8)
(electric-pair-mode t)					; electric-pair-mode

;; ;; ===============================================================
;; ;; Advanced
;; ;; ===============================================================
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

;; template replacement for autoinsert
(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%time%" . (lambda () (format-time-string "%Y-%m-%d")))
	("%mtg-timeformat%" . (lambda () (format-time-string "%m%d")))
    ("%include-guard%"    . (lambda () (format "__SCHEME_%s__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))))

;; my-template setting parse for autoinsert
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

;; clipboard setting
(if (eq system-type 'darwin)
    (progn
      (defun copy-from-osx ()
    (shell-command-to-string "reattach-to-user-namespace pbpaste"))
      (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "reattach-to-user-namespace" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
    )
    (message "This platform is not mac"))


;; ;; ===============================================================
;; ;; Key Setting
;; ;; ===============================================================
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

