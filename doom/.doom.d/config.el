;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; this controls the color of bold, italic, underline, verbatim, strikethrough
(setq company-global-modes '(not org-mode))

(setq org-emphasis-alist
  '(("*" (bold :background "dark grey" :foreground "black" ))
    ("/" (italic :background "sky blue" :foreground "black" ))
    ("_" (underline))
    ("=" (:background "dark salmon" :foreground "black" ))
    ("~" (:background "DarkGreen" :foreground "white" ))
    ("+" (:strike-through nil :background "firebrick" :foreground "black" ))))
(setq org-hide-emphasis-markers t)

(defun my-highlight ()
    (highlight-regexp "(.*?)" 'dired-ignored)
    (highlight-regexp "-" 'hi-blue-b)
    (highlight-regexp ":" 'hi-blue-b)
    (highlight-regexp "!=" 'hi-blue-b)
    (highlight-regexp "->" 'hi-blue-b)
    (highlight-regexp ":.*$" 'org-code)
    (highlight-regexp "- .*? [:\\|(]" 'warning))
(add-hook 'org-mode-hook 'my-highlight)

(setq hi-lock-file-patterns-policy (lambda (pattern) t))
(add-hook 'org-mode-hook 'hi-lock-mode)

(defun set-bidi-env ()
  "interactive"
  (setq bidi-paragraph-direction 'nil))
(add-hook 'org-mode-hook 'set-bidi-env)

;; hides the emphasis markers
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;;(setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:

(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 15 :weight 'semi-light))

(set-fontset-font t 'arabic "Noto Naskh Arabic")
    (setq face-font-rescale-alist
         '(
           (".*Noto Naskh Arabic.*" . 1.7)))

(setq-default default-input-method "arabic")

(global-unset-key (kbd "M-SPC"))
(global-set-key (kbd "M-SPC") 'toggle-input-method)

(define-key global-map (kbd "C-h") 'windmove-left)
(define-key global-map (kbd "C-l") 'windmove-right)
(define-key global-map (kbd "C-j") 'windmove-down)
(define-key global-map (kbd "C-k") 'windmove-up)

(define-key global-map (kbd "C-M-h") 'buf-move-left)
(define-key global-map (kbd "C-M-l") 'buf-move-right)
(define-key global-map (kbd "C-M-j") 'buf-move-down)
(define-key global-map (kbd "C-M-k") 'buf-move-up)

;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

(after! doom-theme
  (remove-hook 'doom-load-theme-hook #'doom-themes-neotree-config))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
