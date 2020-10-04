;;; ox-qmd.el --- Qiita Markdown Back-End for Org Export Engine

;; Copyright (C) 2015,2016 0x60DF

;; Author: 0x60DF <0x60DF@gmail.com>
;; URL: https://github.com/0x60df/ox-qmd
;; Version: 1.0.0
;; Package-Requires: ((org "8.0"))
;; Keywords: org, wp, markdown, qiita

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This library implements a Markdown back-end (qiita flavor) for
;; Org exporter, based on `md' back-end and `gfm' back-end.

;; See http://orgmode.org/ for infomation about Org-mode and `md' back-end.
;; See http://github.com/larstvei/ox-gfm for information about `gfm' back-end.

;;; Code:

(require 'ox-md)


;;; User-Configurable Variables

(defvar ox-qmd-language-keyword-alist '(("emacs-lisp" . "el")))
(defvar ox-qmd-unfill-paragraph t)



;;; Define Back-End

(org-export-define-derived-backend 'qmd 'md
  :filters-alist '((:filter-paragraph . org-qmd--unfill-paragraph))
  :menu-entry
  '(?9 "Export to Qiita Markdown"
       ((?0 "To temporary buffer"
            (lambda (a s v b) (org-qmd-export-as-markdown a s v)))
        (?9 "To file" (lambda (a s v b) (org-qmd-export-to-markdown a s v)))
        (?o "To file and open"
            (lambda (a s v b)
              (if a (org-qmd-export-to-markdown t s v)
                (org-open-file (org-qmd-export-to-markdown nil s v)))))
        (?s "To temporary buffer from subtree"
            (lambda (a s v b) (org-qmd-export-as-markdown a t v)))))
  :translate-alist '((headline . org-qmd--headline)
                     (inner-template . org-qmd--inner-template)
                     (keyword . org--qmd-keyword)
					 (link . my-org-md-link)
                     (strike-through . org-qmd-strike-through)
                     (src-block . org-qmd--src-block)
					 (example-block . my-org-md-example-block)))



;;; Filters

(defun org-qmd--unfill-paragraph (paragraph backend info)
  "Remove newline from PARAGRAPH and replace line-break string with newline
in PARAGRAPH if user-configurable variable ox-qmd-unfill-paragraph is non-nil."
  (if (and (org-export-derived-backend-p backend 'qmd)
           ox-qmd-unfill-paragraph)
      (concat (replace-regexp-in-string
               "  \n" "\n" (replace-regexp-in-string
                            "\\([^ ][^ ]\\)\n" "\\1" paragraph)) "\n")
    paragraph))

;; Links
;; MEMO: 仕事上 URL の左右い <> がついていると困ることがあるので消す
(defun my-org-md-link (link contents info)
  "Transcode LINE-BREAK object into Markdown format.
CONTENTS is the link's description.  INFO is a plist used as
a communication channel."
  (let ((link-org-files-as-md
	 (lambda (raw-path)
	   ;; Treat links to `file.org' as links to `file.md'.
	   (if (string= ".org" (downcase (file-name-extension raw-path ".")))
	       (concat (file-name-sans-extension raw-path) ".md")
	     raw-path)))
	(type (org-element-property :type link)))
    (cond
     ;; Link type is handled by a special function.
     ((org-export-custom-protocol-maybe link contents 'md))
     ((member type '("custom-id" "id" "fuzzy"))
      (let ((destination (if (string= type "fuzzy")
			     (org-export-resolve-fuzzy-link link info)
			   (org-export-resolve-id-link link info))))
	(pcase (org-element-type destination)
	  (`plain-text			; External file.
	   (let ((path (funcall link-org-files-as-md destination)))
	     (if (not contents) (format "< %s >" path)
	       (format "[%s](%s)" contents path))))
	  (`headline
	   (format
	    "[%s](#%s)"
	    ;; Description.
	    (cond ((org-string-nw-p contents))
		  ((org-export-numbered-headline-p destination info)
		   (mapconcat #'number-to-string
			      (org-export-get-headline-number destination info)
			      "."))
		  (t (org-export-data (org-element-property :title destination)
				      info)))
	    ;; Reference.
	    (or (org-element-property :CUSTOM_ID destination)
		(org-export-get-reference destination info))))
	  (_
	   (let ((description
		  (or (org-string-nw-p contents)
		      (let ((number (org-export-get-ordinal destination info)))
			(cond
			 ((not number) nil)
			 ((atom number) (number-to-string number))
			 (t (mapconcat #'number-to-string number ".")))))))
	     (when description
	       (format "[%s](#%s)"
		       description
		       (org-export-get-reference destination info))))))))
     ((org-export-inline-image-p link org-html-inline-image-rules)
      (let ((path (let ((raw-path (org-element-property :path link)))
		    (cond ((not (equal "file" type)) (concat type ":" raw-path))
			  ((not (file-name-absolute-p raw-path)) raw-path)
			  (t (expand-file-name raw-path)))))
	    (caption (org-export-data
		      (org-export-get-caption
		       (org-export-get-parent-element link)) info)))
	(format "![img](%s)"
		(if (not (org-string-nw-p caption)) path
		  (format "%s \"%s\"" path caption)))))
     ((string= type "coderef")
      (let ((ref (org-element-property :path link)))
	(format (org-export-get-coderef-format ref contents)
		(org-export-resolve-coderef ref info))))
     ((equal type "radio") contents)
     (t (let* ((raw-path (org-element-property :path link))
	       (path
		(cond
		 ((member type '("http" "https" "ftp" "mailto"))
		  (concat type ":" raw-path))
		 ((string= type "file")
		  (org-export-file-uri (funcall link-org-files-as-md raw-path)))
		 (t raw-path))))
	  (if (not contents) (format "< %s >" path)
	    (format "[%s](%s)" contents path)))))))

;;; Transcode Functions

;;;; Headline

(defun org-qmd--headline (headline contents info)
  "Transcode HEADLINE element into Qiita Markdown format.
CONTENTS is the headline contents.  INFO is a plist used as
a communication channel."
  (let* ((info (copy-sequence info))
         (info (plist-put info :with-toc nil)))
    (org-md-headline headline contents info)))


;;;; Template

(defun org-qmd--inner-template (contents info)
  "Return body of document after converting it to Qiita Markdown syntax.
CONTENTS is the transcoded contents string.  INFO is a plist
holding export options."
  (let* ((info (copy-sequence info))
         (info (plist-put info :with-toc nil)))
    (org-md-inner-template contents info)))


;;;; keyword

(defun org-qmd--keyword (keyword contents info)
  "Transcode a KEYWORD element into Qiita Markdown format.
CONTENTS is nil.  INFO is a plist holding contextual information."
  (let* ((info (copy-sequence info))
         (info (plist-put info :with-toc nil)))
    (org-html-keyword keyword contents info)))


;;;; Src Block

(defun org-qmd--src-block (src-block contents info)
  "Transcode SRC-BLOCK element into Qiita Markdown format.
CONTENTS is nil.  INFO is a plist used as a communication
channel."
  (let* ((lang (org-element-property :language src-block))
         (lang (or (cdr (assoc lang ox-qmd-language-keyword-alist)) lang))
         (name (org-element-property :name src-block))
         (code (org-export-format-code-default src-block info))
         (prefix (concat "```" lang (if name (concat ":" name) nil) "\n"))
         (suffix "```"))
    (concat prefix code suffix)))


;;;; Strike Through

(defun org-qmd-strike-through (strike-through contents info)
  (format "~~%s~~" contents))

;; quote
(defun my-org-md-example-block (example-block _contents info)
  (replace-regexp-in-string
   "^" "> "
   (replace-regexp-in-string
	"\n\\'" ""
	(org-remove-indentation
	 (org-export-format-code-default example-block info)))))

;;; Interactive function

;;;###autoload
(defun org-qmd-export-as-markdown (&optional async subtreep visible-only)
  "Export current buffer to a Qiita Markdown buffer.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting buffer should be accessible
through the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Export is done in a buffer named \"*Org QMD Export*\", which will
be displayed when `org-export-show-temporary-export-buffer' is
non-nil."
  (interactive)
  (org-export-to-buffer 'qmd "*Org QMD Export*"
    async subtreep visible-only nil nil (lambda () (text-mode))))

;;;###autoload
(defun org-qmd-convert-region-to-md ()
  "Assume the current region has org-mode syntax, and convert it to
Qiita Markdown. This can be used in any buffer.  For example, you can write an
itemized list in org-mode syntax in a Markdown buffer and use
this command to convert it."
  (interactive)
  (org-export-replace-region-by 'qmd))


;;;###autoload
(defun org-qmd-export-to-markdown (&optional async subtreep visible-only)
  "Export current buffer to a Qiita Markdown file.

If narrowing is active in the current buffer, only export its
narrowed part.

If a region is active, export that region.

A non-nil optional argument ASYNC means the process should happen
asynchronously.  The resulting file should be accessible through
the `org-export-stack' interface.

When optional argument SUBTREEP is non-nil, export the sub-tree
at point, extracting information from the headline properties
first.

When optional argument VISIBLE-ONLY is non-nil, don't export
contents of hidden elements.

Return output file's name."
  (interactive)
  (let ((outfile (org-export-output-file-name ".md" subtreep)))
    (org-export-to-file 'qmd outfile async subtreep visible-only)))

(provide 'ox-qmd)

;;; ox-qmd.el ends here
