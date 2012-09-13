;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_global.el --- global

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
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

;; 利用する環境共通の設定

;;; Code:

;;; 初期位置
(cd "~/")

;; ログの長さを無限に
;;(setq message-log-max 't)
;; ログを出さない
;; (setq message-log-max nil)

;;; menubar
;(menu-bar-mode nil)
;;; toolbar
(tool-bar-mode 0)

;; 警告を視覚的にする
(setq visible-bell t)

;; ファイルを編集した場合コピーにてバックアップする
;; inode 番号を変更しない
(setq backup-by-copying t)
;;; バックアップファイルの保存位置指定[2002/03/02]
;; !path!to!file-name~ で保存される
(setq backup-directory-alist
      '(
        ("^/etc/" . "~/.emacs.d/var/etc")
        ("." . "~/.emacs.d/var/emacs")
        ))

;;起動時のmessageを表示しない
(setq inhibit-startup-message t)
;; scratch のメッセージを空にする
(setq initial-scratch-message nil)

; 自動改行関連
(setq-default auto-fill-mode nil)
(setq-default fill-column 80)
(setq text-mode-hook 'turn-off-auto-fill)

; 削除ファイルをOSのごみ箱へ
;(setq delete-by-moving-to-trash t)

;;; help key変更
;; BackSpaceをC-hに変更
;(load-library "obsolete/keyswap")
(global-set-key "\M-?" 'help-for-help)
;; keyswap は obsoleteなので以下の設定が良い
(global-set-key "\C-h" 'backward-delete-char)

;; 編集関連

;; モードラインにライン数、カラム数表示
(line-number-mode t)
(column-number-mode t)
;(global-linum-mode t)
;(set-face-attribute 'linum nil
;                    :foreground "#8e4513"
;                    :height 1.0)
;(setq linum-format "%4d")

;; リージョンを kill-ring に入れないで削除できるようにする
(delete-selection-mode t)

;; TAB はスペース 2 個ぶんを基本
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(add-hook 'css-mode-hook
          '(lambda ()
             (setq css-indent-offset 2)))

;; 対応するカッコを色表示する
;; 特に色をつけなくてもC-M-p、C-M-n を利用すれば対応するカッコ等に移動できる
(show-paren-mode t)
(set-face-background 'show-paren-match-face "#f08080")
;; カッコ対応表示のスタイル
;; カッコその物に色が付く(デフォルト)
;; (setq show-paren-style 'parenthesis)
;; カッコ内に色が付く
;; (setq show-paren-style 'expression)
;; 画面内に収まる場合はカッコのみ、画面外に存在する場合はカッコ内全体に色が付く
;; (setq show-paren-style 'mixed)

;;動的略語展開で大文字小文字を区別
(setq dabbrev-case-fold-search nil)

;;新規行を作成しない
;;emacs21ではデフォルトで設定されています。
(setq next-line-add-newlines nil)

;; スクロールのマージン
;; 指定した数字行だけスクロール
(setq scroll-conservatively 10000)
;; scroll-conservatively の古いバージョン。一行ずつスクロールする
(setq scroll-step 1)
;; 上端、下端における余白幅(初期設定 0)
;; (setq scroll-margin 10)
;; カーソル位置を変更しない
(setq scroll-preserve-screen-position t)
;; shell-mode において最後の行ができるだけウィンドウの一番下にくるようにする
(setq comint-scroll-show-maximum-output t)
;; C-v や M-v した時に以前の画面にあった文字を何行分残すか(初期設定 2)
;;(setq next-screen-context-lines 5)

;; 終了時に聞く
(setq confirm-kill-emacs 'y-or-n-p)

;; Chrome がインストールされていれば、それをデフォルトブラウザに設定
;(if (locate-library "chromium-browser" nil exec-path)
;    (setq browse-url-browser-function 'browse-url-generic
;          browse-url-generic-program "chromium-browser")
;  (setq browse-url-browser-function 'browse-url-firefox))
(setq browse-url-browser-function 'browse-url-firefox)

;; .el ファイルを保存した時に自動的にバイトコンパイルする
(require 'auto-async-byte-compile)
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; 時刻を表示
(display-time)

;; ダイアログボックスを表示しない
(setq use-dialog-box nil)
(defalias 'message-box 'message)

;; キーストロークをエコーエリアに素早く表示
(setq echo-keystrokes 0.1)

;; 大きなファイルを開く時の警告を 25M 程度とする
(setq large-file-warning-threshold (* 25 1024 1024))

;; yes を入力するのが面倒
(defalias 'yes-or-no-p 'y-or-n-p)

;; 余分な行末の空白を削除する
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; ファイル名が #! で初まるファイルには実行権限を付ける
(add-hook 'after-save-hook
          '(lambda ()
             (save-restriction
               (widen)
               (if (string= "#!" (buffer-substring 1 (min 3 (point-max))))
                   (let ((name (buffer-file-name)))
                     (or (char-equal ?. (string-to-char (file-name-nondirectory name)))
                         (let ((mode (file-modes name)))
                           (set-file-modes name (logior mode (logand (/ mode 4) 73)))
                           (message (concat "Wrote " name " (+x)"))))
                     )))))

;; カーソル位置のシンボルをハイライト
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

;; color-moccur
(require 'color-moccur)
(load "moccur-edit")

;; 安全な実行のための共通系関数

;; @see http://www.sodan.org/~knagano/emacs/dotemacs.html
(defmacro eval-safe (&rest body)
  "安全な評価。評価に失敗してもそこで止まらない。"
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))
(defun load-safe (loadlib)
  "安全な load。読み込みに失敗してもそこで止まらない。"
  ;; missing-ok で読んでみて、ダメならこっそり message でも出しておく
  (let ((load-status (load loadlib t)))
    (or load-status
        (message (format "[load-safe] failed %s" loadlib)))
    load-status))
(defun autoload-if-found (functions file &optional docstring interactive type)
  "set autoload iff. FILE has found."
  (if (not (listp functions))
      (setq functions (list functions)))
  (and (locate-library file)
       (progn
         (dolist (function functions)
           (autoload function file docstring interactive type))
         t )))

(provide 'init_global)
;;; init_global.el ends here