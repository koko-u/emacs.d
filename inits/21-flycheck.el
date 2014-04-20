(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

(require 'flycheck-tip)

(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-clang-language-standard "c++11")
    '(flycheck-clang-include-path "/usr/include/c++/v1")
    ))
