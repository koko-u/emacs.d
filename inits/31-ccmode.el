;;; 31-ccmode.el --- cc-mode

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

;; スタイル設定
;; スタイルの変え方 : http://d.hatena.ne.jp/i_s/20091026/1256557730
;; 単純に言うと、C-c C-s でインデントの方式を知って、C-c C-o で試してみてよさげ
;; なら (c-set-offset ... )に書く
(add-hook 'c-mode-common-hook
          '(lambda ()
             ; styleには GNU,cc-mode,ktr,bsd,stroustrup,whitesmith,ellemtel,linux等がある
             (c-set-style "stroustrup")
             ; 基本オフセット
             (setq c-basic-offset 4)
             ; コメント行のオフセット
             ;(c-comment-only-line-of . 0)
             ; 全自動インデントを有効
             ;(c-toggle-auto-newline t)
             ; TABキーでインデント
             (setq c-tab-always-indent t)
             ; namespace {}の中はインデントしない
             (c-set-offset 'innamespace 0)
             ; クラス内のインライン関数の開き括弧
             (c-set-offset 'inline-open 0)
             ; 連続するスペースをバックスペース一回で削除する
             (c-toggle-hungry-state t)
             ; センテンスの終了である ; を入力したら自動的に改行してインデント
             ;(c-toggle-auto-hungry-state t)
             ;; 対応する括弧の挿入 しばらく smartchr を利用してみる
             ;; (make-variable-buffer-local 'skeleton-pair)
             ;; (make-variable-buffer-local 'skeleton-pair-on-word)
             ;; (setq skeleton-pair-on-word t)
             ;; (setq skeleton-pair t)
             ;; (make-variable-buffer-local 'skeleton-pair-alist)
             ;; (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
             ))

;; コンパイルセッセージの縦幅
(setq compilation-window-height 8)

;; Makefile用の設定
(add-hook 'makefile-mode-hook
          (function (lambda ()
                      (whitespace-mode t)
                      ;; suspicious-lines を無視しておく
                      (fset 'makefile-warn-suspicious-lines 'ignore)
                      (setq indent-tabs-mode t))))

;; コードを貼り付けた時に自動的にインデントする
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    enh-ruby-mode
                                                     rspec-mode      python-mode
                                                     c-mode          c++-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))

(provide '31-ccmode)
;;; 31-ccmode.el ends here
