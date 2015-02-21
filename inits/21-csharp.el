;;; 21-csharp.el --- c# mode

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

;(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(add-hook 'csharp-mode-hook
          '(lambda ()
             (setq comment-column 40
                   c-basic-offset 4)
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'case-label '+)
             (c-set-offset 'innamespace '+)
             (c-set-offset 'inline-open 0)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close 0)

             (auto-complete-mode)
             )
          )

;; flycheck for c#
(defun csharp-set-flycheck-command ()
  "Set the flycheck command, dynamically, as a side effect.

This function is intended for use as a before-syntax-check-hook with
flycheck.  Use it like this:

    (add-hook 'flycheck-before-syntax-check-hook  #'csharp-set-flycheck-command)

Then, in your csharp file, specify this in the comments at the header.

    // flycheck: gmcs -t:module /debug+ -pkg:dotnet %f

This will cause flycheck to run the given command, replacing the %f with
the source file name."

  (and (eq major-mode 'csharp-mode)
       (let ((cmd-string
              (csharp-get-value-from-comments "flycheck" csharp-cmd-line-limit)))
         (and cmd-string
              (not (eq cmd-string ""))
              (let* ((cmd (split-string cmd-string " "))
                     (ferf (member "%f" cmd)))
                (and ferf (setcar ferf 'source))
                (put 'csharp :flycheck-command cmd))))))


(eval-after-load "flycheck"
  '(progn
     (flycheck-define-checker csharp
       "A C# syntax checker for dotnet. By default, it uses the Mono
compiler. If you would like to use a different compiler, see
`csharp-set-flycheck-command'."
       :command ("mcs" "-target:module" source)
       :error-patterns
       ;; WinFormsHello.cs(17,9): error CS0246: The type or namespace name `derp' could not be found. Are you missing an assembly reference?
       ((error line-start (file-name) "(" line "," column "): error " (message) line-end)
        (warning line-start (file-name) "(" line "," column "): warning " (message) line-end))
       :modes csharp-mode)
     (add-hook 'flycheck-before-syntax-check-hook  #'csharp-set-flycheck-command)))


(provide '21-csharp)
;;; 21-csharp.el ends here
