;;; 21-twit.el --- twitter client

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

(eval-after-load "twittering-mode"
  '(progn
     (setq twittering-use-master-password t)
     (setq twittering-initial-timeline-spec-string
           '(
             ":home"
             ":replies"
             ":direct_messages"
             ))
     (setq twittering-status-format
           "%i %s(%S),  %C{%_2m月%_2d日(%a) %_2H時%_2M分}:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
     (setq twittering-icon-mode t)
     ))


(provide '21-twit)
;;; 21-twit.el ends here
