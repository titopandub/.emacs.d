(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(require 'cl)
;; Guarantee all packages are installed on start
(defvar packages-list
  '(rainbow-mode
    fill-column-indicator
    clojure-mode
    cursor-chg
    highlight-indentation
    highlight-symbol
    markdown-mode
    gitignore-mode
    heroku
    haskell-mode
    rspec-mode
    flymake
    flymake-ruby
    projectile
    zenburn-theme
    magit
    php-mode
    rbenv
    exec-path-from-shell
    yaml-mode
    deft)
  "List of packages needs to be installed at launch")

(defun has-package-not-installed ()
  (loop for p in packages-list
        when (not (package-installed-p p)) do (return t)
        finally (return nil)))
(when (has-package-not-installed)
  ;; Check for new packages (package versions)
  (message "%s" "Get latest versions of all packages...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; Install the missing packages
  (dolist (p packages-list)
    (when (not (package-installed-p p))
      (package-install p))))

(load-theme 'zenburn t)
(projectile-global-mode)

(global-set-key (kbd "C-x g") 'magit-status)

(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))

(ad-activate 'rspec-compile)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'deft)
(setq deft-extensions '("txt" "tex" "org"))
(setq deft-directory "~/Google Drive/notes")
(setq deft-text-mode 'org-mode)
(setq deft-recursive t)
(global-set-key [f8] 'deft)
(setq deft-use-filename-as-title t)
(setq deft-auto-save-interval 0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doc-view-resolution 80)
 '(package-selected-packages
   (quote
    (php-mode rainbow-mode markdown-mode highlight-symbol highlight-indentation fill-column-indicator cursor-chg clojure-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
