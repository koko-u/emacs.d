;;; 21-magit.el --- git

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

;; ;; コミットメッセージを書いて C-c C-c した時のWindows構成の不安定さを軽減
;; (defadvice magit-status (around magit-fullscreen activate)
;;   (window-configuration-to-register :magit-fullscreen)
;;   ad-do-it
;;   (delete-other-windows))

;; (defun my/magit-quit-session ()
;;   (interactive)
;;   (kill-buffer)
;;   (jump-to-register :magit-fullscreen))

;;(define-key magit-status-mode-map (kbd "q") 'my/magit-quit-session)

;; (defadvice git-commit-commit (after move-to-magit-buffer activate)
;;   (delete-window))

;; ;; 72 文字折り返しをオミット
;; (add-hook 'git-commit-mode-hook (setq auto-fill-mode nil))

(global-set-key (kbd "C-c g") 'magit-status)

(setq magit-display-buffer-function
      'magit-display-buffer-same-window-except-diff-v1)

(provide '21-magit)
;;; 21-magit.el ends here
