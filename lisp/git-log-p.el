;;; git-log-p.el ---

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

(require 'cl)

(defmacro* with-temp-directory (dir &body body)
  `(with-temp-buffer
     (cd ,dir)
     ,@body))

(defmacro aif (test-form then-form &optional else-form)
  `(let ((it ,test-form))
     (if it ,then-form ,else-form)))

(defmacro* awhen (test-form &body body)
  `(aif ,test-form
        (progn ,@body)))

(defun find-file-upward (file-name &optional dir)
  (interactive)
  (let ((default-directory (file-name-as-directory (or dir default-directory))))
    (if (file-exists-p file-name)
        (expand-file-name file-name)
      (unless (string= "/" (directory-file-name default-directory))
        (find-file-upward file-name (expand-file-name ".." default-directory))))))

(defun git-repo-p ()
  (when (find-file-upward ".git") t))

(defun git-log-p-this-file ()
  (interactive)
  (unless (git-repo-p) (error "git 管理下にありません"))
  (let ((dir (concat (find-file-upward ".git") "/../"))
        (buf "*git-log-p-this-file*"))
        (with-temp-directory dir
           (awhen (get-buffer buf)
              (with-current-buffer it (erase-buffer)))
           (get-buffer "*git-log-p-this-filf*")
           (call-process-shell-command (concat "git log -p -- " buffer-file-name) nil buf t)
           (switch-to-buffer buf)
           (diff-mode)
           (goto-char (point-min)))))

(defalias 'log 'git-log-p-this-file)

(provide 'git-log-p)
;;; git-log-p.el ends here
