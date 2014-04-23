;;; 01-emacsclient.el --- emacsclient setting

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

;; emacsclient
(require 'server)
(unless (server-running-p)
  (server-start))

;(defun iconify-emacs-when-server-is-done ()
;  (unless server-clients (iconify-frame)))

;(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key (kbd "C-x C-c") 'server-edit)
(defalias 'exit 'save-buffers-kill-emacs)


(provide '01-emacsclient)
;;; 01-emacsclient.el ends here
