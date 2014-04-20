(require 'helm-config)
(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)

;; C-h でバックスペースと同じように文字を削除できるようにする
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)

;; TAB で補完する
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)

;; http://d.hatena.ne.jp/sugyan/20120104/1325604433
;; プレフィックスキーを C-; に設定する
(custom-set-variables '(helm-command-prefix-key "C-;"))
