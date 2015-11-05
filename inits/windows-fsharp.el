;;; 21-fsharp.el ---                                 -*- lexical-binding: t; -*-

;; Copyright (C) 2015  kozaki.tsuneaki

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

;; README では inferior-fsharp-program, fsharp-compiler を setq するよ
;; うにガイドされているが、そのように設定しても動作しない. PATH を通す
;; と、fsi, fsc, msbuild を自動認識する.
(push "/c/Windows/Microsoft.NET/Framework64/v4.0.30319" exec-path)
(push "/c/Program Files (x86)/Microsoft SDKs/F#/3.1/Framework/v4.0" exec-path)

(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(require 'fsharp-mode)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)

;; fsharp-compile-command を "" で囲む. fsharp-compile-command は
;; fsharp-mode.el で初期化されるが "" で囲まれていないため、compile の
;; 実行に失敗する.
(and fsharp-compile-command
     (not (char-equal (aref fsharp-compile-command 0) ?\"))
     (setq fsharp-compile-command
           (concat "\"" fsharp-compile-command "\"")))

(add-hook 'fsharp-mode-hook
          (lambda ()
            (define-key fsharp-mode-map (kbd "M-RET") 'fsharp-eval-region)))


(provide '21-fsharp)
;;; 21-fsharp.el ends here
