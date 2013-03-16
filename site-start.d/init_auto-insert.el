;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_auto-insert.el --- auto-insert-mode

;; Copyright (C) 2010  kozaki

;; Author: koko_u <kozaki.tsuneaki@gmail.cm>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
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

;;; Code:
(require 'autoinsert)
(require 'auto-insert-choose)
(add-hook 'find-file-hook 'auto-insert)
(setq auto-insert-directory (expand-file-name "~/.emacs.d/auto-insert/"))
(setq auto-insert-query nil)
(add-to-list 'auto-insert-alist
             '(("\\.js\.shd$" . "JavaScript shadow...")
               nil
               "# -*- mode: coffee; shadow-command: \"coffee -cps\"; -*-\n"
               ))

(defun select-template-file ()
  (let* ((template-alist '(("more" . "template.more.t")
                           ("oktest" . "template.oktest.t")))
         (type (completing-read "Type: " template-alist nil t "more"))
         (template-filename (concat (file-name-as-directory auto-insert-directory)
                                    (cdr (assoc type template-alist)))))
    (insert-file-contents template-filename)))

(defun convert-package-name (fullpath)
  (let ((dirnames (reverse (split-string fullpath "/")))
        (packagename "")
        (foundlibdir nil)
        )
    (while (and dirnames
                (not foundlibdir))
      (let ((dir (car dirnames)))
        (if (string= dir "lib")
            (setq foundlibdir 't)
          (setq packagename (concat dir "::" packagename))))
      (setq dirnames (cdr dirnames))
      )
    (if foundlibdir
        (replace-regexp-in-string "\.pm::$" "" packagename)
      (read-string "Package name: "))
    )
  )
(setq auto-insert-alist
      (nconc '(
               ("\\.pl$" . "template.pl")
               (("\\.t$" . "Perl test script") . select-template-file)
               (("\\.pm$" . "Perl module")
                nil
                "package " (convert-package-name (buffer-file-name)) ";" n
                ""                                                       n
                "use warnings;"                                          n
                "use strict;"                                            n
                "use diagnostics;"                                       n
                "use utf8;"                                              n
                _                                                        n
                "1;")
               ) auto-insert-alist))

(provide 'init_auto-insert)
;;; init_auto-insert.el ends here