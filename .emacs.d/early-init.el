;;; early-init.el --- Early init for Emacs 31.x  -*- lexical-binding: t; -*-

;; `package-enable-at-startup' は既定 (t) のままにする。
;; Emacs 31 は起動時に user-lisp/ を自動でバイトコンパイルするが、その処理は
;; package の有効化直後・init.el より前に走る。ここで無効化すると、
;; daml-mode.el が依存する haskell-mode が load-path に無いままコンパイルされて
;; "Cannot open load file: haskell-mode" になる。

;;; early-init.el ends here
