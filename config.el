
(with-eval-after-load 'org
  (org-babel-do-load-languages 'org-babel-load-languages '((ruby . t)
                                                           (plantuml . t)
                                                           (C . t)
                                                           (gnuplot . t)
                                                           (R . t)
                                                           (sh . t)
                                                           )))
(setq org-plantuml-jar-path
      (expand-file-name "~/plantuml.jar"))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t)
  (yas-reload-all))

(use-package flycheck
  :ensure t)

(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3))

(with-eval-after-load 'company
                        (define-key company-active-map (kbd "M-n") nil)
                        (define-key company-active-map (kbd "M-p") nil)
                        (define-key company-active-map (kbd "C-n") #'company-select-next)
                        (define-key company-active-map (kbd "C-p") #'company-select-previous)
                        (define-key company-active-map (kbd "SPC") #'company-abort))

(use-package ggtags
  :ensure t)

(add-hook 'c++-mode 'yas-minor-mode)
(add-hook 'c-mode-hook 'yas-minor-mode)

(use-package flycheck-clang-analyzer
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    (require 'flycheck-clang-analyzer)
    (flycheck-clang-analyzer-setup)))

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'c-mode-hook 'company-mode))

(use-package company-c-headers
  :ensure t)

(defun c-mode-company-init ()
  (setq company-backends '((company-c-headers
                            company-dabbrev-code
                            company-irony))))

(use-package company-irony
  :ensure t)

(with-eval-after-load 'company
  (add-hook 'c++-mode-hook 'c-mode-company-init)
  (add-hook 'c-mode-hook 'c-mode-company-init))


(use-package irony
  :ensure t
  :config
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(with-eval-after-load 'ggtags
  (add-hook 'c++-mode-hook 'ggtags-mode)
  (add-hook 'c-mode-hook 'ggtags-mode))

(add-hook 'python-mode-hook 'yas-minor-mode)

(add-hook 'python-mode-hook 'flycheck-mode)

(with-eval-after-load 'company
  (add-hook 'python-mode-hook 'company-mode))

(use-package company-jedi
  :ensure t
  :config
  (require 'company)
  (add-hook 'python-mode-hook 'python-mode-company-init))

(add-hook 'emacs-lisp-mode-hook 'eldoc-mode)

(add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)

(add-hook 'emacs-lisp-mode-hook 'company-mode)

(use-package slime
  :ensure t
  :config
  (setq inferior-lisp-program "/usr/bin/sbc1")
  (setq slime-contribes '(slime-fancy)))

(add-hook 'shell-mode-hook 'yas-minor-mode)

(use-package magit
  :ensure t
  :config
  (setq magit-push-always-verify nil)
  (setq magit-commit-summary-max-length 50)
  :bind
  ("M-g" . magit-status))

(add-to-list 'org-structure-template-alist
             '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))

(add-hook 'shell-mode-hook 'flycheck-mode)

(add-hook 'shell-mode-hook 'company-mode)

(defun shell-mode-company-init ()
  (setq-local company-backends '((company-shell
                                  company-shell-env
                                  company-etags
                                  company-dabbrev-code))))

(use-package company-shell
  :ensure t
  :config
  (require 'company)
  (add-hook 'shell-mode-hook 'shell-mode-company-init))

(use-package ace-window
  :ensure t
  :config
  ;; aw-keys - the initial characters used in window labels, default is 1-9
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  ;; if you want these keys to work with fewer than three windows, you need to have aw-dispatch-always to t
  (setq aw-dispatch-always t)
  :bind
  ([remap other-window] . ace-window))

(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-hoizontally)

(defun config-visit ()
  "Visitthe config.org file"
  (interactive)
  (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'config-visit)

(defun config-reload ()
    "Reload ~/.emacs.d/config.org at runtime"
  (interactive)
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))
(global-set-key (kbd "C-c r") 'config-reload)

(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere 1)
(ido-mode 1)

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init
  (smex-initialize)
  :bind
  ("M-x" . smex))

(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq ibuffer-expert t)

(global-set-key (kbd "C-x b") 'ido-switch-buffer)

(use-package avy
  :ensure t
  :bind
  ("M-s" . avy-goto-char))

(use-package rainbow-mode
  :ensure t
  :init (rainbow-mode 1))

(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))

;; disable auto-save and auto-backup
(setq auto-save-default nil)
(setq make-backup-files nil)
;; don't use lockfiles to avoid editng collisions
(setq create-lockfiles nil)

;; store all backup and autosave files in the tmp dir
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))

;; highlight-symbol key binding
(use-package highlight-symbol
  :ensure t
  :config
  (global-set-key [(shift f8)] 'highlight-symbol)
  (global-set-key [f8] 'highlight-symbol-next)
  (global-set-key [(control f8)] 'highlight-symbol-prev)
  (global-set-key [(meta f8)] 'highlight-symbol-query-replace))

(use-package google-translate
  :ensure t
  :config
  (setq google-translate-translation-directions-alist
        '(("ja" . "en") ("en" . "de") ("de" . "fr") ("fr" . "de"))))
