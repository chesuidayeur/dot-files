
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes, el-get-sources should only accept PLIST element
(setq
 el-get-sources
 '((:name buffer-move                  ; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name magit                        ; git meet emacs, and a binding
	  :after (progn
		   (global-set-key (kbd "C-x C-z") 'magit-status)))))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved			; if you're into php...
   switch-window			; takes over C-x o
   auto-complete
	 color-theme-solarized
	 smex))

;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
;(when (el-get-executable-find "cvs")
;  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs
;
;(when (el-get-executable-find "svn")
;  (loop for p in '(psvn    		; M-x svn-status
;		   yasnippet		; powerful snippet mode
;		   )
;	do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))

;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)



(load-theme 'solarized-dark t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(fci-rule-color "dim gray")
 '(fill-column 80)
 '(js-indent-level 2)
 '(org-agenda-custom-commands
   (quote
    (("n" "Agenda and all TODO's"
      ((agenda "" nil)
       (alltodo "" nil))
      nil)
     ("2" "Perso"
      ((alltodo ""
                ((org-agenda-files
                  (quote
                   ("~/Documents/notes-emacs/projets-perso.org"))))))
      nil nil)
     ("1" "Work Todo"
      ((alltodo ""
                ((org-agenda-files
                  (quote
                   ("~/Documents/notes-emacs/gtd.org"))))))
      nil nil))))
 '(org-agenda-files nil)
 '(org-agenda-window-setup (quote current-window))
 '(org-capture-templates
   (quote
    (("p" "Projet perso" entry
      (file+headline "~/Documents/notes-emacs/projets-perso.org" "Projets perso")
      "* TODO %? %^g
%u")
     ("t" "Tasks" entry
      (file+headline "~/Documents/notes-emacs/gtd.org" "Tasks")
      "* TODO %? %^g
 SCHEDULED: %^t
 %u")
     ("j" "Journal" entry
      (file+datetree "~/Documents/notes-emacs/journal.org")
      "* %u %?"))))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("e6h" . "http://www.e6h.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(python-indent-offset 2)
 '(sh-basic-offset 2)
 '(sql-connection-alist
   (quote
    (("applifi"
      (sql-product
       (quote postgres))
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "himedia")
      (sql-port 54322))
     ("dwh"
      (sql-user "dw")
      (sql-server "localhost")
      (sql-database "datawarehouse")
      (sql-port 54324))
     ("reporting"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "reporting")
      (sql-port 54323))
     ("tpp"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "tpp")
      (sql-port 54323))
     ("dev-dwh"
      (sql-user "dw")
      (sql-server "localhost")
      (sql-database "datawarehouse")
      (sql-port 64321))
     ("dev-tpp"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "tpp")
      (sql-port 64321))
     ("dev-applifi"
      (sql-user "applifi")
      (sql-server "localhost")
      (sql-database "himedia")
      (sql-port 64321))
     ("allopass"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "allopass")
      (sql-port 54323))
     ("hipay"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "hipay")
      (sql-port 54323))
     ("bddtemp"
      (sql-user "postgres")
      (sql-server "localhost")
      (sql-database "tpp")
      (sql-port 54325)))))
 '(sql-postgres-login-params
   (quote
    ((user :default "pgeoffroy")
     (database :default "pgeoffroy")
     (port :default 54322)
     server)))
 '(sql-product (quote postgres))
 '(tab-width 2)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


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
(fset 'yes-or-no-p 'y-or-n-p)

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

;; Use the clipboard, pretty please, so that copy/paste "works"
;(setq x-select-enable-clipboard t)

(global-hl-line-mode)

;; S-fleches pour changer de fenêtre
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)


(require 'ido)
(ido-mode t)

(require 'uniquify)

(setq desktop-restore-eager 20)
(desktop-save-mode 1)
(savehist-mode 1)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(global-auto-complete-mode t)

;(require 'smex) ; Not needed if you use package.el
;(smex-initialize)
;(global-set-key "\M-x" 'smex)
;(global-set-key (kbd "M-X") 'smex-major-mode-commands)

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

;; winner-mode pour revenir sur le layout précédent C-c <left>
(winner-mode 1)

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


(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (and (not (file-exists-p dir))
                           (y-or-n-p (format "Directory %s does not exist. Create it?" dir)))
                  (make-directory dir t))))))
