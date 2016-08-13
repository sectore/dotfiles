;;; personal.el --- Personal configuration entry point

;;; Commentary:

;; Emacs (Prelude) configuration of JK

;;; Code:


;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; Major modes

;; haskell
(unless (package-installed-p 'intero)
    (package-install 'intero))

(add-hook 'haskell-mode-hook 'intero-mode)

;; elm
(require 'elm-mode)

;; purescript
;; specify path to the 'psc-ide' executable
(require 'psc-ide)

(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (company-mode)
            (flycheck-mode)
            (turn-on-purescript-indentation)))

;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; Minor modes

;; markdown
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; misc. configuration

;; keys
;; Disable option modifier to get alt+number using a German keyboard
;; Right option is for meta only
(setq mac-option-modifier 'none
      mac-right-option-modifier 'meta)

;; initial size of window
(add-to-list 'default-frame-alist '(height . 75))
(add-to-list 'default-frame-alist '(width . 155))

;; Disable autocompletion and trigger completion manually
(setq company-idle-delay nil)
(global-set-key (kbd "C-c SPC") 'company-complete)

;; font
(set-frame-font "Source Code Pro-14")

;; show line numbers
(global-linum-mode)

;; enable arrow keys
(setq prelude-guru nil)

;; disable standard theme
(disable-theme 'zenburn)

;; disable spellchecking
(setq prelude-flyspell nil)

;; hide scrollbar
(scroll-bar-mode -1)

;;; personal.el ends here

;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; functions

;; live preview of markdown by using Impatient-mode
;; See: http://wikemacs.org/wiki/Markdown#Live_preview_as_you_type
(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
          (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
        (current-buffer)))
