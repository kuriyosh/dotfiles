;;; daml-mode.el --- Major mode for Daml  -*- lexical-binding: t; -*-

;;; Commentary:

;; Daml 用のメジャーモード。Daml は Haskell の方言なので `haskell-mode'
;; から派生させ、Daml 固有の予約語と台帳操作関数のハイライトだけを足す。
;; Eglot が読み込まれていれば `daml ide' を LSP サーバとして登録する。

;;; Code:

(require 'haskell-mode)
(require 'haskell-font-lock)
(require 'haskell-indent)

(defgroup daml nil
  "Major mode for editing Daml source code."
  :group 'languages
  :prefix "daml-")

(defcustom daml-keywords
  '("agreement" "can" "choice" "controller" "ensure" "exception" "for"
    "implements" "interface" "key" "magreement" "maintainer" "message"
    "nonconsuming" "observer" "postconsuming" "preconsuming" "requires"
    "signatory" "template" "viewtype" "with")
  "Daml の予約語のうち Haskell では予約語でないもの。
`haskell-keyword-face' で描画する。"
  :type '(repeat string)
  :group 'daml)

(defcustom daml-builtin-functions
  '("allocateParty" "allocatePartyWithHint" "archive" "archiveCmd"
    "assert" "assertMsg" "create" "createAndExercise" "createCmd"
    "exercise" "exerciseByKey" "exerciseByKeyCmd" "exerciseCmd"
    "fetch" "fetchByKey" "getTime" "lookupByKey" "script"
    "submit" "submitMulti" "submitMultiMustFail" "submitMustFail")
  "台帳操作と Daml Script のアクション。
`font-lock-builtin-face' で描画する。nil にすると通常の識別子として扱う。"
  :type '(repeat string)
  :group 'daml)

(defcustom daml-special-variables '("self" "this")
  "テンプレート本文で暗黙に束縛される変数。
`font-lock-constant-face' で描画する。"
  :type '(repeat string)
  :group 'daml)

(defcustom daml-indentation-style 'cycle
  "Daml バッファで使うインデント方式。

`cycle'  `haskell-indent-mode'。TAB で候補を巡回する。
`layout' `haskell-indentation-mode'。Haskell のレイアウト規則から推論する。
         Daml のテンプレート構文は推論対象外なので誤爆しやすい。
nil      どちらも使わない。"
  :type '(choice (const :tag "haskell-indent-mode (TAB で巡回)" cycle)
                 (const :tag "haskell-indentation-mode (レイアウト推論)" layout)
                 (const :tag "使わない" nil))
  :group 'daml)

(defun daml--font-lock-keywords ()
  "Daml 用の font-lock ルールを生成する。
Daml 固有のルールを `haskell-font-lock-keywords' の結果より前に置く。
Haskell 側の識別子マッチャは face が未設定の範囲しか塗らないため、
先に置いたルールが勝つ。"
  (append
   (when daml-builtin-functions
     `((,(concat "\\_<" (regexp-opt daml-builtin-functions t) "\\_>")
        1 font-lock-builtin-face)))
   (when daml-special-variables
     `((,(concat "\\_<" (regexp-opt daml-special-variables t) "\\_>")
        1 font-lock-constant-face)))
   (haskell-font-lock-keywords)))

;;;###autoload
(define-derived-mode daml-mode haskell-mode "Daml"
  "Major mode for editing Daml source code."
  ;; haskell-mode は font-lock 実行中に `haskell-font-lock-keywords' を
  ;; 直接参照して予約語を判定する。グローバル値を書き換えると素の Haskell
  ;; バッファまで巻き込むので、バッファローカルに拡張する。
  (setq-local haskell-font-lock-keywords
              (append haskell-font-lock-keywords daml-keywords))
  (setq-local font-lock-defaults
              '((daml--font-lock-keywords)
                nil nil nil nil
                (font-lock-syntactic-face-function
                 . haskell-syntactic-face-function)
                (parse-sexp-lookup-properties . t)
                (font-lock-extra-managed-props composition haskell-type))))

(defun daml--setup-minor-modes ()
  "インデント方式を `daml-indentation-style' に合わせ、GHCi 連携を切る。"
  (pcase daml-indentation-style
    ('cycle (haskell-indentation-mode -1)
            (haskell-indent-mode 1))
    ('layout (haskell-indentation-mode 1))
    (_ (haskell-indentation-mode -1)
       (haskell-indent-mode -1)))
  ;; Daml に GHCi はない。
  (when (fboundp 'interactive-haskell-mode)
    (interactive-haskell-mode -1)))

;; `define-derived-mode' は親 `haskell-mode' の hook を遅延実行キューに積み、
;; daml-mode の body より後に走らせる。`haskell-mode-hook' のデフォルト値が
;; `haskell-indentation-mode' と `interactive-haskell-mode' を有効化するため、
;; body で設定しても上書きされる。深さ -100 の `daml-mode-hook' なら親 hook の
;; 後、かつユーザーが足した hook より前に走る。
(add-hook 'daml-mode-hook #'daml--setup-minor-modes -100)

(defun daml--project-root (dir)
  "DIR を含む Daml プロジェクトのルートを返す。
`daml.yaml' のある最も近い上位ディレクトリをルートとする。"
  (when-let* ((root (locate-dominating-file dir "daml.yaml")))
    (cons 'transient root)))

;; `daml ide' は daml.yaml のあるディレクトリでしか起動できない。monorepo で
;; VCS ルートを掴まれると死ぬので、VCS 検出より前に割り込ませる。
(add-hook 'project-find-functions #'daml--project-root -90)

(defvar eglot-server-programs)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(daml-mode . ("daml" "ide"))))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.daml\\'" . daml-mode))

(provide 'daml-mode)
;;; daml-mode.el ends here
