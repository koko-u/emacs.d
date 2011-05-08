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


(provide 'init_coffee)
;;; init_ac.el ends here