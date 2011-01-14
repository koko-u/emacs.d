;;; init_diff.el --- diff and ediff init file

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
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

;; diff および ediff の動作を設定

;;; Code:

;; diff モードは最初は read-only にする
(setq diff-default-read-only t)

;; ediff の操作用小ウィンドウを新規 frame にしない
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; 最初から縦分割  | で切り替え
(setq ediff-split-window-function 'split-window-horizontally)

;; m(ediff-toggle-wide-display) で最大化が可能

;; 終了時ウィンドウを復旧
(add-hook 'ediff-load-hook
          (lambda ()
            (add-hook 'ediff-before-setup-hook
                      (lambda ()
                        (setq ediff-saved-window-configuration (current-window-configuration))))
            (let ((restore-window-configuration
                   (lambda ()
                     (set-window-configuration ediff-saved-window-configuration))))
              (add-hook 'ediff-quit-hook restore-window-configuration 'append)
              (add-hook 'ediff-suspend-hook restore-window-configuration 'append))))


;; もし非常に大きな変更を頻繁に見る場合は以下のように設定。単位は byte
;; Emacs 23 では 初期値は 14,000byte あるので普通は設定しないで大丈夫
;; (setq-default ediff-auto-refine-limit 100000)


(provide 'init_diff)
;;; init_diff.el ends here