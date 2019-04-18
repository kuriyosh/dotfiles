;;; narrow-reindent-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "narrow-reindent" "narrow-reindent.el" (0 0
;;;;;;  0 0))
;;; Generated autoloads from narrow-reindent.el

(autoload 'narrow-reindent-mode "narrow-reindent" "\
Toggle Narrow-Reindent mode.

When Narrow-Reindent mode is active, after narrowing the buffer
is re-indented. Before widening, this narrowed region is
re-indented again. This mode uses the `indent-region' to perform
indentation.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "narrow-reindent" '("narrow-reindent-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; narrow-reindent-autoloads.el ends here
