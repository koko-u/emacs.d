;;; 21-direx.el --- direx

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

(require 'popwin)
(custom-set-variables
 '(display-buffer-function 'popwin:display-buffer)
 '(direx:leaf-icon "  ")
 '(direx:open-icon "▾ ")
 '(direx:closed-icon "▸ "))

(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)

(defun direx:jump-to-project-directory ()
  (interactive)
  (let ((result (ignore-errors
                  (direx-project:jump-to-project-root-other-window)
                  t)))
    (unless result
      (direx:jump-to-directory-other-window))))

(global-set-key (kbd "C-x C-j") 'direx:jump-to-project-directory)

(provide '21-direx)
;;; 21-direx.el ends here
