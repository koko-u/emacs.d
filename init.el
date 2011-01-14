;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;init.el -- Emacs init setting elisp file

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(setq user-full-name "kozaki.tsuneaki")
(setq user-mail-address "kozaki.tsuneaki@gmail.com")

;; 引数を load-path へ追加
;; normal-top-level-add-subdirs-to-load-path はディレクトリ中の中で
;; [A-Za-z] で開始する物だけ追加するので、追加したくない物は . や _ を先頭に付与しておけばロードしない
;; dolist は Emacs 21 から標準関数なので積極的に利用して良い
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; Emacs Lisp のPathを通す
(add-to-load-path "lisp"
                  ;; 変更したり、自作の Emacs Lisp
                  "local-lisp"
                  ;; auto-install で導入された Emacs Lisp
                  "auto-install"
                  ;; 初期設定ファイル
                  "site-start.d")

;; 文字コード
;;(set-language-environment 'Japanese)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; 全環境共通設定
(require 'init_global)

;; 環境変数
(require 'init_setenv)

;; フレームサイズ、色、フォントの設定
(require 'init_frame)

;; auto-install
(require 'init_auto-install)

;; shell, eshell 関連
(require 'init_shell)

;; Lisp
(require 'init_lisp)

;; キー設定
(require 'init_key)

;; anything
(require 'init_anything)

;; flymake
(require 'init_flymake)

;; diff
(require 'init_diff)

;; c
(require 'init_c)

;; yasnippet
(require 'init_yasnippet)

;; javascript
(require 'init_javascript)


;; 終了時バイトコンパイル
(add-hook 'kill-emacs-query-functions
          (lambda ()
            (if (file-newer-than-file-p (concat user-emacs-directory "init.el") (concat user-emacs-directory "init.elc"))
                (byte-compile-file (concat user-emacs-directory "init.el")))
            (byte-recompile-directory (concat user-emacs-directory "local-lisp") 0)
            (byte-recompile-directory (concat user-emacs-directory "site-start.d") 0)
            ))
