;;; 21-quickrun.el --- quickrun

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

(push '("*quickrun*") popwin:special-display-config)

(eval-after-load "quickrun"
  '(progn
     (quickrun-add-command "clang++/c11"
                           '((:command . "clang++")
                             (:exec    . ("%c %o -o %e %s"
                                          "%e %a"))
                             (:cmdopt . "-std=c++11 -stdlib=libc++ -Wall -Wextra -pthread")
                             (:remove . ("%e"))
                             :default "c++"))))

(provide '21-quickrun)
;;; 21-quickrun.el ends here
