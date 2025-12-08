;;; init.el --- My Emacs Configuration -*- lexical-binding: t -*-

;;; Commentary:
;; NixOS + emacs-overlay環境用の設定
;; Performance & Aesthetics Optimized

;;; Code:

;; ===================================================================
;; パフォーマンス - 起動後の調整
;; ===================================================================

;; GC閾値を戻す（early-init.elで最大化したもの）
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 32 1024 1024)  ; 32MB
                  gc-cons-percentage 0.1)
            ;; ファイル名ハンドラを復元
            (setq file-name-handler-alist my--file-name-handler-alist)))

;; LSPパフォーマンス向上
(setq read-process-output-max (* 1024 1024)) ; 1MB

;; 長い行の最適化 (Emacs 29+)
(when (fboundp 'global-so-long-mode)
  (global-so-long-mode 1))

;; gcmhでGCを管理
(use-package gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 64 1024 1024)) ; 64MB
  :config
  (gcmh-mode 1))

;; ===================================================================
;; システム連携 - Nix / Direnv
;; ===================================================================

;; Direnv管理
(use-package envrc
  :hook (after-init . envrc-global-mode))

;; パス設定（GUI起動時のPATH問題対策）
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns x pgtk))
  :config
  (exec-path-from-shell-initialize))

;; ===================================================================
;; 基本設定
;; ===================================================================

(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq use-short-answers t) ; yes/no -> y/n

;; バックアップファイルを作らない
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; 最近開いたファイルを保存
(use-package recentf
  :init
  (recentf-mode 1)
  :config
  (setq recentf-max-saved-items 200
        recentf-exclude '(".gz" ".xz" ".zip" "/nix/store" "/tmp")))

;; 履歴を保存
(use-package savehist
  :init
  (savehist-mode 1)
  :config
  (setq history-length 1000
        savehist-additional-variables '(kill-ring search-ring regexp-search-ring)))

;; カーソル位置を保存
(use-package saveplace
  :init
  (save-place-mode 1))

;; 行番号と括弧
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type t) ; 相対番号は'relative
(show-paren-mode 1)
(setq show-paren-delay 0.1)

;; スクロールをスムーズに
(setq scroll-conservatively 101
      scroll-margin 2
      scroll-preserve-screen-position t)

;; 行末の空白を保存時に削除
(use-package ws-butler
  :hook (prog-mode . ws-butler-mode))

;; ===================================================================
;; テーマ & フォント
;; ===================================================================

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "PlemolJP Console" :height 120)
  (set-face-attribute 'variable-pitch nil :family "PlemolJP" :height 1.1))

(use-package ef-themes
  :config
  (setq ef-themes-mixed-fonts t
        ef-themes-variable-pitch-ui t
        ef-themes-region '(intense no-extend)
        ef-themes-headings '((1 . (bold 1.3))
                             (2 . (regular 1.2))
                             (t . (regular 1.1))))
  
  ;; 時間帯で自動切り替え（オプション）
  (defun my/apply-theme-by-time ()
    "時間帯に応じてテーマを切り替え"
    (let ((hour (string-to-number (format-time-string "%H"))))
      (if (or (< hour 6) (>= hour 18))
          (load-theme 'ef-owl t)           ; 夜間
        (load-theme 'ef-day t))))          ; 昼間
  
  ;; 手動でテーマを選択したい場合はコメントアウト
  ;; (my/apply-theme-by-time)
  (load-theme 'ef-owl t))

;; ===================================================================
;; UI - モダン化
;; ===================================================================

;; spacious-padding - 余白を追加
(use-package spacious-padding
  :if (display-graphic-p)
  :hook (after-init . spacious-padding-mode)
  :config
  (setq spacious-padding-widths
        '(:internal-border-width 15
          :header-line-width 4
          :mode-line-width 4
          :tab-width 4
          :right-divider-width 1
          :scroll-bar-width 8)))

;; dimmer - 非アクティブウィンドウを暗く
(use-package dimmer
  :if (display-graphic-p)
  :config
  (setq dimmer-fraction 0.3
        dimmer-adjustment-mode :foreground)
  (dimmer-configure-which-key)
  (dimmer-configure-magit)
  (dimmer-mode 1))

(use-package nerd-icons)

;; モデルライン
(use-package nano-modeline
  :if (display-graphic-p)
  :config
  (setq nano-modeline-position 'bottom)
  :hook (after-init . nano-modeline-mode))

;; ===================================================================
;; Dired (ファイラ)
;; ===================================================================

(use-package dired
  :ensure nil
  :hook (dired-mode . dired-hide-details-mode)
  :config
  (setq dired-listing-switches "-alh"
        dired-dwim-target t
        dired-kill-when-opening-new-dired-buffer t
        dired-recursive-copies 'always
        dired-recursive-deletes 'always)
  
  :bind (:map dired-mode-map
              ("C-c C-o" . dired-find-file-other-window)))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind (:map dired-mode-map
              ("H" . dired-hide-dotfiles-mode)))

;; ===================================================================
;; 補完 - Vertico + Consult + Corfu
;; ===================================================================

(use-package vertico
  :init (vertico-mode 1)
  :config
  (setq vertico-cycle t
        vertico-resize nil
        vertico-count 15)
  
  ;; 便利な拡張機能
  (with-eval-after-load 'vertico
    (require 'vertico-directory)
    (require 'vertico-quick))
  
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-l" . vertico-directory-enter)
              ("C-h" . vertico-directory-up)
              ("M-q" . vertico-quick-exit)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package marginalia
  :init (marginalia-mode 1)
  :config
  (setq marginalia-align 'right))

(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g i" . consult-imenu)
         ("M-s l" . consult-line)
         ("M-s r" . consult-ripgrep)
         ("M-s f" . consult-find)
         ("C-c d" . consult-dir)
         ("C-c p f" . consult-project-buffer)
         ("C-c p s" . consult-ripgrep))
  :config
  (setq consult-preview-key 'any
        consult-narrow-key "<"))

(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult))

(use-package wgrep
  :config
  (setq wgrep-auto-save-buffer t))

;; --- Corfu (インライン補完) ---
(use-package corfu
  :init
  (global-corfu-mode 1)
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-delay 0.05
        corfu-auto-prefix 1
        corfu-min-width 20
        corfu-max-width 100
        corfu-preselect 'prompt
        corfu-on-exact-match nil)
  
  ;; TABキーの挙動改善
  (setq tab-always-indent 'complete
        completion-cycle-threshold 3)
  
  ;; ドキュメントをポップアップ表示
  (corfu-popupinfo-mode 1)
  (corfu-history-mode 1)
  
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous)
              ("RET" . corfu-insert)))

;; ターミナルでもCorfuを使う場合
(use-package corfu-terminal
  :unless (display-graphic-p)
  :config (corfu-terminal-mode 1))

(use-package nerd-icons-corfu
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package cape
  :init
  ;; 補完ソースの追加（順序が重要）
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; ===================================================================
;; Git
;; ===================================================================

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-c g s" . magit-status)
         ("C-c g l" . magit-log-current)
         ("C-c g b" . magit-blame))
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package diff-hl
  :hook ((magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :init
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1))

;; ===================================================================
;; プログラミング / LSP
;; ===================================================================

(use-package puni
  :hook (prog-mode . puni-mode)
  :config
  (setq puni-confirm-when-delete-unbalanced-active-region nil))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
         (org-mode . rainbow-mode)))

(use-package hl-todo
  :hook (prog-mode . hl-todo-mode)
  :config
  (setq hl-todo-keyword-faces
        '(("TODO"   . "#FF6C6B")
          ("FIXME"  . "#FF8C00")
          ("NOTE"   . "#98BE65")
          ("HACK"   . "#ECBE7B")
          ("REVIEW" . "#51AFEF"))))

(use-package vundo
  :bind ("C-x u" . vundo)
  :config
  (setq vundo-glyph-alist vundo-unicode-symbols))

(use-package eglot
  :bind (("C-c e a" . eglot-code-actions)
         ("C-c e r" . eglot-rename)
         ("C-c e f" . eglot-format)
         ("C-c e d" . eldoc))
  :hook ((nix-ts-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (go-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t
        eglot-events-buffer-size 0
        eglot-sync-connect nil
        eglot-connect-timeout 30)
  
  ;; パフォーマンス向上: ログを無効化
  (fset #'jsonrpc--log-event #'ignore)
  
  ;; Python: Ruffとの連携
  (add-to-list 'eglot-server-programs
               '(python-ts-mode . ("pyright-langserver" "--stdio"))))

(use-package consult-eglot
  :bind ("C-c e s" . consult-eglot-symbols))

(use-package flycheck
  :init (global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(save mode-enabled)
        flycheck-display-errors-delay 0.3))

(use-package consult-flycheck
  :bind ("C-c ! c" . consult-flycheck))

;; ===================================================================
;; 言語別設定 (Tree-sitter)
;; ===================================================================

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (css-mode . css-ts-mode)
        (json-mode . json-ts-mode)
        (bash-mode . bash-ts-mode)
        (nix-mode . nix-ts-mode)))

;; Web Mode (Tree-sitterでカバーできないテンプレート等)
(use-package web-mode
  :mode ("\\.html?\\'" "\\.erb\\'" "\\.vue\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-enable-auto-pairing t
        web-mode-enable-auto-closing t))

(use-package emmet-mode
  :hook ((web-mode . emmet-mode)
         (tsx-ts-mode . emmet-mode)
         (html-mode . emmet-mode))
  :config
  (setq emmet-move-cursor-between-quotes t))

;; ===================================================================
;; Org Mode
;; ===================================================================

(use-package org
  :config
  (setq org-directory "~/org/"
        org-default-notes-file (concat org-directory "inbox.org")
        org-startup-indented t
        org-hide-emphasis-markers t
        org-pretty-entities t
        org-ellipsis "…"
        org-image-actual-width 400
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-confirm-babel-evaluate nil)
  
  :bind (("C-c c" . org-capture)
         ("C-c a" . org-agenda)))

(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star 'replace
        org-modern-block-name nil
        org-modern-keyword nil
        org-modern-table nil))

(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autoentities t
        org-appear-autokeywords t
        org-appear-autosubmarkers t))

(use-package denote
  :config
  (setq denote-directory (concat org-directory "notes/")
        denote-known-keywords '("emacs" "nix" "dev" "idea" "work")
        denote-prompts '(title keywords))
  :bind (("C-c n n" . denote)
         ("C-c n f" . denote-open-or-create)))

(use-package consult-notes
  :bind ("C-c n s" . consult-notes)
  :config
  (setq consult-notes-denote-files-function #'denote-directory-files))

;; 集中モード
(use-package olivetti
  :bind ("C-c o" . olivetti-mode)
  :config
  (setq olivetti-body-width 0.65))

;; 可変幅フォントの適用 (Orgのみ)
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            (visual-line-mode 1)
            ;; 固定幅が必要な要素はinherit fixed-pitch
            (dolist (face '(org-code org-block org-table org-verbatim 
                           org-link org-date org-tag org-checkbox))
              (set-face-attribute face nil :inherit 'fixed-pitch))))

;; ===================================================================
;; 便利機能
;; ===================================================================

(use-package which-key
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 0.5
        which-key-popup-type 'side-window)
  
  ;; プレフィックスキーの説明
  (which-key-add-key-based-replacements
    "C-c n" "notes"
    "C-c p" "project"
    "C-c g" "git"
    "C-c e" "eglot"
    "C-c t" "toggle"
    "C-x t" "tab"))

;; より良いヘルプ
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)))

;; 検索結果の件数表示
(use-package anzu
  :init (global-anzu-mode +1)
  :config
  (setq anzu-cons-mode-line-p nil))

;; ウィンドウ移動
(global-set-key (kbd "s-<up>") 'windmove-up)
(global-set-key (kbd "s-<down>") 'windmove-down)
(global-set-key (kbd "s-<left>") 'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)

;; 便利なキーバインド
(global-set-key (kbd "C-c i") 'imenu)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c t t") 'treemacs)
(global-set-key (kbd "C-x k") 'kill-current-buffer)

;; ===================================================================
;; 起動時間の測定
;; ===================================================================

(defun my/display-startup-time ()
  "起動時間とGC回数を表示"
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'my/display-startup-time)

;;; init.el ends here
