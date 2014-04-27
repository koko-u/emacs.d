;;; 21-yasnippet.el --- yasnippet

;; Copyright (C) 2014  kozaki.tsuneaki

;; Author: kozaki.tsuneaki <kozaki.tsuneaki@gmail.com>
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

;;

;;; Code:

(eval-after-load "yasnippet"
  '(progn
     ;; snippet のディレクトリを設定
     (setq yas-snippet-dirs '("~/.emacs.d/elpa/yasnippet-20140314.255/snippets"
                              "~/.emacs.d/etc/snippets"))

     ;; 常に利用する
     (yas-global-mode 1)

     ;; メニューは使わない
     (setq yas-use-menu nil)

     ;; ファイルが増加すると起動に時間がかかるようになる
     ;;(yas/load-directory yas/root-directory)
     ;; 複数ディレクトリの場合
     (mapc 'yas-load-directory yas-snippet-dirs)

     ;; prompting-mode の設定
     (setq yas-prompt-functions
           '(yas-completing-prompt yas-dropdown-prompt))))

(provide '21-yasnippet)
;;; 21-yasnippet.el ends here
