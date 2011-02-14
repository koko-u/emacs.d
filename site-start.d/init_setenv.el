;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_setenv.el --- Unix Env Setting

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary: 環境変数関連の設定

;; 

;;; Code:

;; PATH設定
;; Mac OS X の bash の PATH は /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:
;; 多数の実行環境にて極力汎用的にパスが設定されるようしたい
(dolist (dir (list
               "/sbin"
               "/usr/sbin"
               "/bin"
               "/usr/bin"
               "/usr/local/bin"
               (expand-file-name "~/bin")
               (expand-file-name "~/local/bin")
               (expand-file-name "~/.emacs.d/bin")
               ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man" (getenv "MANPATH")))

(setenv "JAVA_OPTS" "-Dfile.encoding=UTF-8")

(setenv "CVS_RSH" "ssh")
(setenv "SSH_AUTH_SOCK" (getenv "SSH_AUTH_SOCK"))
(setenv "LC_ALL" "ja_JP.UTF-8")

(provide 'init_setenv)
;;; init_setenv.el ends here