;;; 21-js.el --- js2-mode

;; Copyright (C) 2014  kozaki.tsuneaki

;; Author: kozaki.tsuneaki <kozaki.tsuneaki@gmail.com>
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

;;

;;; Code:

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(custom-set-variables
 '(inferior-js-program-command "env NODE_NO_READLINE=1 node"))

(add-hook 'inferior-js-mode-hook 'ansi-color-for-comint-mode-on)

(add-hook 'js2-mode-hook
          '(lambda ()
             (define-key js2-mode-map (kbd "C-x C-e") 'js-send-last-sexp)
             (define-key js2-mode-map (kbd "C-M-x") 'js-send-last-sexp-and-go)
             (define-key js2-mode-map (kbd "C-c b") 'js-send-buffer)
             (define-key js2-mode-map (kbd "C-c C-b") 'js-send-buffer-and-go)
             (define-key js2-mode-map (kbd "C-c l") 'js-load-file-and-go)
             (define-key js2-mode-map (kbd "C-c C-r") 'js-send-region)
             ))


(provide '21-js)
;;; 21-js.el ends here
