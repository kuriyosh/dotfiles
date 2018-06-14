
((digest . "77b8c4ff1578774b06476782cec35175") (undo-list (14863 . 15654) ("(custom-set-faces
 '(web-mode-comment-face ((t (:foreground \"#D9333F\"))))
 '(web-mode-css-at-rule-face ((t (:foreground \"#FF7F00\"))))
 '(web-mode-css-pseudo-class-face ((t (:foreground \"#FF7F00\"))))
 '(web-mode-css-rule-face ((t (:foreground \"#A0D8EF\"))))
 '(web-mode-doctype-face ((t (:foreground \"#82AE46\"))))
 '(web-mode-html-attr-name-face ((t (:foreground \"#C97586\"))))
 '(web-mode-html-attr-value-face ((t (:foreground \"#82AE46\"))))
 '(web-mode-html-tag-face ((t (:foreground \"#E6B422\" :weight bold))))
 '(web-mode-server-comment-face ((t (:foreground \"#D9333F\")))))" . -14863) (20276 . 20278) (19866 . 19867) (" " . -19866) ("
" . -20276) (19866 . 19867) (20275 . 20276) (19865 . 19866) (" " . 19865) (19855 . 20275) (" " . 19855) (19825 . 19856) (19744 . 19745) (" " . -19744) ("
" . -19825) (19744 . 19745) (19824 . 19825) (19743 . 19744) (" " . 19743) (19733 . 19824) (" " . 19733) (19389 . 19734) ("(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(org-agenda-files
   (quote
	(\"~/Documents/Reading/Presentation/NS201803/memo.org\" \"~/Dropbox/org/todo.org\")))
 '(package-selected-packages
   (quote
	(goto-chg js-doc smartparens elscreen dracula-theme bm cyberpunk-theme madhat2r-theme markdown-mode latex-math-preview request exec-path-from-shell magit yatex rainbow-mode emmet-mode mozc-popup hide-comnt open-junk-file google-translate helm-flycheck web-mode multi-term flymake-cppcheck undo-tree undohist flycheck-irony flycheck-pos-tip flycheck quickrun helm recentf-ext pdf-tools bind-key dashboard))))" . -19389) nil (";; " . 14863) (";; " . 14884) (";; " . 14943) (";; " . 15006) (";; " . 15074) (";; " . 15134) (";; " . 15193) (";; " . 15259) (";; " . 15326) (";; " . 15399) nil (15399 . 15402) (15326 . 15329) (15259 . 15262) (15193 . 15196) (15134 . 15137) (15074 . 15077) (15006 . 15009) (14943 . 14946) (14884 . 14887) (14863 . 14866) nil ("
" . -14880) 14881 nil (" ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right." . -14881) 15099 (t 23230 54681 0 0) nil (2709 . 2981) nil (2708 . 2709) nil (3127 . 3130) (3057 . 3060) (3027 . 3030) (2988 . 2991) (2950 . 2953) (2910 . 2913) (2844 . 2847) (2801 . 2804) (2738 . 2741) 3138 nil (2709 . 3138) nil (";; hl-lineを無効にするメジャーモードを指定する
(defvar global-hl-line-timer-exclude-modes '(todotxt-mode))
(defun global-hl-line-timer-function ()
  (unless (memq major-mode global-hl-line-timer-exclude-modes)
    (global-hl-line-unhighlight-all)
    (let ((global-hl-line-mode t))
      (global-hl-line-highlight))))
(setq global-hl-line-timer
      (run-with-idle-timer 0.03 t 'global-hl-line-timer-function))
(cancel-timer global-hl-line-timer)" . 2709) nil (2709 . 2712) 2734 nil (";; " . -3100) (";; " . -3033) (";; " . -3006) (";; " . -2970) (";; " . -2935) (";; " . -2898) (";; " . -2835) (";; " . -2795) (";; " . -2735) (";;; " . -2709) (";; " . -2690) 3170 (t 23220 42546 0 0) nil ("
" . -13603) ("(eval-after-load \"emmet-mode\"
  '(define-key emmet-mode-keymap (kbd \"TAB\") 'indent-for-tab-command))" . -13604) 13704 (t 23220 42370 0 0) nil ("test" . 13633) nil (13633 . 13637) (t 23220 42370 0 0) nil (3061 . 3064) (3031 . 3034) (2992 . 2995) (2954 . 2957) (2914 . 2917) (2848 . 2851) (2805 . 2808) (2742 . 2745) 3106 nil (2690 . 2693) 2708 (t 23220 42340 0 0) nil (";; " . -3037) (";; " . -3010) (";; " . -2974) (";; " . -2939) (";; " . -2902) (";; " . -2839) (";; " . -2799) (";; " . -2739) 3127 (t 23220 42284 0 0) nil ("
" . -3166) 3167 nil ("(global-hl-line-mode t)" . 3167) (t 23220 42273 0 0) nil (3058 . 3061) (3028 . 3031) (2989 . 2992) (2951 . 2954) (2911 . 2914) (2845 . 2848) (2802 . 2805) (2739 . 2742) 3103 nil (";; " . 2739) (";; " . 2802) (";; " . 2845) (";; " . 2911) (";; " . 2951) (";; " . 2989) (";; " . 3028) (";; " . 3058) (t 23220 42265 0 0) nil (3058 . 3061) (3028 . 3031) (2989 . 2992) (2951 . 2954) (2911 . 2914) (2845 . 2848) (2802 . 2805) (2739 . 2742) 3103 (t 23220 32083 0 0) nil ("
" . -18799) 18800 nil ("(bind-key \"M-h\" 'backward-kill-word)" . 18800) (t 23220 32081 0 0) nil (19318 . 19356) nil (19317 . 19318) (t 23220 32080 0 0) nil ("
" . -19317) 19318 nil ("(bind-key*  \"M-h\" 'backward-kill-word)" . 19318) (t 23215 7146 0 0) nil ("a" . -18545) ("g" . -18546) 18547 nil (18545 . 18547) nil ("a" . -18545) ("g" . -18546) 18547 nil (18545 . 18547) nil (18541 . 18542) nil (18540 . 18543) nil (18533 . 18540) ("requi" . -18533) 18538 nil (18535 . 18538) nil ("d" . -18535) ("o" . -18536) 18537 nil (18533 . 18537) ("requ" . -18533) 18537 nil (18532 . 18537) ("(" . -18532) (18532 . 18534) ("(" . -18532) (18532 . 18533) nil (18530 . 18532) nil ("  
" . 18510) nil (18510 . 18512) ("
" . 18510) ("  " . 18510) (18510 . 18512) ("  " . 18511) nil (18511 . 18513) ("  " . 18510) (18510 . 18512) (18510 . 18511) ("  " . 18510) 18512 nil (18509 . 18512) (t 23207 28277 0 0) nil ("q" . -1) 2 nil (64 . 68) nil ("of
;" . -64) 68 nil (1 . 2) nil ("a" . -1) 2 nil (1 . 2) (t 23207 28011 0 0) nil (4253 . 4256) (4204 . 4207) (4168 . 4171) (4125 . 4128) (t 23207 27948 0 0) nil ("
" . -1) 2 nil (";; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

" . 1) (t 23207 27705 0 0)))
