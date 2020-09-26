#!/bin/bash
# 
# Code adapted from https://gist.github.com/padawanphysicist/d6299870de4ef8ad892f
# Inspired from http://hacks-galore.org/aleix/blog/archives/2013/01/08/install-emacs-packages-from-command-line
#

# Package to be installed
pkg_name=$1

# Elisp script is created as a temporary file, to be removed after installing 
# the package
elisp_script_name=$(mktemp /tmp/emacs-pkg-install-el.XXXXXX)
elisp_code="
(require 'package)
(package-initialize)
(add-to-list 'package-archives
             '(\"melpa\" . \"http://melpa.org/packages/\") t)
;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)

(package-refresh-contents)
(package-install pkg-to-install)"

echo "$elisp_code" > $elisp_script_name

emacs --batch --eval "(defconst pkg-to-install '$pkg_name)" -l $elisp_script_name

# Remove tmp file
rm "$elisp_script_name"

