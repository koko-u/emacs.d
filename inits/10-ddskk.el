;;; 10-ddskk.el --- DDSKK                            -*- lexical-binding: t; -*-

;; Copyright (C) 2015  kozaki.tsuneaki

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

(global-set-key (kbd "C-x j") 'skk-mode)

;(setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")
(setq skk-use-azik t)
(setq skk-azik-keyboard-type 'us)
(setq skk-show-annotation t)
(setq skk-show-inline t)

(provide '10-ddskk)
;;; 10-ddskk.el ends here
