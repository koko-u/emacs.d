;;; 21-flex-autopair.el ---

;; Copyright (C) 2015  kozaki.tsuneaki

;; Author: kozaki.tsuneaki <kozaki.tsuneaki@gmail.com>
;; Keywords: abbrev

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

;; SEE http://d.hatena.ne.jp/uk-ar/20120401/1333282805

;;; Code:

(require 'flex-autopair)
(flex-autopair-mode 1)

(setq flex-autopair-c-conditions
  '(((and (eq last-command-event ?<)
          (flex-autopair-match-linep
           "#include\\|#import\\|static_cast\\|dynamic_cast")) . pair)
    ;; work with key-combo
    ((and (eq last-command-event ?<)
          (boundp 'key-combo-mode)
          (eq key-combo-mode t)) . space-self-space)
    ((and (eq last-command-event ?<)) . self)
    ((and (eq last-command-event ?{)
          (or (eq (char-before (point)) ?\s)
              (eq (char-before (point)) ?\t)))
     . pair-and-new-line)))


(provide '21-flex-autopair)
;;; 21-flex-autopair.el ends here
