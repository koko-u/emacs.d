;;; 10-fortune.el ---                                -*- lexical-binding: t; -*-

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

;; ;; Supply a random fortune cookie as the *scratch* message.
;; (when (executable-find "fortune")
;;   (setq initial-scratch-message
;;         (with-temp-buffer
;;           (shell-command "fortune" t)
;;           (let ((comment-start ";;"))
;;             (comment-region (point-min) (point-max)))
;;           (concat (buffer-string) "\n"))))

(setq fortune-dir "/usr/share/games/fortunes"
      fortune-file "/usr/share/games/fortunes/fortunes")

(provide '10-fortune)
;;; 10-fortune.el ends here
