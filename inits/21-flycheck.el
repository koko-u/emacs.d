;;; 21-flycheck.el --- flycheck

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

(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-clang-language-standard "c++11")
    '(flycheck-clang-include-path '("/usr/include/c++/v1" "./include" "../include"))
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
    '(flycheck-pos-tip-timeout 10)
    ))

(provide '21-flycheck)
;;; 21-flycheck.el ends here
