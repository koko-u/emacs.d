;;; 20-package.el --- melpa

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

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; refresh package info
(package-refresh-contents)

;; my favorite packages
(defvar my/favorite-packages
  '(
    ;; auto-complete
    ac-c-headers
    ac-inf-ruby
    ac-js2
    auto-complete
    auto-complete-clang
    auto-complete-c-headers

    ;; fast search
    ag
    wgrep-ag

    ;; flycheck
    flycheck
    flycheck-color-mode-line
    flycheck-pos-tip

    ;; utility
    auto-async-byte-compile
    direx
    flex-autopair
    google-translate
    magit
    magit-filenotify
    magit-gh-pulls
    magit-push-remote
    powerline
    quickrun
    visual-regexp
    w3

    ;; various mode
    coffee-mode
    cperl-mode
    dummy-h-mode
    js2-mode
    js2-refactor
    markdown-mode
    twittering-mode
    web-mode
    zencoding-mode

    ;; ruby
    enh-ruby-mode
    inf-ruby
    rspec-mode
    ruby-block
    ruby-compilation
    ruby-electric
    ruby-end
    ruby-guard
    ruby-interpolation
    ruby-refactor
    smart-compile

    ;; helm
    helm
    helm-ag
    helm-c-moccur
    helm-c-yasnippet
    helm-descbinds
    helm-flycheck
    helm-git
    helm-gtags
    helm-helm-commands
    helm-perldoc
    all-ext
    
    ))

;; install favorite packages
(dolist (package my/favorite-packages)
  (unless (package-installed-p package)
    (package-install package)))

(provide '20-package)
;;; 20-package.el ends here
