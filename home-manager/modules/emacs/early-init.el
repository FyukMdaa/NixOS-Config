;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:
;; Emacs 27+で起動プロセスの一番最初に読み込まれる設定。
;; GUI描画前の最適化を行う。

;;; Code:

;; ===================================================================
;; パフォーマンス最適化
;; ===================================================================

;; GC閾値を一時的に最大化（起動高速化）
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1.0)

;; ファイル名ハンドラを一時的に無効化
(defvar my--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; サイトlispの読み込みを抑制（Nixで管理するため不要）
(setq package-enable-at-startup nil
      package-quickstart nil)

;; ===================================================================
;; UI要素の削除（フレーム生成前に設定）
;; ===================================================================

;; メニューバー、ツールバー、スクロールバーを無効化
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(horizontal-scroll-bars) default-frame-alist)

;; 起動時の画面設定
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name
      initial-scratch-message nil)

;; タイトルバーをシンプルに
(setq frame-title-format '("%b - Emacs"))

;; ===================================================================
;; ネイティブコンパイル設定
;; ===================================================================

(when (native-comp-available-p)
  ;; 警告を抑制（Nixビルド時に処理されることが多いため）
  (setq native-comp-async-report-warnings-errors nil
        native-comp-warning-on-missing-source nil
        ;; コンパイル最適化
        native-comp-speed 2           ; バランス重視 (0=最速コンパイル, 3=最大最適化)
        native-comp-async-jobs 4))    ; 並列コンパイル数

;; ===================================================================
;; レイアウト最適化（Emacs 29+）
;; ===================================================================

(when (fboundp 'startup-redirect-eln-cache)
  (startup-redirect-eln-cache
   (convert-standard-filename
    (expand-file-name "var/eln-cache/" user-emacs-directory))))

;;; early-init.el ends here
