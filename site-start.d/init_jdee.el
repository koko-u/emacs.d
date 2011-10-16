;;; init_jdee.el --- 

;; Copyright (C) 2011  kozaki.tsuneaki

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

(setenv "JAVA_HOME" "/usr/lib/jvm/java-6-openjdk")
(setenv "JAVA_VERSION" "1.6.0")
(setenv "ANT_HOME" "/usr/share/ant")

(require 'cedet)
(setq semantic-load-turn-everything-on t)
(setq semanticdb-default-save-directory "~/.emacs.d/var/semantic")

(autoload 'jde-mode "jde" "Java Development Environment for Emacs" t)
(add-to-list 'auto-mode-alist '("\\.java$" . jde-mode))
(setq bsh-jar "~/.emacs.d/lisp/jde/java/lib/bsh.jar")

;; コンパイルメッセージの縦幅
(setq compilation-window-height 8)

;; ant の設定
(setq jde-ant-anable-find t)
(setq jde-ant-home "/usr/share/ant")
(setq jde-ant-program "/usr/share/ant/bin/ant")
(setq jde-ant-read-target t)
(setq jde-build-function (quote (jde-ant-build)))

(setq jde-jdk '("1.6.0"))
(setq jde-jdk-registry '(("1.6.0" . "/usr/lib/jvm/java-6-openjdk")))

(setq jde-jdk-doc-url "http://java.sun.com/javase/ja/6/docs/ja/api/index.html")

;; クラスpath
(setq jde-global-classpath '(
                             "/usr/share/java/junit4.jar"
                             "/usr/share/java/log4j-1.2.jar"
                             "~/.emacs.d/lisp/jde/java/lib"
                             ))

;; checkstyle の形式
(setq jde-checkstyle-option-rcurly (list "alone"))

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

;; ajc-java-complete
(require 'ajc-java-complete-config)

(add-hook 'java-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (c-set-style "java2")
             (ajc-java-complete-mode)
             (auto-revert-mode 1)
             ))


(provide 'init_jdee)
;;; init_jdee.el ends here
