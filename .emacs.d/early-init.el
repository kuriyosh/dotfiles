;;; early-init.el --- Early init for Emacs 31.x  -*- lexical-binding: t; -*-

;; package-enable-at-startup は既定 (t) のままにする。
;; Emacs 31 は init.el より前に user-lisp/ をバイトコンパイルする
;; (`prepare-user-lisp')。daml-mode.el は haskell-mode (ELPA) を require するため、
;; その前に ELPA パッケージが load-path に入っていないとコンパイルが失敗する。

;;; early-init.el ends here
