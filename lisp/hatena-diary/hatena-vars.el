(provide 'hatena-vars)

(defgroup hatena nil
  "major mode for Hatena::Diary"
  :prefix "hatena-"
  :group 'hypermedia)

(defgroup hatena-face nil
  "Hatena, Faces."
  :prefix "hatena-"
  :group 'hatena)

(defcustom hatena-usrid nil
  "hatena-diary-mode �Υ桼����̾"
  :type 'string
  :group 'hatena)

(defcustom hatena-directory 
  (expand-file-name "~/.hatena/")
  "��������¸����ǥ��쥯�ȥ�."
  :type 'directory
  :group 'hatena)

(defcustom hatena-init-file (concat
			     (file-name-as-directory hatena-directory)
			     "init")
  "*hatena-diary-mode �ν�����ե����롣"
  :type 'file
  :group 'hatena)

(defcustom hatena-password-file 
  (expand-file-name (concat hatena-directory ".password"))
  "�ѥ�����¸����ե�����"
  :type 'file
  :group 'hatena)

(defcustom hatena-entry-type 1
  "����ȥ�Υޡ������å� * ��ɤΤ褦�˽������뤫��
0�ʤ� * �� *pn* �ˡ�1 �ʤ� * �� *<time>* ���֤�����������"
  :type 'integer
  :group 'hatena)

(defcustom hatena-change-day-offset 6
  "�ϤƤʤ�, ���դ��Ѥ������ .+6 �Ǹ��� 6 �������դ��ѹ�����."
  :type 'integer
  :group 'hatena)

(defcustom hatena-trivial nil
  "����äȤ��������򤹤뤫�ɤ���. non-nil ��\"����äȤ�������\"�ˤʤ�"
  :type 'boolean
  :group 'hatena)

(defcustom hatena-use-file t
  "�ѥ���ɤ�(�Ź沽����)��¸���뤫�ɤ��� non-nil �ʤ�ѥ���ɤ� base 64 �ǥ��󥳡��ɤ�����¸����"
  :type 'boolean
  :group 'hatena)

(defcustom hatena-cookie 
  (expand-file-name 
   (concat hatena-directory "Cookie@hatena"))
  "���å�����̾����"
  :type 'file
  :group 'hatena)

(defcustom hatena-browser-function nil  ;; ���̤ϡ�'browse-url
  "Function to call browser.
If non-nil, `hatena-submit' calls this function.  The function
is expected to accept only one argument(URL)."
  :type 'symbol
  :group 'hatena)

(defcustom hatena-proxy ""
  "curl ��ɬ�פʻ������������ꤹ��"
  :type 'string
  :group 'hatena)

(defcustom hatena-default-coding-system 'euc-jp
  "�ǥե���ȤΥ����ǥ��󥰥����ƥ�"
  :type 'symbol
  :group 'hatena)


(defcustom hatena-url "http://d.hatena.ne.jp/"
  "�ϤƤʤΥ��ɥ쥹"
  :type 'string
  :group 'hatena)

(defcustom hatena-twitter-flag nil
  "������������twitter�����Τ򤹤뤫�ɤ���. non-nil ��\"twitter������\"�ˤʤ�"
  :type 'boolean
  :group 'hatena)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;�����ե����������ɽ��
(defvar hatena-fname-regexp
  "\\([0-9][0-9][0-9][0-9]\\)\\([01][0-9]\\)\\([0-3][0-9]\\)$" )
(defvar hatena-diary-mode-map nil)

;;�Ť�����
(defvar hatena-header-regexp 
  (concat "\\`      Title: \\(.*\\)\n"
          "Last Update: \\(.*\\)\n"
          "____________________________________________________" ))

(defvar hatena-tmpfile 
  (expand-file-name (concat hatena-directory "hatena-temp.dat")))
(defvar hatena-tmpfile2
  (expand-file-name (concat hatena-directory "hatena-temp2.dat")))
(defvar hatena-curl-command "curl" "curl ���ޥ��")

(defvar hatena-twitter-prefix nil "twitter����Ƥ�������")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;face

(defvar hatena-font-lock-keywords nil)
(defvar hatena-html-face 'hatena-html-face)
(defvar hatena-title-face 'hatena-title-face)
(defvar hatena-header-face 'hatena-header-face)
(defvar hatena-subtitle-face 'hatena-subtitle-face)
(defvar hatena-markup-face 'hatena-markup-face)
(defvar hatena-link-face 'hatena-link-face)

(defface hatena-title-face
  '((((class color) (background light)) (:foreground "Navy" :bold t))
    (((class color) (background dark)) (:foreground "wheat" :bold t)))
  "title�� face"
  :group 'hatena-face)

(defface hatena-header-face
  '((((class color) (background light)) (:foreground "Gray70" :bold t))
    (((class color) (background dark)) (:foreground "SkyBlue4" :bold t)))
  "last update�� face"
  :group 'hatena-face)

(defface hatena-subtitle-face 
  '((((class color) (background light)) (:foreground "DarkOliveGreen"))
    (((class color) (background dark)) (:foreground "wheat")))
  "���֥����ȥ��face"
  :group 'hatena-face)

(defface hatena-markup-face 
  '((((class color) (background light)) (:foreground "firebrick" :bold t))
    (((class color) (background dark)) (:foreground "IndianRed3" :bold t)))
  "�ϤƤʤΥޡ������åפ�face"
  :group 'hatena-face)

(defface hatena-html-face 
  '((((class color) (background light)) (:foreground "DarkSeaGreen4"))
    (((class color) (background dark)) (:foreground "Gray50")))
  "html��face"
  :group 'hatena-face)

(defface hatena-link-face 
  '((((class color) (background light)) (:foreground "DarkSeaGreen4"))
    (((class color) (background dark)) (:foreground "wheat")))
  "html�����Ƕ��ޤ줿��ʬ��face"
  :group 'hatena-face)

;-----------------------------------------------------------------------------------
; �ϤƤʵ�ˡ�إ��
;-----------------------------------------------------------------------------------
(defvar hatena-help-syntax-index
  'dummy
  "���ϻٱ絭ˡ `hatena-help-syntax-input'
   ��ư��� `hatena-help-syntax-autolink'
   �ϤƤ��⼫ư��� `hatena-help-syntax-hatena-autolink'
   ���ϻٱ絡ǽ `hatena-help-syntax-other'")

(defvar hatena-help-syntax-input
  'dummy
  "���ϻٱ絭ˡ

|------------------------------+------------------------------+-----------------------------------------------------|
| ��ˡ̾                       | ��                         | ��ǽ                                                |
|------------------------------+------------------------------+-----------------------------------------------------|
| ���Ф���ˡ                   | *������                        | �����˸��Ф���h3�ˤ��դ��ޤ�                        |
| �����դ����Ф���ˡ           | *t*������, *t+1*������           | ���Ф����Խ��������¸��ɽ�����ޤ�                  |
| name°���դ����Ф���ˡ       | *name*������                   | ���Ф��˹����� name °����Ĥ��ޤ�                  |
| ���ƥ��꡼��ˡ               | *[������]������                  | �����˥��ƥ��꡼�����ꤷ�ޤ�                        |
| �����Ф���ˡ                 | **������                       | �����˾����Ф���h4�ˤ�Ĥ��ޤ�                      |
| �������Ф���ˡ               | ***������                      | �����˾������Ф���ˡ��h5�ˤ�Ĥ��ޤ�                |
| �ꥹ�ȵ�ˡ                   | -������, --������, +������, ++������ | �ꥹ�ȡ�li�ˤ��ñ�˵��Ҥ��ޤ�                      |
| ����ꥹ�ȵ�ˡ               | :������:������                   | ����ꥹ�ȡ�dt�ˤ��ñ�˵��Ҥ��ޤ�                  |
| ɽ�Ȥߵ�ˡ                   | | ������  | ������  |            | ɽ�Ȥߡ�table�ˤ��ñ�˵��Ҥ��ޤ�                   |
|                              | |*������  | ������  |            |                                                     |
| ���ѵ�ˡ                     | >> ������ <<                   | ���ѥ֥�å���blockquote�ˤ��ñ�˵��Ҥ��ޤ�        |
| pre��ˡ                      | >| ������ |<                   | ���������ƥ����Ȥ򤽤Τޤ�ɽ�����ޤ���pre��         |
| �����ѡ�pre��ˡ              | >|| ������ ||<                 | ��������HTML�ʤɤΥ������򤽤Τޤ�ɽ�����ޤ���pre�� |
| �����ѡ�pre��ˡ              | >|�ե����륿����| ������ ||<   | ���������ץ����Υ����������ɤ�                  |
| �ʥ��󥿥å������ϥ��饤�ȡ� | >|??| ������ ||<               | ���դ�����ɽ�����ޤ���pre��                         |
|                              |                              |                                                     |
| aa��ˡ                       | >|aa| ������ ||<               | �������������Ȥ��ñ�ˤ��줤��ɽ�����ޤ�            |
| ����ˡ                     | (( ������ ))                   | �����˵�������ꤷ�ޤ�                              |
| ³�����ɤ൭ˡ               | ====                         | ���θ��Ф��ޤǤ��θ���������³�����ɤ�פˤ��ޤ�  |
| �����ѡ�³�����ɤ൭ˡ       | =====                        | ���Ф���ޤ�Ƥ��θ�����Ƥ��³�����ɤ�פˤ��ޤ�  |
| ���Ե�ˡ                     | (Ϣ³��������ι�2��)        | ���ԡ�br�ˤ��������ޤ�                              |
| p������ߵ�ˡ                | >< ������ ><                   | ��ư��������� p ��������ߤ��ޤ�                   |
| tex��ˡ                      | [tex:������]                   | mimeTeX ��Ȥäƿ�����ɽ�����ޤ�                    |
| ������쵭ˡ                 | [uke:������]                   | �������Υ��������ɽ�����ޤ�                      |
|------------------------------+------------------------------+-----------------------------------------------------|

�����ѡ�pre��ˡ���б����Ƥ���ե����륿����

a2ps a65 aap abap abaqus abc abel acedb actionscript ada aflex ahdl alsaconf amiga aml ampl ant antlr apache  apachestyle arch art asm asm68k asmh8300 asn aspperl aspvbs asterisk  asteriskvm atlas automake ave awk ayacc b baan basic  bc bdf  bib bindzone blank bst btm c calendar catalog cdl cf cfg ch change changelog chaskell cheetah  chill chordpro cl clean clipper cmake cobol colortest conf config context cpp crm crontab cs csc csh csp css cterm ctrlh cupl cuplsim cvs cvsrc cweb cynlib cynpp d dcd dcl debchangelog debcontrol debsources def desc desktop dictconf dictdconf diff  dircolors diva  django  dns docbk docbksgml docbkxml dosbatch dosini dot doxygen dracula dsl dtd dtml dylan dylanintr dylanlid ecd edif eiffel elf elinks elmfilt erlang eruby esmtprc esqlc esterel eterm eviews exim expect exports fasm fdcc fetchmail  fgl flexwiki  focexec form forth fortran foxpro fstab fvwm fvwm2m4 gdb  gdmo gedcom gkrellmrc gnuplot go gp gpg grads gretl groff groovy group grub gsp gtkrc haskell  hb help hercules hex hitest hog html htmlcheetah htmldjango htmlm4 htmlos ia64 icemenu icon idl idlang indent inform initex inittab ipfilter ishd iss ist jal jam jargon java javacc javascript  jess jgraph jproperties jsp kconfig kix kscript kwt lace latte ld ldif lex lftp lhaskell libao lifelines lilo limits lisp lite loginaccess logindefs logtalk lotos lout lpc lprolog lscript lss lua lynx m4 mail mailaliases mailcap make man manconf manual maple masm mason master matlab maxima  mel mf mgl mgp mib  mma mmix modconf model modsim3 modula2 modula3 monk moo mp mplayerconf mrxvtrc msidl msql mupad mush muttrc mysql named nanorc nasm nastran natural  ncf netrc netrw nosyntax nqc nroff nsis objc objcpp ocaml occam omnimark openroad opl ora pamconf papp pascal passwd pcap pccts perl pf pfmain php phtml pic pike pilrc pine pinfo plaintex plm plp plsql po pod postscr pov povini ppd ppwiz prescribe procmail progress prolog protocols psf ptcap purifylog pyrex python qf quake r racc radiance ratpoison rc rcs rcslog readline  rebol registry remind resolv rexx rhelp rib rnc rnoweb robots  rpcgen rpl rst rtf ruby samba sas sather scala scheme  scilab  screen  sdl sed sendpr sensors services setserial sgml sgmldecl sgmllnx sh sicad sieve simula sinda sindacmp sindaout sisu skill sl slang slice slpconf slpreg slpspi slrnrc slrnsc sm smarty smcl smil smith sml snnsnet snnspat snnsres snobol4 spec specman spice splint spup spyce sql  sqlanywhere sqlforms sqlinformix sqlj sqloracle sqr squid sshconfig sshdconfig st stata stp strace sudoers svn syncolor synload syntax sysctl tads tags tak takcmp takout tar tasm tcl tcsh  terminfo tex  texinfo texmf tf tidy tilde tli tpp trasys trustees tsalt tsscl tssgm tssop uc udevconf udevperm udevrules uil updatedb valgrind vb vera verilog verilogams vgrindefs vhdl  vim viminfo virata vmasm vrml vsejcl wdiff web webmacro wget  whitespace winbatch wml wsh wsml wvdial xdefaults xf86conf xhtml  xinetd xkb xmath xml xmodmap xpm xpm2 xquery xs xsd xslt  xxd yacc  yaml z8a zsh
")
	
(defvar hatena-help-syntax-autolink
  'dummy
  "��ư���

|--------------------+---------------------------------+--------------------------------------------|
| ��ˡ̾             | ��                            | ��ǽ                                       |
|--------------------+---------------------------------+--------------------------------------------|
| http��ˡ           | http://������                     | URL�ؤλϤޤ��󥯤��ñ�˵��Ҥ��ޤ�      |
|                    | [http: //������:title]            |                                            |
|                    | [http://������:barcode]           |                                            |
|                    | [http://������:image]             |                                            |
|                    |                                 |                                            |
| mailto��ˡ         | mailto:������                     | �᡼�륢�ɥ쥹�ؤΥ�󥯤��ñ�˵��Ҥ��ޤ� |
| niconico��ˡ       | [niconico:sm*******]            | �˥��˥�ư��κ����ץ졼�䡼��ɽ�����ޤ�   |
| google��ˡ         | [google:������]                   | Google �θ�����̤˥�󥯤��ޤ�            |
|                    | [google:image:������]             |                                            |
|                    | [google:news:������]              |                                            |
|                    |                                 |                                            |
| map��ˡ            | map:x������y������ (:map)           | Google�ޥåפ�ɽ��������󥯤��ޤ�         |
|                    | [map:������]                      |                                            |
|                    | [map:t:������]                    |                                            |
|                    |                                 |                                            |
| amazon��ˡ         | [amazon:������]                   | Amazon �θ�����̤˥�󥯤��ޤ�            |
| wikipedia��ˡ      | [wikipedia:������]                | Wikipedia�ε����˥�󥯤��ޤ�              |
| twitter��ˡ        | twitter:����:title��            | Twitter�ΤĤ֤䤭�˥�󥯤��ޤ�            |
|                    | twitter:����:tweet��            |                                            |
|                    | twitter:����:detail��           |                                            |
|                    | twitter:����:detail:right��     |                                            |
|                    | twitter:����:detail:left��      |                                            |
|                    | twitter:����:tree��             |                                            |
|                    | [twitter:@hatenadiary]��        |                                            |
|                    | [http://twitter.com/hatenadiary |                                            |
|                    | /status/����:twitter:title]     |                                            |
| ��ư�����ߵ�ˡ | [] �ϤƤʵ�ˡ []                | �ϤƤʵ�ˡ�ˤ�뼫ư��󥯤���ߤ��ޤ�     |
|--------------------+---------------------------------+--------------------------------------------|
")

(defvar hatena-help-syntax-hatena-autolink
  'dummy
  "�ϤƤ��⼫ư���

|---------------+-------------------------------+-------------------------------------------------|
| ��ˡ̾        | ��                          | ��ǽ                                            |
|---------------+-------------------------------+-------------------------------------------------|
| id��ˡ        | id:�������� id:������:archive     | �ϤƤʥ桼�����˥�󥯤���                      |
|               | id:������:about��id:������:image  | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | id:������:detail��id:����+����  |                                                 |
|               |                               |                                                 |
| question��ˡ  | question:������:title           | ���ϸ����ϤƤʤ˥�󥯤���                      |
|               | question:������:detail          | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | question:������:image           |                                                 |
|               |                               |                                                 |
| search��ˡ    | [search:������]                 | �ϤƤʸ����θ�����̤˥�󥯤��ޤ�              |
|               | [search:keyword:������]         |                                                 |
|               | [search:question:������]        |                                                 |
|               | [search:asin:������]            |                                                 |
|               | [search:web:������]             |                                                 |
|               |                               |                                                 |
| antenna��ˡ   | a:id:������                     | �ϤƤʥ���ƥʤ˥�󥯤��ޤ�                    |
| bookmark��ˡ  | b:id:������ (:������)             | �ϤƤʥ֥å��ޡ����˥�󥯤��ޤ�                |
|               | [b:id:������:t:������]            |                                                 |
|               | [b:t:������]                    |                                                 |
|               | [b:keyword:������]              |                                                 |
|               |                               |                                                 |
| diary��ˡ     | d:id:������                     | �ϤƤʥ������꡼�˥�󥯤���                    |
|               | d:id:����+����                | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | [d:keyword:������]              |                                                 |
|               |                               |                                                 |
| fotolife��ˡ  | f:id:������:������:image          | �ϤƤʥե��ȥ饤�դμ̿���ɽ������              |
|               | f:id:������:������:movie          | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | f:id:������(:favorite)          |                                                 |
|               |                               |                                                 |
| group��ˡ     | g:������                        | �ϤƤʥ��롼�פ˥�󥯤���                      |
|               | g:������:id:������                | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | [g:������:keyword:������]��¾     |                                                 |
|               |                               |                                                 |
| haiku��ˡ     | [h:keyword:������]              | �ϤƤʥϥ����˥�󥯤��ޤ�                      |
|               | [h:id:������]                   |                                                 |
|               |                               |                                                 |
| idea��ˡ      | idea:������ (:title)            | �ϤƤʥ����ǥ��˥�󥯤���                      |
|               | i:id:������                     | ��ư�ȥ�å��Хå����������ޤ�                  |
|               | [i:t:������]                    |                                                 |
|               |                               |                                                 |
| rss��ˡ       | r:id:������                     | �ϤƤ�RSS�˥�󥯤��ޤ�                         |
| graph��ˡ     | graph:id:������                 | �ϤƤʥ���դ�ɽ��������󥯤��ޤ�              |
|               | [graph:id:������:������ (:image)] |                                                 |
|               | [graph:t:������]                |                                                 |
|               |                               |                                                 |
| keyword��ˡ   | [[[[������]]]]                      | ������ɤ˥�󥯤��ޤ�                        |
|               | [keyword:������]                |                                                 |
|               | [keyword:������:graph]��¾      |                                                 |
|               |                               |                                                 |
| isbn/asin��ˡ | isbn:���������� ����            | ���ҡ����ڡ��ǲ�ʤɤξҲ��󥯤�ɽ�����ޤ�    |
|               | asin:������                     |                                                 |
|               | isbn:������:title               |                                                 |
|               | isbn:������:image               |                                                 |
|               | isbn:������:detail��¾          |                                                 |
|               |                               |                                                 |
| rakuten��ˡ   | [rakuten:������]                | ��ŷ�Ծ�ξ��ʤξҲ��󥯤�ɽ�����ޤ�          |
| jan/ean��ˡ   | jan:�������� ean:��������¾       | JAN/EAN�����ɤ�Ȥä����ʾҲ��󥯤�ɽ�����ޤ� |
| ugomemo��ˡ   | ugomemo:������                  | ��������Ž���դ��ޤ�                          |
|---------------+-------------------------------+-------------------------------------------------|
")

(defvar hatena-help-syntax-other
  'dummy
  "���ϻٱ絡ǽ

|--------------------------------------+----------------------------------------------------------|
| �إ��                               | ��                                                     |
|--------------------------------------+----------------------------------------------------------|
| ��*�פ��-�פ򤽤Τޤ޹�Ƭ��ɽ������ | �ʹ�Ƭ��Ⱦ�Ѥζ����Ĥ����                             |
| ���񤭵�ˡ                           | <!-- ������ -->                                            |
| ����������¸��ǽ                     | <ins> ������ </ins>, <del> ������ </del>                     |
| cite��title°��                      | <blockquote cite=\"������\" title=\"������\"> ������ </blockquote> |
| ��ư��󥯤򥿥���ǻȤ�             | <a href=\"�ϤƤʵ�ˡ\"> ������ </a>                          |
|--------------------------------------+----------------------------------------------------------|
")






