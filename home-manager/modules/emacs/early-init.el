;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:
;; Emacs 27+で起動前に読み込まれる設定
;; パフォーマンス最適化とUI要素の削除

;;; Code:

;; ===================================================================
;; パフォーマンス最適化
;; ===================================================================

;; GC閾値を一時的に最大化（起動高速化）
;; init.el読み込み後に元に戻す
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; ファイル名ハンドラを一時的に無効化
(defvar my--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; ===================================================================
;; UI要素の削除（描画前に実行）
;; ===================================================================

;; メニューバー、ツールバー、スクロールバーを無効化
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; 起動時のメッセージを非表示
(setq inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message user-login-name)

;; 初期スクラッチメッセージを空に
(setq initial-scratch-message nil)

;; ===================================================================
;; package.el無効化（use-packageのみ使用）
;; ===================================================================

(setq package-enable-at-startup nil)

;; ===================================================================
;; ネイティブコンパイルの警告を抑制
;; ===================================================================

(setq native-comp-async-report-warnings-errors nil)
(setq native-comp-warning-on-missing-source nil)

;;; early-init.el ends here
