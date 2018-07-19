;; yes/noをy/nで
(defalias 'yes-or-no-p 'y-or-n-p)
;; menu bar
(menu-bar-mode 0)
;; 起動時のメッセージ
(setq ihibit-startup-message t)
;; tabの幅
(setq-default tab-width 4)
;; バックアップファイルを生成しない
(setq make-backup-files t)
;; 言語周り
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
;; Key bindings
(global-set-key (kbd "C-z") 'undo)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-x :") 'toggle-truncate-lines)
(global-set-key (kbd "M-n") (kbd "C-u 5 C-n"))
(global-set-key (kbd "M-p") (kbd "C-u 5 C-p"))
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-h") 'backward-kill-word)
