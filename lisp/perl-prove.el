;;; perl-prove.el ---

;; Copyright (C) 2012  kozaki.tsuneaki

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

(require 'cl)

(defvar perl-prove-command "prove"
  "prove コマンド")
(defvar perl-prove-option  "-vt --nocolor"
  "prove コマンドのデフォルトオプション")
(defvar perl-prove-mark-file "Makefile.PL"
  "モジュールのトップと見なすディレクトリに存在するファイル")
(defvar perl-prove-include '("lib" "blib/lib" "t")
  "インクルードパスに追加するモジュールトップディレクトリからの
相対パス")

;;; internal variable
(defvar perl-prove-settings nil)
(make-variable-buffer-local 'perl-prove-settings)

(defun perl-prove (arg)
  "prove コマンドを実行する。

初回実行時に、ディストリビューションのトップディレクトリ、テストファ
イル、prove コマンドのオプションが問い合わせされる。ここで指定した
設定はバッファローカルに記憶され、次回以降は問い合わせ無く実効され
る。

前置引数をつけると、2回目以降であっても問い合わせされる。
"
  (interactive "P")
  (when (or arg (not perl-prove-settings))
    (let*
        ((module-elements nil)
         (path-elements
           (reverse
            (split-string
             (file-name-sans-extension (buffer-file-name))
             "/")))
         (module-root
          (file-name-as-directory
           (read-directory-name
            "Module Root: "
            (loop
             while path-elements
             for path = (reduce (lambda (a b)
                                  (concat b "/" a)) path-elements)
             do
             (when (and (file-directory-p path)
                        (file-exists-p
                         (concat path "/" perl-prove-mark-file)))
               (push (pop module-elements) path-elements)
               (return (file-name-as-directory path)))
             (push (pop path-elements) module-elements))
            nil t)))
         (test-file
          (if (string= (car module-elements) "t")
              (buffer-file-name)
            (let ((test-default
                   (loop for tfe on module-elements
                         for tf = (concat
                                   module-root "t/"
                                   (reduce (lambda (a b)
                                             (concat a "-" b)) tfe)
                                   ".t")
                         when (file-exists-p tf) return tf
                         finally (return (concat module-root "t/")))))
              (read-file-name
               "Test: " test-default test-default))))
         (opts
          (read-string "Options: " perl-prove-option)))
      (setq perl-prove-settings
            (list (cons 'root module-root )
                  (cons 'test test-file )
                  (cons 'opts opts )))))
  (compile
   (concat
    perl-prove-command
    " " (cdr (assq 'opts perl-prove-settings))
    (apply 'concat
     (mapcar
      (lambda (x)
        (concat
         " -I"
         (expand-file-name
          (concat (cdr (assq 'root perl-prove-settings)) x))))
      perl-prove-include))
    " " (file-relative-name (cdr (assq 'test perl-prove-settings))))))

(provide 'perl-prove)
;;; perl-prove.el ends here
