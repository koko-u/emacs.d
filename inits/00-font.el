;;; 00-font.el ---                       -*- lexical-binding: t; -*-

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

(set-face-attribute 'default nil :family "Ricty" :height 140)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (font-spec :family "Ricty"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (font-spec :family "Ricty"))
;;(add-to-list 'face-font-rescale-alist '("Ricty.*" . 1.2))

(provide '00-font)
;;; windows-enviornment.el ends here
