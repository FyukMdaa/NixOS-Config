{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.fyukmdaa.emacs;
  isAndroid = pkgs.stdenv.hostPlatform.isAndroid;
in {
  options.fyukmdaa.emacs = {
    enable = mkEnableOption "A highly optimized Emacs configuration";
    package = mkOption {
      type = types.package;
      default = if isAndroid 
                then pkgs.emacs-nox  # モバイルはターミナル版
                else pkgs.emacs-pgtk; # デスクトップはPGTK + ネイティブコンパイル版
      description = "The Emacs package to use.";
    };
  };

  config = mkIf cfg.enable {
    # programs.emacsはhome-managerが提供するモジュール
    programs.emacs = {
      enable = true;
      inherit (cfg) package;
      
      # Nix側で管理するパッケージを定義
      extraPackages = epkgs: (import ./packages.nix { inherit epkgs lib isAndroid; });
      
      # early-init.elとinit.elをシンボリックリンク
      extraConfig = ''
        ;; Load early-init.el
        (load-file "${./early-init.el}")
        ;; Load init.el
        (load-file "${./init.el}")
      '';
    };

    # デスクトップ環境の場合のみ必要なシステムパッケージをインストール
    home.packages = with pkgs; mkIf (!isAndroid) [
      # LSP Servers & Formatters
      nil                                          # Nix LSP
      nixpkgs-fmt                                  # Nix formatter
      pyright                                      # Python LSP
      ruff                                         # Python linter/formatter
      nodePackages.typescript-language-server      # TypeScript/JavaScript
      nodePackages.vscode-langservers-extracted    # HTML/CSS/JSON
      nodePackages."@tailwindcss/language-server"  # Tailwind CSS
      nodePackages.prettier                        # Formatter
      
      # Utilities
      ripgrep                                      # 高速grep
      fd                                           # 高速find
      git                                          # バージョン管理
      
      # Fonts
      plemoljp                                     # PlemolJP Console
    ];
  };
}
