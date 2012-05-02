;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_twit.el --- twittering-mode

;; Copyright (C) 2010  kozaki

;; Author: koko_u <kozaki.tsuneaki@gmail.cm>
;; Keywords: twitter

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

;;; Code:
(require 'twittering-mode)

(setq twittering-use-master-password t)
(setq twittering-initial-timeline-spec-string
      '(
        "koko_u/ruby"
        "koko_u/rinjin"
        ":direct_messages"
        ":replies"
        ":home"
        ))
(setq twittering-status-format
      "%i %s(%S),  %C{%_2m月%_2d日(%a) %_2H時%_2M分}:\n%FILL[  ]{%T // from %f%L%r%R}\n ")
(add-hook 'twittering-mode-hook
          '(lambda ()
             (twittering-icon-mode t)))
(add-hook 'twittering-edit-mode-hook
          '(lambda ()
             (turn-off-auto-fill)))

(provide 'init_twit)
;;; init_ac.el ends here