;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_yasnippet.el --- yasnippet

;; Copyright (C) 2009  sakito

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

;; @see http://code.google.com/p/yasnippet/

;; 

;;; Code:
(require 'yasnippet)

;; snippet のディレクトリを設定
(setq yas/root-directory '("~/.emacs.d/etc/snippets"
                           "/usr/share/emacs/site-lisp/yasnippet/snippets"))
;; 複数ディレクトリの場合は以下のようにする
;; (setq yas/root-directory '("~/.emacs.d/lisp/yasnippet-0.6.1c/snippets"
;;                            "~/.emacs.d/etc/snippets"))

;; メニューは使わない
(setq yas/use-menu nil)

;; トリガはSPC, 次の候補への移動はTAB
(setq yas/trigger-key nil)
;; (setq yas/trigger-key (kbd "SPC"))
;; (setq yas/next-field-key (kbd "TAB"))

;; http://svn.coderepos.org/share/lang/elisp/anything-c-yasnippet/anything-c-yasnippet.el
;(require 'anything-c-yasnippet)
;(setq anything-c-yas-space-match-any-greedy t)
;(global-set-key (kbd "C-c y") 'anything-c-yas-complete)

;; 初期化
(yas/initialize)
;; ファイルが増加すると起動に時間がかかるようになる
;;(yas/load-directory yas/root-directory)
;; 複数ディレクトリの場合
(mapc 'yas/load-directory yas/root-directory)

;; prompting-mode の設定
(setq yas/prompt-functions '(yas/ido-prompt yas/dropdown-prompt yas/completing-prompt))
 

(provide 'init_yasnippet)
;;; init_yasnippet.el ends here