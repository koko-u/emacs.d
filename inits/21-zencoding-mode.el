;;; 21-zencoding-mode.el --- zencoding

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

(when (require 'zencoding-mode nil t)
  (setq zencoding-block-tags
        (append (list
                 "article"
                 "section"
                 "aside"
                 "nav"
                 "figure"
                 "address"
                 "header"
                 "footer")
                zencoding-block-tags))
  (setq zencoding-inline-tags
        (append (list
                 "textarea"
                 "small"
                 "time" "del" "ins"
                 "sub"
                 "sup"
                 "i" "s" "b"
                 "ruby" "rt" "rp"
                 "bdo"
                 "iframe" "canvas"
                 "audio" "video"
                 "ovject" "embed"
                 "map"
                 )
                zencoding-inline-tags))
  (setq zencoding-self-closing-tags
        (append (list
                 "wbr"
                 "object"
                 "source"
                 "area"
                 "param"
                 "option"
                 )
                zencoding-self-closing-tags))
  (add-hook 'html-mode-hook 'zencoding-mode)
  (add-hook 'web-mode-hook 'zencoding-mode)
  ;; yasnippetを使わない場合
  ;; (define-key zencoding-mode-keymap (kbd "C-,") 'zencoding-expand-line)
  ;; yasnippetと連携する場合 (キーバインドは自由に)
  (define-key zencoding-mode-keymap (kbd "C-,") 'zencoding-expand-yas))

(provide '21-zencoding-mode)
;;; 21-zencoding-mode.el ends here
