;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_javascript.el --- javascript setting

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; 

;;; Code:
;(autoload 'javascript-mode "javascript" nil t)
;(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))

;(add-hook 'javascript-mode-hook
;          (function
;           (lambda ()
;             (setq tab-width 4)
;             (setq javascript-indent-level 4)
;             (setq javascript-basic-offset tab-width)
;             )))

;; @see http://code.google.com/p/js2-mode/wiki/InstallationInstructions
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

(autoload 'js-comint "js-comint" nil t)

(setq inferior-js-program-command "java org.mozilla.javascript.tools.shell.Main")

(add-hook 'js2-mode-hook
          (lambda ()
            (setq tab-width 2)
            (setq js2-basic-offset tab-width)
            (local-set-key (kbd "C-x C-e") 'js-send-last-sexp)
            (local-set-key (kbd "C-M-x") 'js-send-last-sexp-and-go)
            (local-set-key (kbd "C-c b") 'js-send-buffer)
            (local-set-key (kbd "C-c C-b") 'js-send-buffer-and-go)
            (local-set-key (kbd "C-c l") 'js-load-file-and-go)
            ))

(provide 'init_javascript)
;;; init_javascript.el ends here