;;; init_malabar.el --- Java major mode

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

;; 通常の java の設定

(setenv "JAVA_HOME" "/usr/lib/jvm/java-6-openjdk")
(setenv "JAVA_VERSION" "1.6.0")
(setenv "ANT_HOME" "/usr/share/ant")

;; codign style
(c-add-style "java2"
             '((c-basic-offset . 4)
               (c-comment-only-line-offset 0 . 0)
               (c-hanging-comment-starter-p)
               (c-offsets-alist .
                                ((inline-open . 0)
                                 (topmost-intro-cont . +)
                                 (statement-block-intro . +)
                                 (knr-argdecl-intro . 5)
                                 (substatement-open . +)
                                 (label . 0)
                                 (statement-case-open . +)
                                 (statement-cont . +)
                                 (arglist-intro . +)
                                 (arglist-close . 0)
                                 (access-label . 0)
                                 (inher-cont . c-lineup-java-inher)
                                 (func-decl-cont . c-lineup-java-throws)
                                 ))))


(add-hook 'java-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (c-set-style "java2")
             (auto-revert-mode 1)
             ))

(require 'cedet)
(setq semantic-default-submodes '(global-semantic-idle-scheduler-mode
                                  global-semanticdb-minor-mode
                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(semantic-mode 1)
(require 'malabar-mode)
(setq malabar-groovy-lib-dir "~/.emacs.d/lisp/malabar/lib")
(add-to-list 'auto-mode-alist '("\\.java\\'" . malabar-mode))

;;使わないパッケージを除外
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^java\\.awt\\..*$")
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^com\\.sun\\..*$")
(add-to-list 'malabar-import-excluded-classes-regexp-list
             "^org\\.omg\\..*$")

;; 日本語だと Groovy のメッセージが化ける
(setq malabar-groovy-java-options '("-Duser.language=en"))

(provide 'init_malabar)
;;; init_malabar.el ends here
