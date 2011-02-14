;;; -*- mode: emacs-lisp; coding: utf-8; indent-tabs-mode: nil -*-

;;; init_shell.el --- shell

;; Copyright (C) 2010  sakito

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

;; shell 関連

;;; Code:

;;:eshell
;; glob で .* が .. に一致しないようにする
(setq eshell-glob-include-dot-dot nil)

;;; Shellの設定
;; M-x anshi-term、term

;; 極力どの環境でも極力動作するように判定
(defun skt:shell ()
  (or (executable-find "zsh")
      (executable-find "bash")
      (executable-find "cmdproxy")
      (error "can't find 'shell' command in PATH!!")))

(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; TODO
;;(setq explicit-bash-args '("-login" "-i"))
;;(setq shell-command-switch "-c")
;;(setq win32-quote-process-args t)

;; system の terminfo を利用する
(setq system-uses-terminfo t)

;; @see http://www.emacswiki.org/emacs/MultiTerm
(require 'multi-term)
(add-hook 'term-mode-hook
          '(lambda ()
             ;; 実行する shell の設定
             (setq multi-term-program shell-file-name)
             ;; default-directory が存在しなかった場合に開くディレクトリ
             (setq multi-term-default-dir "~/.emacs.d")
             ;; 一部キーが取られるので無視設定
             ;; デフォルトは '("C-z" "C-x" "C-c" "C-h" "C-y" "<ESC>")
             (add-to-list 'term-unbind-key-list '"M-x")
             ;; Emacs の標準的キー割り当てにする
             (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
             (define-key term-raw-map (kbd "C-y") 'term-paste)
             ))

;; shell-mode でエスケープを綺麗に表示
(autoload 'ansi-color-for-comint-mode-on "ansi-color"
  "Set `ansi-color-for-comint-mode' to t." t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; キー
(global-set-key (kbd "C-c t") '(lambda ()
                                 (interactive)
                                 (if (get-buffer "*terminal<1>*")
                                     (switch-to-buffer "*terminal<1>*")
                                 (multi-term))))

;; shell-pop の設定
;; @see http://www.emacswiki.org/emacs-en/ShellPop
(require 'shell-pop)
;; multi-term に対応
(add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal<1>*" '(lambda () (multi-term))))
(shell-pop-set-internal-mode "multi-term")
;; frame の高さからサイズを決定
(defvar shell-pop-window-height-percent 50.0)
(shell-pop-set-window-height (truncate (* (frame-height)
                                          (/ shell-pop-window-height-percent
                                             100.0))))
(shell-pop-set-internal-mode-shell shell-file-name)
(global-set-key [f8] 'shell-pop)

(provide 'init_shell)
;;; init_shell.el ends here