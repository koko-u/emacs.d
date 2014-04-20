(add-hook 'after-init-hook #'global-flycheck-mode)

(eval-after-load 'flycheck
  '(define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))

(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)

(require 'flycheck-tip)

