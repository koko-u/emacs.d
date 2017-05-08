;;; 21-rust.el ---                                   -*- lexical-binding: t; -*-

;; Copyright (C) 2017  kozaki.tsuneaki

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

(defun my-rust-mode-hook ()
  (interactive)
  (define-key rust-mode-map (kbd "TAB") 'company-indent-or-complete-common)
  (racer-mode)
  (company-mode)
  (flycheck-rust-setup)
  (setq company-tooltip-align-annotations t)
  (setq rust-format-on-save t))

(add-hook 'rust-mode-hook 'my-rust-mode-hook)
(add-hook 'racer-mode-hook 'eldoc-mode)

(provide '21-rust)
;;; 21-rust.el ends here
