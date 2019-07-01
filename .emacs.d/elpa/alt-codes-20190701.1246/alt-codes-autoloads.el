;;; alt-codes-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "alt-codes" "alt-codes.el" (0 0 0 0))
;;; Generated autoloads from alt-codes.el

(autoload 'alt-codes-insert "alt-codes" "\
Insert the alt-code by string.

\(fn)" t nil)

(autoload 'alt-codes-mode "alt-codes" "\
Minor mode for inserting `alt-codes'.

\(fn &optional ARG)" t nil)

(defvar global-alt-codes-mode nil "\
Non-nil if Global Alt-Codes mode is enabled.
See the `global-alt-codes-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-alt-codes-mode'.")

(custom-autoload 'global-alt-codes-mode "alt-codes" nil)

(autoload 'global-alt-codes-mode "alt-codes" "\
Toggle Alt-Codes mode in all buffers.
With prefix ARG, enable Global Alt-Codes mode if ARG is positive;
otherwise, disable it.  If called from Lisp, enable the mode if
ARG is omitted or nil.

Alt-Codes mode is enabled in all buffers where
`alt-codes-turn-on-alt-codes-mode' would do it.
See `alt-codes-mode' for more information on Alt-Codes mode.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "alt-codes" '("alt-codes-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; alt-codes-autoloads.el ends here
