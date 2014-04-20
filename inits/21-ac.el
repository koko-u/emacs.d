(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/lisp/ac-dict")
(ac-config-default)

(global-set-key (kbd "C-'") 'ac-complete-with-helm)
(define-key ac-complete-mode-map (kbd "C-'") 'ac-complete-with-helm)

(require 'auto-complete-c-headers)
(add-to-list 'ac-sources 'ac-source-c-headers)

