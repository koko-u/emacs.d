(provide 'hatena-kw)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; kw-cheating-section.

;;hatena-kw-cheating ��Ȥ���硣`hatena-tools.pl' �Τ���ǥ��쥯�ȥꡣ
;;hatena-mode.el ��Ʊ����
(defvar hatena-plugin-directory nil)

(defconst hatena-kw-if nil
  "�ǥե���Ȥ� kw-cheating(¾�ͤ�������ή���ɤ�) �򤹤뤫�ɤ���")

(defvar hatena-kw-list-buf nil)
(defvar hatena-kw-cheating-buf nil)
(defvar hatena-edit-buf nil)

(defvar hatena-kw-process nil
  "perl �Υץ���")

(defun hatena-kw-init()
  (interactive)
  ;;�ޤ�����Ĥ˥ꥻ�åȤ��Ƥ��顢��Ĥ˳�롣
  ;;��������ȡ����� `M-x hatena' ���Ƥ��뤬��Ĥ�������ˤʤ롣
  (delete-other-windows)
  (setq hatena-edit-buf (current-buffer))
  ;;hatena-edit-wdw ������񤯥Хåե�
  ;;hatena-keyword-cheating-wdw ¾�������򸫤륦����ɥ�
  (setq hatena-edit-wdw (selected-window))
  (setq hatena-kw-cheating-wdw 
	(split-window hatena-edit-wdw 
		      (floor (* (window-height)
				hatena-kw-window-split-ratio))))
  (save-selected-window 
    (select-window hatena-kw-cheating-wdw)
    (setq hatena-kw-cheating-buf
	  (switch-to-buffer "*hatena-keyword-cheating*"))
    (setq mode-name "Hatena kw-cheating"))
  ;;�����ޡ���������
  (if hatena-kw-post-timer
      (cancel-timer hatena-kw-post-timer))
  (if hatena-kw-ruby-timer
      (cancel-timer hatena-kw-ruby-timer))
  (if hatena-kw-get-timer
      (cancel-timer hatena-kw-get-timer))
  (setq hatena-kw-post-timer
	(run-at-time 0 
		     hatena-kw-repeat
		     'hatena-kw-post-func))
  (setq hatena-kw-ruby-timer
	(run-at-time (/ hatena-kw-repeat 4)
		     hatena-kw-repeat
		     'hatena-kw-ruby-func))
  (setq hatena-kw-get-timer
	(run-at-time (/ hatena-kw-repeat 2);; get �� post ��꾯���٤餻��
		     hatena-kw-repeat
		     'hatena-kw-get-func))
  ;; �ϤƤʤ˥�����ɤ��䤤��碌�뤿��Υڡ�������
  (hatena-kw-submit hatena-kw-temp-diary t)
  (message (concat "creating diary on " hatena-url "for kw-cheating"))
  )

(defun hatena-kw-final()
  (interactive)
  (if hatena-kw-post-timer
      (cancel-timer hatena-kw-post-timer))
  (if hatena-kw-ruby-timer
      (cancel-timer hatena-kw-ruby-timer))
  (if hatena-kw-get-timer
      (cancel-timer hatena-kw-get-timer)))

(defun hatena-kw-post-func()
  "`hatena-kw-temp-diary' ����Ʊ���ݥ���. "
;  (if (string-match "Hatena" mode-name)
      (progn
	(hatena-kw-submit hatena-kw-temp-diary))
;    (cancel-timer hatena-kw-post-timer));; hatena-diary-mode �Ǥʤ���С�ľ������ߤ��롣
  )

(defun hatena-kw-get-func()
  "ruby �� output �� hatena-kw-cheating-buf ��ɽ�����롣"
;  (if (string-match "Hatena" mode-name)
;      (progn
	  (with-current-buffer (current-buffer)
	    (set-buffer hatena-kw-cheating-buf)
	    (delete-region (point-min) (point-max)) ;;�����ä���
	    ;;from insert-file-contents-as-coding-system
	    (let ((coding-system-for-read 'euc-jp)
		  format-alist)
	      (insert-file-contents hatena-kw-result-file))
	    ;;�ʰץ������
	    (goto-char (point-min))
	    (while (re-search-forward "<[^>]+>" nil t)
			       (replace-match "" nil nil))
	    (goto-char (point-min))
	    (while (re-search-forward "\n\t+" nil t)
			       (replace-match "\n" nil nil))
	    (goto-char (point-min))
	    (while (re-search-forward "\n+" nil t)
			       (replace-match "\n" nil nil))
	    
	    )
;	  )
;    (cancel-timer hatena-kw-get-timer) ;; hatena-diary-mode �Ǥʤ���С�ľ������ߤ��롣
 ;   (message "Hatena get-timer cancelled"))
  )

(defvar hatena-kw-process nil)
(defun hatena-kw-perl-func(today)
  "  hatena-tools.pl �˽������Ϥ��� "
      (start-process "hatena-kw-process" 
		 "*hatena keyword*"
		 "perl"
		 (concat hatena-plugin-directory "hatena-tools.pl")
		 (concat hatena-directory today)
		 "firefox"
		 "10"
		 "10"
		 )
)
;(hatena-kw-perl-func "20051016")


(defun hatena-current-second(number)
  "���ߤޤǤ��ÿ����֤���emacs �Ǥ�������������줹��Τǡ���ư��������"
  (let* ((ct (current-time))
	 (high (float (car ct)))
	 (low (float (car (cdr ct))))
	 str)
    (setq str (format "%f"(+ 
			   (+ (* high (lsh 2 15)) low)
			   number)))
    (substring str 0 10) ;;
    ))

