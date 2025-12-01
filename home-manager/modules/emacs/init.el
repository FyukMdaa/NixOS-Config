;;; init.el --- My Emacs Configuration -*- lexical-binding: t -*-

;;; Commentary:
;; NixOS + emacs-overlay環境用の設定
;; 最高にアガる構成を目指す

;;; Code:

;; ===================================================================
;; パフォーマンス - 起動後の調整
;; ===================================================================

;; GC閾値を戻す（early-init.elで最大化したもの）
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)  ; 16MB
                  gc-cons-percentage 0.1)
            ;; ファイル名ハンドラを戻す
            (setq file-name-handler-alist my--file-name-handler-alist)))

;; gcmhでGCを賢く管理
(use-package gcmh
  :init
  (setq gcmh-idle-delay 5
        gcmh-high-cons-threshold (* 16 1024 1024))
  :demand t
  :config
  (gcmh-mode 1))

;; ===================================================================
;; 基本設定
;; ===================================================================

;; UTF-8を標準に
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; yes/noをy/nに
(defalias 'yes-or-no-p 'y-or-n-p)

;; 行番号表示
(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'absolute)

;; 対応する括弧をハイライト
(show-paren-mode 1)

;; バックアップファイルを作らない
(setq make-backup-files nil
      auto-save-default nil
      create-lockfiles nil)

;; 最近開いたファイルを保存
(recentf-mode 1)
(setq recentf-max-saved-items 100)

;; スクロール設定
(setq scroll-conservatively 100
      scroll-margin 3)

;; ===================================================================
;; フォント設定 - PlemolJP
;; ===================================================================

(when (display-graphic-p)
  (set-face-attribute 'default nil
                      :family "PlemolJP Console"
                      :height 120)
  
  ;; 可変幅フォント（org-modeの見出し用）
  (set-face-attribute 'variable-pitch nil
                      :family "PlemolJP"
                      :height 1.0))

;; ===================================================================
;; テーマ - ef-themes
;; ===================================================================

(use-package ef-themes
  :config
  ;; 設定
  (setq ef-themes-mixed-fonts t
        ef-themes-variable-pitch-ui t)
  
  ;; テーマ読み込み
  (load-theme 'ef-owl t))

;; ===================================================================
;; UI - 視覚的な心地よさ
;; ===================================================================

;; spacious-padding - 余白で呼吸感
(use-package spacious-padding
  :if (display-graphic-p)
  :demand t
  :config
  (setq spacious-padding-widths
        '(:internal-border-width 15
          :header-line-width 4
          :mode-line-width 6
          :tab-width 4
          :right-divider-width 30
          :scroll-bar-width 8))
  (spacious-padding-mode 1))

;; dimmer - 非アクティブバッファを暗く
(use-package dimmer
  :if (display-graphic-p)
  :demand t
  :config
  (setq dimmer-fraction 0.4)
  
  ;; 特定バッファは暗くしない
  (setq dimmer-exclusion-regexp-list
        '("^ \\*Minibuf-[0-9]+\\*$"
          "^ \\*Echo.*\\*$"
          "^\\*treemacs.*\\*$"))
  
  (dimmer-mode 1))

;; nerd-icons - アイコン基盤
(use-package nerd-icons)

;; ===================================================================
;; モードライン
;; ===================================================================

;; nano-modeline - 上部
(use-package nano-modeline
  :if (display-graphic-p)
  :demand t
  :config
  (setq nano-modeline-position 'top)
  (nano-modeline-mode 1))

;; moody - 下部（タブ風）
(use-package moody
  :if (display-graphic-p)
  :demand t
  :config
  (setq moody-mode-line-height 30)
  (moody-replace-mode-line-buffer-identification)
  (moody-replace-vc-mode))

;; minions - マイナーモード折りたたみ
(use-package minions
  :demand t
  :config
  (minions-mode 1))

;; mlscroll - スクロール位置表示
(use-package mlscroll
  :demand t
  :config
  (mlscroll-mode 1))

;; ===================================================================
;; Git
;; ===================================================================

;; magit - Git操作
(use-package magit
  :bind ("C-x g" . magit-status))

;; diff-hl - 差分表示
(use-package diff-hl
  :config
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1)
  
  ;; magit連携
  (add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

;; ===================================================================
;; 補完 - Vertico + Consult + Corfu
;; ===================================================================

;; vertico - ミニバッファ補完UI
(use-package vertico
  :init
  (vertico-mode 1)
  :config
  (setq vertico-cycle t))

;; orderless - 曖昧検索
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; marginalia - 補完候補に注釈
(use-package marginalia
  :init
  (marginalia-mode 1))

;; consult - 強化された検索
(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-x 4 b" . consult-buffer-other-window)
         ("C-x r b" . consult-bookmark)
         ("M-y" . consult-yank-pop)
         ("M-g g" . consult-goto-line)
         ("M-g M-g" . consult-goto-line)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)))

;; embark - 補完候補にアクション
(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings)))

;; embark-consult連携
(use-package embark-consult
  :after (embark consult))

;; corfu - インライン補完
(use-package corfu
  :init
  (global-corfu-mode 1)
  :config
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 2
        corfu-quit-no-match 'separator))

;; cape - Corfu用補完ソース
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

;; kind-icon - Corfu候補にアイコン
(use-package kind-icon
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; which-key - キーバインド可視化
(use-package which-key
  :config
  (setq which-key-idle-delay 0.5)
  (which-key-mode 1))

;; ===================================================================
;; 編集
;; ===================================================================

;; puni - 構造的編集
(use-package puni
  :config
  (puni-global-mode 1))

;; rainbow-delimiters - 括弧色分け
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; vundo - ビジュアルアンドゥツリー
(use-package vundo
  :bind ("C-x u" . vundo))

;; visual-regexp - 正規表現プレビュー
(use-package visual-regexp
  :bind (("C-c r" . vr/replace)
         ("C-c q" . vr/query-replace)))

;; avy - 画面内ジャンプ
(use-package avy
  :bind (("C-:" . avy-goto-char)
         ("C-'" . avy-goto-char-2)
         ("M-g w" . avy-goto-word-1)
         ("M-g l" . avy-goto-line)))

;; expand-region - 選択範囲拡大
(use-package expand-region
  :bind ("C-=" . er/expand-region))

;; ===================================================================
;; プロジェクト管理
;; ===================================================================

;; project.el - 標準プロジェクト管理
(use-package project
  :bind-keymap ("C-x p" . project-prefix-map))

;; treemacs - サイドバーツリー（Desktopのみ推奨）
(use-package treemacs
  :if (display-graphic-p)
  :bind (("C-x t t" . treemacs)))

;; treemacs-nerd-icons連携
(use-package treemacs-nerd-icons  
  :after treemacs
  :config
  (treemacs-load-theme "nerd-icons"))

;; ===================================================================
;; LSP - eglot
;; ===================================================================

(use-package eglot
  :hook ((nix-ts-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure))
  :config
  (setq eglot-autoshutdown t
        eglot-sync-connect nil))

;; eldoc-box - eldocをポップアップ表示
(use-package eldoc-box
  :if (display-graphic-p)
  :after eglot
  :config
  (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-at-point-mode))

;; ===================================================================
;; org-mode
;; ===================================================================

(use-package org
  :config
  ;; ディレクトリ設定
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/inbox.org")
  
  ;; 見た目
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(400))
  
  ;; リンク
  (setq org-return-follows-link t)
  
  ;; ID管理（モバイル連携用）
  (require 'org-id)
  (setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id)
  
  ;; シンプルな記法（Orgro互換性）
  (setq org-use-sub-superscripts '{})
  (setq org-pretty-entities nil))

;; org-modern - 見た目モダン化
(use-package org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star 'replace
        org-modern-table-vertical 1
        org-modern-table-horizontal 0.2
        org-modern-checkbox
        '((88 . "☑")
          (45 . "□")
          (32 . "☐"))))

;; org-appear - リンク編集体験向上
(use-package org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autolinks t
        org-appear-autosubmarkers t
        org-appear-autoentities t))

;; denote - ノート管理
(use-package denote
  :config
  (setq denote-directory "~/org/notes/"
        denote-file-type 'org
        denote-date-format "%Y%m%dT%H%M%S"
        denote-known-keywords '("emacs" "nix" "python" "web" "idea")
        denote-backlinks-show-context t)
  :bind (("C-c n n" . denote)
         ("C-c n f" . denote-open-or-create)
         ("C-c n l" . denote-link-or-create)
         ("C-c n b" . denote-backlinks)))

;; consult-notes - denote検索強化
(use-package consult-notes
  :after (consult denote)
  :bind ("C-c n s" . consult-notes)
  :config
  (setq consult-notes-denote-files-function #'denote-directory-files))

;; olivetti - 集中執筆モード
(use-package olivetti
  :bind ("C-c o" . olivetti-mode)
  :config
  (setq olivetti-body-width 100))

;; org-modeで可変幅フォント（見出しを読みやすく）
(add-hook 'org-mode-hook
          (lambda ()
            (variable-pitch-mode 1)
            (setq line-spacing 0.2)
            ;; コードブロックは等幅に戻す
            (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
            (set-face-attribute 'org-code nil :inherit 'fixed-pitch)
            (set-face-attribute 'org-table nil :inherit 'fixed-pitch)))

;; ===================================================================
;; 言語別設定
;; ===================================================================

;; tree-sitterモード自動有効化
(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (typescript-mode . typescript-ts-mode)
        (js-mode . js-ts-mode)
        (css-mode . css-ts-mode)
        (json-mode . json-ts-mode)))

;; Nix
(use-package nix-mode
  :mode "\\.nix\\'")

;; Python
(add-hook 'python-ts-mode-hook
          (lambda ()
            (setq python-indent-offset 4)))

;; Web開発
(use-package web-mode
  :mode ("\\.html?\\'" "\\.jsx?\\'")
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2))

;; emmet - HTML/JSX省略記法
(use-package emmet-mode
  :hook ((web-mode . emmet-mode)
         (tsx-ts-mode . emmet-mode)))

;; ===================================================================
;; Emacs Lisp開発支援
;; ===================================================================

;; macrostep - マクロ展開
(use-package macrostep
  :bind (:map emacs-lisp-mode-map
              ("C-c e" . macrostep-expand)))

;; elisp-demos - 関数サンプル表示
(use-package elisp-demos  
  :config
  (advice-add 'describe-function-1 :after #'elisp-demos-advice-describe-function-1))

;; highlight-defined - 定義済みシンボルハイライト
(use-package highlight-defined
  :hook (emacs-lisp-mode . highlight-defined-mode))

;; ===================================================================
;; キーバインド追加
;; ===================================================================

;; ウィンドウ移動を簡単に
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; バッファを簡単に削除
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; ===================================================================
;; 起動時メッセージ
;; ===================================================================

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

;;; init.el ends here
