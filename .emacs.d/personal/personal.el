;; show line numbers
(global-linum-mode t)

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

;; Install Intero
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

;; PureScript
(require 'psc-ide)

(add-hook 'purescript-mode-hook
  (lambda ()
    (psc-ide-mode)
    (company-mode)
    (flycheck-mode)
    (turn-on-purescript-indentation)))

;; nix
(package-install 'nix-mode)
