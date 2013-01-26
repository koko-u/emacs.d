;;; init_haskell.el --- Haskell mode

;; Copyright (C) 2012  kozaki.tsuneaki

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

;; ghc-mod
(add-to-list 'exec-path (concat (getenv "HOME") "/.cabal/bin"))
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook
          '(lambda ()
             (ghc-init)
             (flymake-mode)))


(provide 'init_haskell)
;;; init_haskell.el ends here
