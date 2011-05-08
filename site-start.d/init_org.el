;;; init_org.el --- org-mode の各種設定

;; Copyright (C) 2011  kozaki.tsuneaki

;; Author: kozaki.tsuneaki <kozaki.tsuneaki@gmail.com>
;; Keywords: tools

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

(require 'org)
(defun org-insert-upheading (arg)
  "1レベル上の見出しを入力する"
  (interactive "P")
  (org-insert-heading arg)
  (cond ((org-on-heading-p) (org-do-promote))
        ((org-at-item-p) (org-indent-item -1))))
(defun org-insert-heading-dwim (arg)
  "現在と同じレベルの見出しを入力する
C-u を付けると 1レベル上、C-uC-u を付けると 1レベル下の見出しを入力する"
  (interactive "p")
  (case arg
    (4 (org-insert-subheading nil)) ; C-u
    (16 (org-insert-upheading nil)) ; C-uC-u
    (t (org-insert-heading nil))))

(define-key org-mode-map (kbd "<C-return>") 'org-insert-heading-dwim)

;; 瞬時にメモを取る
(org-remember-insinuate)
; メモを取る org ファイルの設定
(setq org-directory (expand-file-name "~/memo/")
      org-default-notes-file (expand-file-name "memo.org" org-directory))
; テンプレートの設定
(setq org-remember-templates
      '(("Note" ?n "** %?\n    %i\n    %a\n    %t" nil "Inbox")
        ("Todo" ?t "** TODO %?\n    %i\n    %a\n    %t" nil "Inbox")))

;; 画像をインライン表示する
(add-hook 'org-mode-hook 'turn-on-iimage-mode)

(provide 'init_org)
;;; init_org.el ends here
