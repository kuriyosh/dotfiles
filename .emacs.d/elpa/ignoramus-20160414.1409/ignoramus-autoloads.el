;;; ignoramus-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ignoramus" "ignoramus.el" (0 0 0 0))
;;; Generated autoloads from ignoramus.el

(define-obsolete-variable-alias 'ignoramus-file-endings 'ignoramus-file-basename-endings)

(define-obsolete-variable-alias 'ignoramus-file-beginnings 'ignoramus-file-basename-beginnings)

(define-obsolete-variable-alias 'ignoramus-file-exact-names 'ignoramus-file-basename-exact-names)

(define-obsolete-variable-alias 'ignoramus-file-regexps 'ignoramus-file-basename-regexps)

(let ((loads (get 'ignoramus 'custom-loads))) (if (member '"ignoramus" loads) nil (put 'ignoramus 'custom-loads (cons '"ignoramus" loads))))

(let ((loads (get 'ignoramus-patterns 'custom-loads))) (if (member '"ignoramus" loads) nil (put 'ignoramus-patterns 'custom-loads (cons '"ignoramus" loads))))

(autoload 'ignoramus-matches-datafile "ignoramus" "\
Return non-nil if FILE is used for data storage by a known Lisp library.

This function identifies specific files used for persistence by
tramp, semantic, woman, etc.

If a Lisp library is loaded after ignoramus, its files may not
be recognized, in which case `ignoramus-compute-common-regexps'
maybe called.

FILE-BASENAME may also be given as an optimization, in case the
caller has already computed the basename.

As an optimization, EXPANDED may be set to t to indicate that FILE
has already been expanded.

\(fn FILE &optional FILE-BASENAME EXPANDED)" nil nil)

(autoload 'ignoramus-register-datafile "ignoramus" "\
Register a generated file used for data storage.

This generated file will be ignored by ignoramus.

SYMBOL-OR-STRING may be the name of a symbol to consult, or a
string.  If a symbol, it should refer to a string or list of
strings.

TYPE may be one of 'basename, 'completepath, 'prefix, or
'dirprefix.

Optional UNREGISTER tells ignoramus to forget about
SYMBOL-OR-STRING.

\(fn SYMBOL-OR-STRING TYPE &optional UNREGISTER)" nil nil)

(autoload 'ignoramus-boring-p "ignoramus" "\
Return non-nil if ignoramus thinks FILE is uninteresting.

FILE-BASENAME may also be given as an optimization, in case the
caller has already computed the basename.

As an optimization, EXPANDED may be set to t to indicate that FILE
has already been expanded.

This function does not chase symlinks on FILE (see `file-truename').
It may be changed to do so in the future.  You will probably get
fewer surprises if symlinks in FILE are already resolved.

\(fn FILE &optional FILE-BASENAME EXPANDED)" nil nil)

(autoload 'ignoramus-setup "ignoramus" "\
Turn on ignoring files for all members of sequence ACTIONS.

ACTIONS is optional, and defaults to the value of
`ignoramus-default-actions'.

If ACTIONS contains 'all, turn on ignoring files for all
actions in `ignoramus-known-actions'.

\(fn &optional ACTIONS)" nil nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ignoramus" '("ignoramus-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ignoramus-autoloads.el ends here
