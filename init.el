;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(wombat))
 '(package-selected-packages
   '(epc helm-taskswitch ess groovy-mode flymd helm-ag helm flycheck-pyflakes python-docstring py-import-check jedi flymake-python-pyflakes flycheck-pycheckers elpy company-jedi)))
(custom-set-faces
 )

;; Load other configs
(load "~/.emacs.d/nextflow.el")

;; <TAB> settings
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(defun my-python-indent-line ()
  (if (eq (car (python-indent-context)) :inside-docstring)
      'noindent
    (python-indent-line)))

(defun my-python-mode-hook ()
  (setq indent-line-function #'my-python-indent-line))
(add-hook 'python-mode-hook #'my-python-mode-hook)

;; Python syntax checker
(require 'flycheck-pyflakes)
(add-hook 'python-mode-hook 'flycheck-mode)
(with-eval-after-load 'company
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'jedi:setup)

;; Move by block
(defun xah-forward-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))

(defun xah-backward-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n))
	($i 1))
    (while (<= $i n)
      (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
	  (progn (skip-chars-backward "\n\t "))
	(progn (goto-char (point-min))
	       (setq $i n)))
      (setq $i (1+ $i)))))

;; Custom mappings
(global-set-key (kbd "M-p") 'xah-backward-block)
(global-set-key (kbd "M-n") 'xah-forward-block)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-h") 'comint-dynamic-complete-filename)

;; keep a list of recently opened files
(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(setq backup-directory-alist `(("." . "~/.emacs_saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Custom macros
(fset 'ipdb
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("import ipdb;ipdb.set_trace()" 0 "%d")) arg)))
(fset 'pymain
      "if __name__ == '__main__':\C-m")
(fset 'shebang
      "#!/usr/bin/env bash")
(fset 'pyinit
   "\C-[[200~import argparse\C-m\C-mimport pandas as pd\C-mimport numpy as np\C-m\C-mdef parse_args():\C-m    '''\C-m    '''\C-m\C-m    parser = argparse.ArgumentParser()\C-m    parser.add_argument('', type=int, default=0)\C-m    args = parser.parse_args()\C-m\C-m    r\
eturn args\C-m\C-mdef main():\C-m    '''\C-m    '''\C-m\C-m    args = parse_args()\C-m\C-mif __name__ == '__main__':\C-m    main()\C-[[201~\C-[xend\C-ibd\C-i\C-?\C-?kbd\C-i")
(fset 'nfinit
   "\C-[[200~nextflow.enable.dsl = 2\C-m\C-minclude {} from './' addParams()\C-m\C-mprocess P {\C-m    tag \"$meta.id\"\C-m\C-m    input:\C-m\C-m    output:\C-m\C-m    script:\C-m    \"\"\"\C-m    \"\"\
\"\C-m}\C-m\C-mworkflow {\C-m\C-m}\C-[[201~\C-m")

