;;; personal.el --- Personal configuration entry point

;;; Commentary:

;; Emacs (Prelude) configuration of JK

;;; Code:


;; god mode
;; https://github.com/chrisdone/god-mode

(require 'god-mode)
(global-set-key (kbd "<escape>") 'god-local-mode)
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)

(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'box
                      'bar)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

(require 'god-mode-isearch)
(define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)

;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; language support

;; haskell

;; (unless (package-installed-p 'intero)
;;     (package-install 'intero))

;; (add-hook 'haskell-mode-hook 'intero-mode)

(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-mode-hook #'hindent-mode)

(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(let ((my-stack-path (expand-file-name "~/.local/bin/")))
  (setenv "PATH" (concat my-stack-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-stack-path))

(custom-set-variables '(haskell-tags-on-save t))

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t))
(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(custom-set-variables '(haskell-process-type 'stack-ghci))

(add-to-list 'company-backends 'company-ghc)
(custom-set-variables '(company-ghc-show-info t))


;; Elm
(require 'elm-mode)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-elm-setup))

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
;; misc

;; markdown
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; keys
;; Disable option modifier to get alt+number using a German keyboard
;; Right option is for meta only
(setq mac-option-modifier 'none
      mac-right-option-modifier 'meta)

;; initial size of window
(add-to-list 'default-frame-alist '(height . 75))
(add-to-list 'default-frame-alist '(width . 155))

;; Disable autocompletion and trigger completion manually
;; (setq company-idle-delay nil)
;; (global-set-key (kbd "C-c SPC") 'company-complete)

;; font
(set-frame-font "Source Code Pro-15")

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

;; Highlight current line
(global-hl-line-mode 0)

;; Line numbers
(global-linum-mode t)


;;; personal.el ends here

;; ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;; functions

;; live preview of markdown by using Impatient-mode
;; See: http://wikemacs.org/wiki/Markdown#Live_preview_as_you_type
(defun markdown-html (buffer)
  (princ (with-current-buffer buffer
          (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://strapdownjs.com/v/0.2/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
        (current-buffer)))
