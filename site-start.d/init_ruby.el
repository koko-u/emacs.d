;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_ruby.el --- ruby-mode

;; Copyright (C) 2010  kozaki

;; Author: koko_u <kozaki.tsuneaki@gmail.cm>
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

;; ruby-mode の設定

;;; Code:
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files")
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(autoload 'run-ruby "inf-ruby" "Run and inferior Ruby process")
(autoload 'info-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          (lambda ()
            (inf-ruby-keys)))
(autoload 'rubydb "rubydb3x"
  "run rubydb on program file in buffer *gud-file*.
the directory containing file becomes the initial working directory
and source-file directory for your debugger" t)

;; なぜか ruby-insert-end などがない
(defun ruby-insert-end ()
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))


(require 'ruby-electric)
(require 'ruby-block)

;; setting for rails
(require 'ido)
(ido-mode t)
(require 'rinari)

;; setting for nXHTML
(load "~/.emacs.d/lisp/nxhtml/autostart.el")
(setq nxhtml-global-minor-mode t
      mumamo-chunk-coloring 'submode-colored
      nxhtml-skip-welcom t
      rng-nxml-auto-validate-flag nil
      nxml-degraded t)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . eruby-nxhtml-mumamo))

;; setting for RSpec
(require 'compile)
(require 'rspec-mode)

;; autotest
(require 'autotest)

(add-hook 'ruby-mode-hook
          (lambda ()
            (ruby-electric-mode t)
            (ruby-block-mode t)
            (rspec-mode t)
            ))

;;
(require 'align)
(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes . '(ruby-mode))))

(setq rsense-home "/usr/local/lib/rsense")
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)

;; C-c . でメソッドなどを補完
(add-hook 'ruby-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'rsense-complete)))
(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-sourse-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
;;(setq rsense-rurema-home "~/rurema")

(provide 'init_ruby)
;;; init_ruby.el ends here