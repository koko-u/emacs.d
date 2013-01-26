;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_c.el --- C and C++ setting

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords:

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;;

;;; Code:

;; スタイル設定
(add-hook 'c-mode-common-hook
          '(lambda()
             ; styleには GNU,cc-mode,ktr,bsd,stroustrup,whitesmith
             ; ,ellemtel,linux等がある
             ;(c-set-style "ellemtel")
             (c-set-style "cc-mode")
             ; 基本オフセット
             (setq c-basic-offset 4)
             ; コメント行のオフセット
             ;(c-comment-only-line-of . 0)
             ; 全自動インデントを有効
             ;(setq c-auto-newline t)
             ; TABキーでインデント
             ;(c-tab-always-indent t)
             ; namespace {}の中はインデントしない
             (c-set-offset 'innamespace 0)
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

;; ffapの設定
;(ffap-bindings)   ; これを設定すると ido-mode が死ぬので止める
(defvar flap-alist
  '(
    ("\\.info\\" . ffap-info)     ; gzip info
    ("\\`info/"  . ffap-info-2)    ; info/emacs
    ("\\`[-a-z]+\\'" . ffap-info-3) ; (emacs) Top
    ("\\.elc?\\'" . ffap-el)        ; simple.el simple.elc
    (emacs-lisp-mode . ffap-el-mode)
    (finder-mode . ffap-el-mode)
    (help-mode . ffap-el-mode)
    (c++-mode . ffap-c-mode)
    (cc-mode . ffap-c-mode)
    ("\\.\\([chCH]\\|cc\\|hh\\)\\'" . ffap-c-mode)
    (tex-mode . ffap-tex-mode)
    (latex-mode . ffap-latex-mode)
    ("\\.\\(tex\\|sty\\|doc\\|cls\\)\\'" . ffap-tex)
    ("\\`\\." . ffap-home)
    (dired-mode . ffap-dired)
    ))
(setq ffap-c-path
      '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認する
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

;; etags
;; etags *.[ch] , etags `find . -name \*.[ch],  M - . , M - *
;; gtags
;; @see http://d.hatena.ne.jp/higepon/20060107/1136628498

;; 定型文の挿入


;; デバッグ文の挿入 yasnippet で同様の事が可能なので不要
; @see http://d.hatena.ne.jp/higepon/20060212/1139757670
;; (defun my-insert-printf-debug ()
;;   (interactive)
;;   (insert "printf(\"%s %s:%d\\n\", __func__, __FILE__, __LINE__);")
;;   (indent-according-to-mode))

;; (add-hook 'c++-mode-hook
;;           (function (lambda ()
;;                       (define-key c++-mode-map (kbd "C-c p") 'my-insert-printf-debug))))

;; コンパイルセッセージの縦幅
(setq compilation-window-height 8)

;; Makefile用の設定
(add-hook 'makefile-mode-hook
          (function (lambda ()
                      (whitespace-mode t)
                      ;; suspicious-lines を無視しておく
                      (fset 'makefile-warn-suspicious-lines 'ignore)
                      (setq indent-tabs-mode t))))

(provide 'init_c)
;;; init_c.el ends here