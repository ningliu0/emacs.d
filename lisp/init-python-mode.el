;; Description:
;;     Python programming environment based on built-in python.el and elpy.


;; Enable elpy
(elpy-enable)

;; Use jedi as rpc backend
(setq elpy-rpc-backend "jedi")

;; Use IPython as interpreter for interactive Python
(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"
        python-shell-interpreter-args "-i --simple-prompt --matplotlib=qt5"))

;; Disable CEDET semantic for python-mode as it hangs
(defun disable-semantic-mode ()
  (semantic-mode -1))
(add-hook 'python-mode-hook 'disable-semantic-mode)

;; Fine tune editing behavior
(define-key python-mode-map (kbd "RET") 'newline-and-indent)
;; (add-hook 'python-mode-hook #'electric-spacing-mode)
(add-hook 'python-mode-hook #'python-docstring-mode)
(add-hook 'python-mode-hook #'sphinx-doc-mode)


(defun python-mode-editing ()
  "My editing preferences for python-mode."
  (interactive)
  (set (make-local-variable 'comment-inline-offset) 2)
  (setq python-indent-offset 4)
  (setq yas-indent-line 'fixed)
)
(add-hook 'python-mode-hook 'python-mode-editing)


;; Set identation colors not too intrusive
(set-face-background 'highlight-indentation-face "#282828")
(set-face-background 'highlight-indentation-current-column-face "#383838")


;; use python-mode for *.pyw and *.wsgi
(add-to-list 'auto-mode-alist '("\\.pyw\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.wsgi\\'" . python-mode))


;; Use flycheck to replace flymake
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


;; ein: Emacs Ipython Notebook
;; (setq ein:default-url-or-port 8889)
(setq ein:use-auto-complete-superpack t)
