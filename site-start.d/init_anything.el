;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_anything.el --- anything.el setting

;; Copyright (C) 2009-2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: lisp

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
;;(require 'anything)
(require 'anything-config)
;;(require 'anything-private-config)
(require 'anything-match-plugin)

;; session を利用するため anything-c-adaptive-save-history を作成しない
(remove-hook 'kill-emacs-hook 'anything-c-adaptive-save-history)
(ad-disable-advice 'anything-exit-minibuffer 'before 'anything-c-adaptive-exit-minibuffer)
(ad-disable-advice 'anything-select-action 'before 'anything-c-adaptive-select-action)
(setq anything-c-adaptive-history-length 0)

;; アルファベットで候補選択
(setq anything-enable-shortcuts 'alphabet)

(and (equal current-language-environment "Japanese")
     (require 'anything-migemo nil t))

;; http://bitbucket.org/buzztaiki/elisp/src/tip/descbinds-anything.el
(require 'descbinds-anything)
(descbinds-anything-install)

(require 'anything-complete nil t)
;; 150 秒の待機が発生したらシンボルを更新
;; (anything-lisp-complete-symbol-set-timer 150)

;;(require 'anything-etags)
;; (setq tags-table-list '("~/.emacs.d/share/tags/TAGS" "TAGS"))
;; (require 'anything-yaetags)
;; (global-set-key (kbd "M-.") 'anything-yaetags-find-tag)

(anything-read-string-mode 1)

;; http://www.emacswiki.org/emacs/anything-show-completion.el
(require 'anything-show-completion)

(global-set-key (kbd "C-;") 'anything)
(setq anything-sources
      '(
        anything-c-source-ffap-line
        anything-c-source-ffap-guesser
        anything-c-source-buffers+
        anything-c-source-file-name-history
        anything-c-source-files-in-current-dir+
        anything-c-source-extended-command-history
        anything-c-source-emacs-commands
        anything-c-source-kill-ring
        anything-c-source-bookmarks
;;        anything-c-source-buffer-not-found
;;        anything-c-source-mac-spotlight
;;        anything-c-source-yaetags-select
;;        anything-c-source-etags-select
;;        anything-c-source-emacs-functions
        ))

(setq anything-for-files-prefered-list
      '(anything-c-source-ffap-line
        anything-c-source-ffap-guesser
        anything-c-source-buffers+
        anything-c-source-recentf
        anything-c-source-bookmarks
        anything-c-source-file-cache
        anything-c-source-files-in-current-dir+
        ))

;; C-x C-f の先頭を ffap 系にする
;; (setq anything-find-file-additional-sources-at-first
;;       '(
;;         anything-c-source-ffap-line
;;         anything-c-source-ffap-guesser
;;         ))
;; 追加のソース
;; (setq anything-find-file-additional-sources
;;       '(anything-c-source-locate))
;; (defadvice arfn-sources
;;   (after additional-arfn-sources-at-first activate)
;;   "Add additional sources at first."
;;   (setq ad-return-value
;;         (append anything-find-file-additional-sources-at-first
;;                 ad-return-value)))
;;(ad-deactivate 'arfn-sources)

;; (defun skt:anything-find-files ()
;;   "Preconfigured anything for `find-file'."
;;   (interactive)
;;   (let ((fap (ffap-guesser)))
;;     (if (and fap (file-exists-p fap)) 
;;         (anything 'anything-c-source-find-files (expand-file-name fap))))
;;   (anything (anything-c-source-find-files (expand-file-name default-directory))
;;             'anything-c-source-recentf
;;             )
;;   )

;; anything-find-files を上書き
(defun anything-find-files ()
  "Preconfigured `anything' for anything implementation of `find-file'."
  (interactive)
  (anything 'anything-c-source-find-files
            (anything-find-files-input (ffap-guesser) (thing-at-point 'filename))
            "Find Files or Url: " nil nil "*Anything Find Files*"))

(defun anything-find-files-input (fap tap)
  "Default input of `anything-find-files'."
  (let* ((file-p (and fap (file-exists-p fap)
                      (file-exists-p
                       (file-name-directory (expand-file-name tap)))))
         (input  (if file-p (expand-file-name fap) (expand-file-name tap))))
    (or input (expand-file-name default-directory))))

;; anything 本体では anything-quit-and-find-file 
(global-set-key (kbd "C-x C-f") 'anything-find-files)


;; 検索の対象を変更した物を作成
(defun anything-help-at-point ()
  "Preconfigured `anything' for searching help at point."
  (interactive)
  (anything
   (cond
    ((eq major-mode 'python-mode)
     '(anything-c-source-info-python-module
       anything-c-source-info-python-class
       anything-c-source-info-python-function
       anything-c-source-info-python-misc
       ))
    ;;((eq major-mode 'emacs-lisp-mode)
    (t
     '(anything-c-source-info-elisp
       anything-c-source-info-cl
;;       anything-c-source-man-pages
       anything-c-source-info-pages
       ;; anything-c-source-emacs-commands
       ;; anything-c-source-emacs-functions
       ))
    )
   (thing-at-point 'symbol) nil nil nil "*anything help*"))

(global-set-key (kbd "C-c i") 'anything-help-at-point)

;; 最近のファイル等を anything する
;; see http://www.emacswiki.org/cgi-bin/wiki/download/recentf-ext.el
;; 自動クリーニングを停止 recentf-cleanup
(setq recentf-auto-cleanup 'never)
;; anything で便利なので履歴の保存量を多少多めにしておく
(setq recentf-max-saved-items 1000)

;; 保存ファイルのの設定に リモートファイル tramp の先等を追加。これを実施すると起動時にパスワード等の確認はされない
(require 'recentf)
(add-to-list 'recentf-keep 'file-remote-p)
(add-to-list 'recentf-keep 'file-readable-p)
;; 除外ファイル
(setq recentf-exclude
      '("\\.elc$"
        "\\.pyc$"
        ".recentf$"
        ".howm-keys$"
        "^/var/folders/"
        "^/tmp/"))
(add-hook 'kill-emacs-query-functions 'recentf-cleanup)
;; recentf ファイルの保存場所を指定。デフォルトはホームの直下
;; (setq recentf-save-file "~/.emacs.d/var/recentf")

;; C-x C-b のバッファリストをanythingする
(require 'recentf-ext)
(global-set-key (kbd "C-x C-b") 'anything-for-files)
;; current-buffer も末尾に表示する
(setq anything-allow-skipping-current-buffer nil)

;; M-yでkill-ringの内容をanythingする
(global-set-key (kbd "M-y") 'anything-show-kill-ring)

;; anything した時のウィンドウを常に下部に開く。高さは比率にて自動算出
;; anything の最新では標準機能に縦横の切り替えを C-t でする機能が存在している
;; split-root http://nschum.de/src/emacs/split-root/
(require 'split-root)
;; 比率
(defvar anything-compilation-window-height-percent 30.0)
(defun anything-compilation-window-root (buf)
  (setq anything-compilation-window
        (split-root-window (truncate (* (frame-height)
                                        (/ anything-compilation-window-height-percent
                                           100.0)))))
  (set-window-buffer anything-compilation-window buf))
(setq anything-display-function 'anything-compilation-window-root)


;;; anything-c-moccurの設定
;; see http://d.hatena.ne.jp/IMAKADO/20080724/1216882563
(require 'anything-c-moccur)
(setq
 ;;`anything-idle-delay'
 anything-c-moccur-anything-idle-delay 0.2
 ;; `anything-c-moccur-dmoccur'などのコマンドでバッファの情報をハイライトする
 anything-c-moccur-higligt-info-line-flag t
 ;; 現在選択中の候補の位置を他のwindowに表示する
 anything-c-moccur-enable-auto-look-flag t
 ;; `anything-c-moccur-occur-by-moccur'の起動時にポイントの位置の単語を初期パターンにする
 anything-c-moccur-enable-initial-pattern t)

;; バッファ内検索
(global-set-key (kbd "M-o") 'anything-c-moccur-occur-by-moccur)
;;ディレクトリ
;(global-set-key (kbd "C-M-o") 'anything-c-moccur-dmoccur)
;; grep
(require 'anything-grep)
;;(global-set-key (kbd "C-M-o") 'moccur-grep)
;;(global-set-key (kbd "C-M-o") 'anything-grep)
(global-set-key (kbd "C-M-o") 'moccur-grep-find)
;; dired
(add-hook 'dired-mode-hook
          '(lambda ()
             (local-set-key (kbd "O") 'anything-c-moccur-dired-do-moccur-by-moccur)))

;; anything-grep-by-name
(setq anything-grep-alist
      '(
        ;; howm-directory 以下から再帰的にegrepをかける。不要なファイルは除かれる。
        ("howm" ("ack-grep -af | xargs egrep -Hin %s" "~/howm"))
        ;; *.el に対してegrepをかける。
        ("dotemacs" ("egrep -Hin %s *.el" "~/.emacs.d/site-lisp"))
        ;; 全バッファのファイル名においてegrepをかける。moccurの代わり。
        ("buffers" ("egrep -Hin %s $buffers" "/"))
        ))
;; (anything-grep-by-name nil "howm")

;; キー設定 現在以下は設定すみなのでする必要はない
;;(define-key anything-map (kbd "C-p") 'anything-previous-line)
;;(define-key anything-map (kbd "C-n") 'anything-next-line)
;;(define-key anything-map (kbd "M-n") 'anything-next-source)
;;(define-key anything-map (kbd "M-p") 'anything-previous-source)
;;(define-key anything-map (kbd "C-v") 'anything-next-page)
;;(define-key anything-map (kbd "M-v") 'anything-previous-page)

(provide 'init_anything)
;;; init_anything.el ends here