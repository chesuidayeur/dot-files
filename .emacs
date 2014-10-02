(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(fci-rule-color "dim gray")
 '(fill-column 80)
 '(org-agenda-files (quote ("~/org/gtd.org")))
 '(org-capture-templates (quote (("t" "Tasks" entry (file+headline "gtd.org" "Tasks") "* TODO %? %^g
 %^t
 %u") ("j" "Journal" entry (file+datetree "journal.org") "* %u %?"))))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/"))))
 '(python-indent-offset 2)
 '(sql-connection-alist (quote (("applifi" (sql-product (quote postgres)) (sql-user "postgres") (sql-server "localhost") (sql-database "himedia") (sql-port 54322)) ("dwh" (sql-user "dw") (sql-server "localhost") (sql-database "datawarehouse") (sql-port 54323)) ("reporting" (sql-user "postgres") (sql-server "localhost") (sql-database "reporting") (sql-port 54323)) ("tpp" (sql-user "postgres") (sql-server "localhost") (sql-database "tpp") (sql-port 54323)) ("dev-dwh" (sql-user "dw") (sql-server "localhost") (sql-database "datawarehouse_pgeoffroy") (sql-port 54321)) ("dev-tpp" (sql-user "applifi") (sql-server "localhost") (sql-database "tpp") (sql-port 64321)) ("dev-applifi" (sql-user "applifi") (sql-server "localhost") (sql-database "himedia") (sql-port 64321)) ("allopass" (sql-user "postgres") (sql-server "localhost") (sql-database "allopass") (sql-port 54323)))))
 '(sql-postgres-login-params (quote ((user :default "pgeoffroy") (database :default "pgeoffroy") (port :default 54322) server)))
 '(sql-product (quote postgres))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-initialize)
(load-theme 'solarized-dark t)
;(load-theme 'solarized-dark)
;(load-theme 'tango)

; Enlève la barre de menu
(menu-bar-mode -1)
; Enlève la barre d'outil
(tool-bar-mode -1)
; Enlève la barre de défilement
(scroll-bar-mode -1)

; Afficher le numéro de colonne
(column-number-mode 1)
(line-number-mode 1)

; Mettre deux espaces pour l'indentation
(setq tab-width 2) ; or any other preferred value

; Activer la coloration syntaxique
(global-font-lock-mode t)
; Mettre un maximu de couleurs
(setq font-lock-maximum-size nil)

; M-g pour aller à la x-ième ligne
(global-set-key [(meta g)] 'goto-line)

; Mettre tous les fichiers de sauvegarde dans un seul répertoire
(setq backup-directory-alist
'(("." . "~/.emacs-backup-files/")))

; Pour ne pas avoir à taper en entier la réponse yes/no
;(fset 'yes-or-no-p 'y-or-n-p)

;; bépo Bindings
(global-unset-key "\C-x\C-e")
(global-set-key "\C-x\C-e" 'find-file)

;;(global-unset-key "\C-u")
;;(global-set-key (kbd "C-u") 'kill-region)

;;(global-unset-key "\M-u")
;;(global-set-key (kbd "M-u") 'kill-ring-save)

(global-set-key (kbd "C-,") 'keyboard-quit)

(global-set-key (kbd "C-x C-.") 'next-multiframe-window)

(global-unset-key "\C-x\C-u")
(global-set-key (kbd "C-x C-u") 'save-buffer)

(global-unset-key "\C-x\C-c")
(global-set-key (kbd "C-x C-i") 'save-buffers-kill-terminal)


(global-set-key (kbd "C-é") 'backward-char)
(global-set-key (kbd "C-M-é") 'backward-word)

(global-set-key (kbd "C-p") 'next-line)
(global-set-key (kbd "C-M-p") 'forward-paragraph)

(global-unset-key "\C-o")
(global-set-key (kbd "C-o") 'forward-char)
(global-set-key (kbd "C-M-o") 'forward-word)

(global-set-key (kbd "C-»") 'previous-line)
(global-set-key (kbd "C-M-»") 'backward-paragraph)

;;(global-unset-key "\C-g")
;;(global-set-key (kbd "C-,") 'keyboard-quit)

(require 'ido)
(ido-mode t)

(require 'uniquify)

;(require 'fill-column-indicator)
;(define-globalized-minor-mode
; global-fci-mode fci-mode (lambda () (fci-mode 1)))
;(global-fci-mode t)

(setq desktop-restore-eager 20)
(desktop-save-mode 1)
(savehist-mode 1)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

(dolist (mode '(org-mode
		text-mode
		git-commit-mode
                csv-mode
		html-mode
		nxml-mode
		sh-mode
                lisp-mode
		markdown-mode
                js3-mode
		css-mode
		sql-mode
                sql-interactive-mode
                inferior-emacs-lisp-mode))
  (add-to-list 'ac-modes mode))

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode)) ; not needed since Emacs 22.2
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; names the buffer *SQL: <host>_<db>, which is easier to 
;; find when you M-x list-buffers, or C-x C-b
(defun sql-make-smart-buffer-name ()
  "Return a string that can be used to rename a SQLi buffer.
  This is used to set `sql-alternate-buffer-name' within
  `sql-interactive-mode'."
  (or (and (boundp 'sql-name) sql-name)
      (concat (if (and (not(string="" sql-server)) (not(string="localhost" sql-server)))
                  (concat
                   (or (and (string-match "[0-9.]+" sql-server) sql-server)
                       (car (split-string sql-server "\\.")))
                   "/"))
              sql-database)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
            (sql-rename-buffer)))

(show-paren-mode 1)

(add-hook 'prog-mode-hook 'subword-mode)

(set-mouse-color "grey")

; Des numéros de lignes partout !!!!
(global-linum-mode t)

(global-visual-line-mode t)

(setq-default indent-tabs-mode nil)

(set-face-attribute 'default nil :height 80)

;; ORG Mode
(global-set-key (kbd "C-c c") 'org-capture)

