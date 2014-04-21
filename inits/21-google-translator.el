(require 'google-translate)
(require 'google-translate-smooth-ui)
(global-set-key "\C-ct" 'google-translate-smooth-translate)
(setq google-translate-translation-directions-alist
      '(("en" . "ja")
        ("ja" . "en")))
(setq google-translate-input-method-auto-toggling t)
(setq google-translate-preferable-input-methods-alist
      '((nil . ("en"))
        (japanese-skk . ("ja"))))
