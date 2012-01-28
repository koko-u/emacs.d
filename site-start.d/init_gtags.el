;;; init_gtags.el --- setting for GNU Global

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
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)    ;; 関数の定義元へ移動
         (local-set-key "\M-r" 'gtags-find-rtag)   ;; 関数の参照元の一覧を表示
         (local-set-key "\M-s" 'gtags-find-symbol) ;; 変数の定義元と参照元の一覧を表
         (local-set-key "\C-t" 'gtags-pop-stack)   ;; 前のバッファへ戻る
         ))
;; c-modeで自動的にgtags-modeに切り替える
(add-hook 'c-mode-common-hook
          '(lambda ()
             (gtags-mode 1)
             ))
;; java-modeで自動的にgtags-modeに切り替える
(add-hook 'java-mode-hook
          '(lambda ()
             (gtags-mode 1)
             ))

;; 勝手に gtags を再作成する
(defun auto-compile-update-gtags ()
  "Update GTAGS file"
  (let ((status (call-process "global" nil nil nil "-uv")))
    (if (= status 0)
        (message "[auto-compile]:GTAGS updated"))))


(provide 'init_gtags)
;;; init_gtags.el ends here
