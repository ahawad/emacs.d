;;TODO: this should be part of the helm config, but I left it here for now
(global-set-key  (kbd "C-h m") 'helm-man-woman)

(require-package 'rtags)
(require-package 'irony)
(require-package 'flycheck-irony)
(require-package 'cmake-ide)
;;setting up the rtags package
(setq rtags-autostart-diagnostics t
      rtags-completions-enabled t
      rtags-use-helm t)
(rtags-enable-standard-keybindings)

(add-hook 'c-mode-hook 'irony-mode)

;;setting up irony [code found in: http://syamajala.github.io/c-ide.html]
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;setting up company mode to use rtags
(require 'company-rtags)
(after-load 'company
  (add-hook 'irony-mode-hook (lambda () (sanityinc/local-push-company-backend 'company-rtags))))

;;setting up company mode to use irony [code found in: http://syamajala.github.io/c-ide.html]
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(when (maybe-require-package 'company-irony)
  (after-load 'company
    (add-hook 'irony-mode-hook (lambda () (sanityinc/local-push-company-backend 'company-irony)))))


(when (maybe-require-package 'company-irony-c-headers)
  (after-load 'company
    (add-hook 'irony-mode-hook (lambda () (sanityinc/local-push-company-backend 'company-irony-c-headers)))))

;;enable flycheck for c-mode
(add-hook 'c-mode-hook 'flycheck-mode)

;;add flycheck-irony
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;add flycheck-rtags setup
(require 'flycheck-rtags)
(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;setup cmake-ide
(cmake-ide-setup)
(provide 'init-cc)
