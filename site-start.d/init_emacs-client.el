;;; init_emacs-client.el --- シェルからEmacsにアクセスする

;; Copyright (C) 2011  kozaki.tsuneaki

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

;; ファイルを編集するたびに毎回シェルから Emacs を立ち上げると、起動に時間がかか
;; ります。そこで、現在の Emacs にアクセスすることで、シェルから一瞬で起動できる
;; ように改善します。

;;; Code:

(server-start)
(defun iconify-emacs-when-server-is-done ()
  (unless server-clients (iconify-frame)))

(add-hook 'server-done-hook 'iconify-emacs-when-server-is-done)
(global-set-key (kbd "C-x C-c") 'server-edit)
(defalias 'exit 'save-buffers-kill-emacs)

(provide 'init_emacs-client)
;;; init_emacs-client.el ends here
