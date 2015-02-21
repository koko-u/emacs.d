;;; 00-basic.el --- basic customization

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

; 削除ファイルをOSのごみ箱へ
;(setq delete-by-moving-to-trash t)

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

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; 垂直スクロール用のスクロールバーを付けない
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

;; 背景の透過
;; アクティブウィンドウ 92%, 非アクティブウィンドウ 40%
(add-to-list 'default-frame-alist '(alpha . (92 40)))

;; デフォルトのフレーム設定
(setq default-frame-alist
      (append (list
               '(width . 120)
               '(height . 36)
               '(top . 20)
               '(left . 40)
               )
              default-frame-alist))

;; マーク領域を色付け
(setq transient-mark-mode t)

;; 変更点に色付け
;(global-highlight-changes-mode t)
;(setq highlight-changes-visibility-initial-state t)
;(global-set-key (kbd "M-]") 'highlight-changes-next-change)
;(global-set-key (kbd "M-[")  'highlight-changes-previous-change)

;; 現在行に色を付ける
(global-hl-line-mode)
(hl-line-mode 1)

;; 列に色を付ける
;; @see http://www.emacswiki.org/emacs/CrosshairHighlighting
;; @see http://www.emacswiki.org/emacs/VlineMode
;; @see http://www.emacswiki.org/cgi-bin/wiki/vline.el
;;(require 'crosshairs)


;; face を調査するための関数
;; いろいろ知りたい場合は C-u C-x =
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; kill-ring 中の属性を削除
;; @see http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/junk_elisp.html
;; (defadvice kill-new (around my-kill-ring-disable-text-property activate)
;;   (let ((new (ad-get-arg 0)))
;;     (set-text-properties 0 (length new) nil new)
;;     ad-do-it))

(provide '00-basic)
;;; 00-basic.el ends here
