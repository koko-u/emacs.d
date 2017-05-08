;;; 20-popwin.el ---                                 -*- lexical-binding: t; -*-

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

(require 'popwin)
(popwin-mode 1)

(setq special-display-function 'popwin:special-display-popup-window)
(push '("*Help" :position right :noselect t) popwin:special-display-config)
(push '("*auto-async-byte-compile" :height 5 :position bottom) popwin:special-display-config)
(push '("*Racer Help*" :width 60 :position right) popwin:special-display-config)

(provide '20-popwin)
;;; 20-popwin.el ends here
