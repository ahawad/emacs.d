(global-set-key  (kbd "C-h m") 'helm-man-woman)

(require-package 'rtags)
(require-package 'irony)
(require-package 'flycheck-irony)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(provide 'init-cc)
