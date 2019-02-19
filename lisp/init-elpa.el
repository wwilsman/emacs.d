;;; init-elpa.el --- Initialize packages
;;; Commentary:
;;; Code:
(require 'package)
(require 'tls)

(setq
 package-enable-at-startup nil
 package-archives
 '(("melpa-stable" . "https://stable.melpa.org/packages/")
   ("melpa" . "https://melpa.org/packages/")
   ;;("gnu" . "http://elpa.gnu.org/packages/"))
   ("gnu" . "http://mirrors.163.com/elpa/gnu/"))
 package-archive-priorities
 '(("melpa-stable" . 10)
   ("melpa" . 5)
   ("gnu" . 0)))

(eval-when-compile
  (package-initialize)

  ;; first run, update package lists
  (or (file-exists-p package-user-dir)
      (package-refresh-contents))

  ;; install essential packages
  (dolist (package (list 'use-package 'diminish 'quelpa))
    (unless (package-installed-p package)
      (package-install package)))

  ;; bootstrap quelpa
  (if (require 'quelpa nil t)
    (quelpa-self-upgrade)
  (with-temp-buffer
    (url-insert-file-contents "https://framagit.org/steckerhalter/quelpa/raw/master/bootstrap.el")
    (eval-buffer)))

  ;; enable quelpa with use-package
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://framagit.org/steckerhalter/quelpa-use-package.git")
   :upgrade t)

  ;; require things for the first time
  (require 'use-package)
  (require 'quelpa-use-package)
  (require 'diminish)

  ;; always ensure packages are installed
  (setq use-package-always-ensure t))

(provide 'init-elpa)
;;; init-elpa.el ends here
