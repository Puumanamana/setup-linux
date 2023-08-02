(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (wombat)))
 '(package-selected-packages
   (quote
    (fill-column-indicator markdown-mode yaml-mode md-readme dockerfile-mode ess groovy-mode flymd helm-ag helm python-docstring py-import-check jedi))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 )

;; keep a list of recently opened files
(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")
(global-set-key (kbd "C-x C-r") 'helm-recentf)

(global-set-key (kbd "C-x b") 'helm-buffers-list)

(global-set-key (kbd "C-x C-h") 'comint-dynamic-complete-filename)

(setq backup-directory-alist `(("." . "~/.emacs_saves")))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

;; Map M-p and M-n to block cursor movement
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

(global-set-key (kbd "M-p") 'xah-backward-block)
(global-set-key (kbd "M-n") 'xah-forward-block)

;; TAB-related stuff
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)

(add-hook 'before-save-hook 'my-prog-nuke-trailing-whitespace)
(defun my-prog-nuke-trailing-whitespace ()
  (when (derived-mode-p 'prog-mode)
    (delete-trailing-whitespace)))

(defun my-python-indent-line ()
  (if (eq (car (python-indent-context)) :inside-docstring)
      'noindent
    (python-indent-line)))

(defun my-python-mode-hook ()
  (setq indent-line-function #'my-python-indent-line))
(add-hook 'python-mode-hook #'my-python-mode-hook)

;; Nextflow mode
(load "~/.emacs.d/nextflow-mode.el")
(add-to-list 'auto-mode-alist '("\\.config\\'" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.conf\\'" . groovy-mode))

;; R prevent auto-indent of single '#' comments 
(setq ess-indent-with-fancy-comments nil)

;; Custom pre-fill
(fset 'ipdb
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("import ipdb;ipdb.set_trace()" 0 "%d")) arg)))
(fset 'shebang
      "#!/usr/bin/env bash")
(fset 'pyinit
   "\C-[[200~import argparse\C-mimport pandas as pd\C-mimport numpy as np\C-mfrom Bio.SeqIO.FastaIO import SimpleFastaParser\C-m\C-mimport matplotlib.pyplot as plt\C-m\C-mdef parse_args():\C-m    parser \
= argparse.ArgumentParser()\C-m    parser.add_argument('', type=int, default=0)\C-m    parser.add_argument('', type=str)\C-m    args = parser.parse_args()\C-m\C-m    return args\C-m\C-mif __name__ == '__\
main__':\C-m    args = parse_args()\C-[[201~\C-m\C-m\C-?")
(fset 'nfinit
   "\C-[[200~nextflow.enable.dsl = 2\C-m\C-minclude {} from './' addParams()\C-m\C-mprocess P {\C-m    tag \"$meta.id\"\C-m\C-m    input:\C-m\C-m    output:\C-m\C-m    script:\C-m    \"\"\"\C-m    \"\"\"\C-m}\C-m\C-mworkflow {\C-m\C-m}\C-[[201~\C-m")

;; Copilot configuration
(add-to-list 'load-path "~/.emacs.d/copilot.el")
(require 'copilot)
(add-hook 'prog-mode-hook 'copilot-mode)
(add-to-list 'copilot-major-mode-alist '(python r dockerfile sql groovy))
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)

;; 90 character line display 
;; (setq fci-rule-column 90)
;; (setq fci-rule-color "yellow")
;; (require 'fill-column-indicator)
;; (add-hook 'python-mode-hook 'fci-mode)
;; (add-hook 'nextflow-mode-hook 'fci-mode)

