;; スタイル設定
(add-hook 'c-mode-common-hook
          '(lambda ()
             ; styleには GNU,cc-mode,ktr,bsd,stroustrup,whitesmith
             ; ,ellemtel,linux等がある
             ;(c-set-style "ellemtel")
             (c-set-style "cc-mode")
             ; 基本オフセット
             (setq c-basic-offset 4)
             ; コメント行のオフセット
             ;(c-comment-only-line-of . 0)
             ; 全自動インデントを有効
             (setq c-auto-newline t)
             ; TABキーでインデント
             (c-tab-always-indent t)
             ; namespace {}の中はインデントしない
             (c-set-offset 'innamespace 0)
             ; 連続するスペースをバックスペース一回で削除する
             (c-toggle-hungry-state t)
             ; センテンスの終了である ; を入力したら自動的に改行してインデント
             ;(c-toggle-auto-hungry-state t)
             ;; 対応する括弧の挿入 しばらく smartchr を利用してみる
             ;; (make-variable-buffer-local 'skeleton-pair)
             ;; (make-variable-buffer-local 'skeleton-pair-on-word)
             ;; (setq skeleton-pair-on-word t)
             ;; (setq skeleton-pair t)
             ;; (make-variable-buffer-local 'skeleton-pair-alist)
             ;; (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
             ;; (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
             ))

;; コンパイルセッセージの縦幅
(setq compilation-window-height 8)

;; Makefile用の設定
(add-hook 'makefile-mode-hook
          (function (lambda ()
                      (whitespace-mode t)
                      ;; suspicious-lines を無視しておく
                      (fset 'makefile-warn-suspicious-lines 'ignore)
                      (setq indent-tabs-mode t))))

;; コードを貼り付けた時に自動的にインデントする
(dolist (command '(yank yank-pop))
       (eval `(defadvice ,command (after indent-region activate)
                (and (not current-prefix-arg)
                     (member major-mode '(emacs-lisp-mode lisp-mode
                                                          clojure-mode    scheme-mode
                                                          haskell-mode    ruby-mode
                                                          rspec-mode      python-mode
                                                          c-mode          c++-mode
                                                          objc-mode       latex-mode
                                                          plain-tex-mode))
                     (let ((mark-even-if-inactive transient-mark-mode))
                       (indent-region (region-beginning) (region-end) nil))))))
