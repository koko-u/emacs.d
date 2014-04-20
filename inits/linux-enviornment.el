;; 文字コード
;;(set-language-environment 'Japanese)
(set-language-environment  'utf-8)
(prefer-coding-system 'utf-8)

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
               (expand-file-name "~/.rvm/rubies/ruby-1.9.2-p136/bin")
               ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man" (getenv "MANPATH")))

(setenv "JAVA_OPTS" "-Dfile.encoding=UTF-8")

(setenv "CVS_RSH" "ssh")
(setenv "SSH_AUTH_SOCK" (getenv "SSH_AUTH_SOCK"))
(setenv "LC_ALL" "ja_JP.UTF-8")

;; font
(set-face-attribute 'default nil
                    :family "Ricty Discord"
                    :height 120)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty Discord" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty Discord" "iso10646-1"))
