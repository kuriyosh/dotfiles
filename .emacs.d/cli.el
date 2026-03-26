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
(load-theme 'misterioso t)				; dark theme

;; ;; ===============================================================
;; ;; Advanced
;; ;; ===============================================================

;; clipboard setting (macOS terminal)
(when (and (not (display-graphic-p))
           (executable-find "pbcopy"))
  (setq interprogram-cut-function
        (lambda (text &rest _)
          (with-temp-buffer
            (insert text)
            (call-process-region (point-min) (point-max) "pbcopy")))
        interprogram-paste-function
        (lambda ()
          (let ((clip (shell-command-to-string "pbpaste")))
            (unless (string= clip (car kill-ring))
              clip)))))

;; ;; ===============================================================
;; ;; Key Setting
;; ;; ===============================================================
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-c r") 'replace-string)
(global-set-key (kbd "M-d") 'delete-word-at-point)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "C-;") 'hs-toggle-hiding)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-delete-word)
(global-set-key (kbd "C-,") 'goto-last-change)
(global-set-key (kbd "C-.") 'goto-last-change-reverse)
(global-set-key (kbd "C-M-l") 'hs-show-block)
(global-set-key (kbd "C-M-h") 'hs-hide-block)
(global-set-key (kbd "C-:") 'toggle-truncate-lines)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "C-S-a") 'move-beginning-of-line)
(global-set-key (kbd "C-S-b") 'backward-word)
(global-set-key (kbd "C-S-f") 'forward-word)
(global-set-key (kbd "C-S-h") 'backward-delete-word)
(global-set-key (kbd "C-S-d") 'delete-word-at-point)
(global-set-key (kbd "M-n") (kbd "M-5 C-n"))
(global-set-key (kbd "M-p") (kbd "M-5 C-p"))

