(require-package 'neotree)
(require-package 'all-the-icons)

(setq-default neo-smart-open t)
(setq neo-theme 'icons)
(setq projectile-switch-project-action 'neotree-projectile-action)
(global-set-key [f8] 'neotree-toggle)


(provide 'init-neotree)
