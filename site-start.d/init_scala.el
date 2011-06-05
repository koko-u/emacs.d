;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_scala.el --- scala-mode

;; Copyright (C) 2010  kozaki

;; Author: koko_u <kozaki.tsuneaki@gmail.cm>
;; Keywords: scala

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
(require 'scala-mode-auto)
(require 'scala-mode-feature-electric)

(add-hook 'scala-mode-hook
          (lambda ()
            (scala-electric-mode)))

(defadvice scala-eval-region (after pop-after-scala-eval-region)
  (pop-to-buffer scala-inf-buffer-name))
(ad-activate 'scala-eval-region)

(defadvice scala-eval-buffer (after pop-after-scala-eval-buffer)
  (pop-to-buffer scala-inf-buffer-name))
(ad-activate 'scala-eval-buffer)

;; ENSIME
;; you should install the pacakge from https://github.com/aemoncannon/ensime/downloads
(require 'ensime)

;; This sep causes the ensime-mode to be started whenever
;; scala-mode is started for a buffer. You may have to customize
;; this step if you're not using the standard scala-mode
(add-hook 'scala-mode-hook
          'ensime-scala-mode-hook)

(provide 'init_scala)
;;; init_scala.el ends here