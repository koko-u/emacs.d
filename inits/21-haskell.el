;;; 21-haskell.el ---                                -*- lexical-binding: t; -*-

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

(autoload 'haskell-mode "haskell-mode" nil t)
(autoload 'haskell-cabal "haskell-cabal" nil t)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)

(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-haskell-mode))
(add-to-list 'auto-mode-alist '("\\.cabal$" . haskell-mode))

(defun my-haskell-mode-hook ()
  (interactive)
  ;; indentation
  (haskell-indentation-mode nil)
  ;; pretty-mode
  ;(turn-on-pretty-mode)
  ;; structured haskell mode
  (structured-haskell-mode t)
  (set-face-background 'shm-current-face "#eee8d5")
  (set-face-background 'shm-quarantine-face "lemonchiffon")
  (turn-on-haskell-doc-mode)
  (imenu-add-menubar-index)
  ;; ghci command
  (setq haskell-program-name "/usr/local/bin/stack ghci")
  (inf-haskell-mode)
  ;; initialize ghc-mod
  (ghc-init)
  ;; ebal with stack
  (setq ebal-operation-mode 'stack)
  )

(add-hook 'haskell-mode-hook 'my-haskell-mode-hook)

(provide '21-haskell)
;;; 21-haskell.el ends here
