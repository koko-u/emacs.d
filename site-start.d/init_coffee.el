;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_coffee.el --- coffee-script mode

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

;; インストール方法
;; git clone git://github.com/defunkt/coffee-mode.git

;;; Code:
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-custom ()
  "coffee-mode-hook"

  ;; .coffee ファイルを保存するたびに .js ファイルへとコンパイルする
  (add-hook 'after-save-hook
            '(lambda ()
               (when (string-match "\\.coffee<.*>$" (buffer-name))
                 (coffee-compile-file)))))

(add-hook 'coffee-mode-hook '(lambda () (coffee-custom)))

;; shadow mode
(require 'shadow)
(add-hook 'find-file-hook 'shadow-on-find-file)

;; flymake
(defvar flymake-coffeescript-err-line-patterns
  '(("\\(Error: In \\([^,]+\\), .+ on line \\([0-9]+\\).*\\)" 2 3 nil 1)))

(defconst flymake-allowed-coffeescript-file-name-masks
  '(("\\.coffee$" flymake-coffeescript-init)))

(defun flymake-coffeescript-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "coffee" (list local-file))))

(defun flymake-coffeescript-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks
        (append flymake-allowed-file-name-masks
                flymake-allowed-coffeescript-file-name-masks))
  (setq flymake-err-line-patterns flymake-coffeescript-err-line-patterns)
  (flymake-mode t))

(add-hook 'coffee-mode-hook 'flymake-coffeescript-load)

(provide 'init_coffee)
;;; init_ac.el ends here