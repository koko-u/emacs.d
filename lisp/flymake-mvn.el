;;; flymake-mvn.el ---

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

(require 'java-mode-indent-annotations)

(defun flymake-java-mvn-init ()
  "Return external compile process to run"
    (list "flymake-maven" (list buffer-file-name)))

(defun flymake-java-mvn-load ()
  "Setup keys and flymake error patterns"
  (push '(".+\\.java$" flymake-java-mvn-init) flymake-allowed-file-name-masks)
  (push '("^\\([^: \n]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)] \\(.+\n?[^/]*?\n?[^/]*?\\)" 1 2 3 4) flymake-err-line-patterns)
  (push '("^warning \\([^: \n]+\\):\\[\\([0-9]+\\),\\([0-9]+\\)] \\(.+\\)" 1 2 3 4) flymake-err-line-patterns)
  (flymake-mode t)
  (local-set-key (kbd "C-c e") 'flymake-display-err-menu-for-current-line)
  (local-set-key (kbd "C-c n") 'flymake-goto-next-error)
  (local-set-key (kbd "C-c p") 'flymake-goto-prev-error)
  (local-set-key (kbd "C-c s") 'flymake-start-syntax-check)
  (local-set-key (kbd "C-c S") 'flymake-stop-all-syntax-checks)
  (local-set-key (kbd "C-c C-t") 'ed/java-mvn-run-unit-test)
  (local-set-key (kbd "C-c d") 'ed/java-mvn-debug-unit-test)
  (local-set-key (kbd "C-c C-i") 'ed/java-indent-properties)
  (local-set-key (kbd "C-c C-/") 'semantic-complete-analyze-and-replace)
  (local-set-key (kbd "C-c C-m") 'tempo-snippets-clear-all))

(defun flymake-java-mvn-mode-hook ()
  "Initialise the java environment"
  (java-mode-indent-annotations-setup)
  (c-subword-mode 1)
  (flymake-java-mvn-load)
  (flyspell-prog-mode)
  (setq indent-tabs-mode nil)
  (setq local-abbrev-table java-mode-abbrev-table)
  (abbrev-mode 1))

(provide 'flymake-mvn)
;;; flymake-mvn.el ends here
