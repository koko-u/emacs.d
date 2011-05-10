;;; init_sdic.el --- 辞書引きモード

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

;; 参考にしたサイト :
;; http://www.dokoka.org/wiki.cgi?page=%C6%FC%B5%AD%2F2011-4-23
;; Ubuntu に sdic-eijirou というパッケージがあるけど、インストールできなかった
;; sdic 自体は普通に apt-get でインストールできた

;;; Code:

(autoload 'sdic-describe-word "sdic" "search word" t nil)
(global-set-key "\C-cW" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic" "カーソル位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word-at-point)

; 検索結果のウィンドウの高さ
(setq sdic-window-height 10)

; 検索結果のフェイス
(setq sdic-face-style 'bold
      sdic-face-color "firebrick4")


;; ----- sdicが呼ばれたときの設定
(eval-after-load "sdic"
  '(progn
     ;; saryのコマンドをセットする
     (setq sdicf-array-command
           (replace-regexp-in-string "\n$" "" (shell-command-to-string "which sary") ))
     ;; sdicファイルのある位置を設定し、arrayコマンドを使用するよう設定(現在のところ英和のみ)
     (setq sdic-eiwa-dictionary-list
           '((sdicf-client "/usr/share/dict/eijirou.sdic"
                           (strategy array)))
           sdic-waei-dictionary-list
           '((sdicf-client "/usr/share/dict/waeijirou.sdic"
                           (strategy array))))
     ;; saryを直接使用できるように sdicf.el 内に定義されているarrayコマンド用関数を強制的に置換
     (fset 'sdicf-array-init 'sdicf-common-init)
     (fset 'sdicf-array-quit 'sdicf-common-quit)
     (fset 'sdicf-array-search
           (lambda (sdic pattern &optional case regexp)
             (sdicf-array-init sdic)
             (if regexp
                 (signal 'sdicf-invalid-method '(regexp))
               (save-excursion
                 (set-buffer (sdicf-get-buffer sdic))
                 (delete-region (point-min) (point-max))
                 (apply 'sdicf-call-process
                        sdicf-array-command
                        (sdicf-get-coding-system sdic)
                        nil t nil
                        (if case
                            (list "-i" pattern (sdicf-get-filename sdic))
                          (list pattern (sdicf-get-filename sdic))))
                 (goto-char (point-min))
                 (let (entries)
                   (while (not (eobp)) (sdicf-search-internal))
                   (nreverse entries))))))
     ;; おまけ--辞書バッファ内で移動した時、常にバッファの一行目になるようにする
     (defadvice sdic-forward-item (after sdic-forward-item-always-top activate)
       (recenter 0))
     (defadvice sdic-backward-item (after sdic-backward-item-always-top activate)
       (recenter 0))))

(setq sdic-default-coding-system 'utf-8-unix)

; 検索結果表示バッファで引いた単語をハイライト表示する
(defadvice sdic-search-eiwa-dictionary (after highlight-phrase (arg))
  (highlight-phrase arg "hi-yellow"))
(defadvice sdic-search-waei-dictionary (after highlight-phrase (arg))
  (highlight-phrase arg "hi-yellow"))

(ad-activate 'sdic-search-eiwa-dictionary)
(ad-activate 'sdic-search-waei-dictionary)

(provide 'init_sdic)
;;; init_sdic.el ends here
