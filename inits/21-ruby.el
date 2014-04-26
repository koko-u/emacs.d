;;; 21-ruby.el --- ruby mode

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

;; basic setting
(autoload 'enh-ruby-mode "enh-ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

;; ruby electric
(require 'ruby-electric)
(add-hook 'enh-ruby-mode-hook
          '(lambda () (ruby-electric-mode t)))
(setq ruby-electric-expand-delimiters-list nil)

;; ruby block - highlight matching block
(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; smart compile
(require 'smart-compile)
(add-to-list 'smart-compile-alist '("\\.rb\\'" . "ruby %f"))
(add-hook 'enh-ruby-mode-hook
          '(lambda ()
             (define-key enh-ruby-mode-map (kbd "C-c c") 'smart-compile)
             (define-key enh-ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))))

;; code completion
;; M-x inf-ruby
;; M-x robe-start
(add-hook 'enh-ruby-mode
          '(lambda ()
             (robe-mode)
             (robe-ac-setup)
             (inf-ruby-keys)))

;; rspec-mode
(require 'rspec-mode)
(custom-set-variables
 '(rspec-use-rake-flag nil))

;; narrowing compilation window
(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h 10)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

(provide '21-ruby)
;;; 21-ruby.el ends here
