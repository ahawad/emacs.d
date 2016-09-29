(require-package 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ;; personal snippets
        "~/snippets/snippets/" ;; Default collection
        ))
(yas-global-mode 1)
(provide 'init-yasnips)
