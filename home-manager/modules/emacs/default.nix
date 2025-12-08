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
                then pkgs.emacs-nox # モバイル
                else pkgs.emacs-pgtk; # PGTK版 (Wayland/X11両対応)
      description = "The Emacs package to use.";
    };
    enableDaemon = mkOption {
      type = types.bool;
      default = !isAndroid;
      description = "Enable Emacs daemon for faster startup.";
    };
  };

  config = mkIf cfg.enable {
    # 1. Emacs本体とinit.elの設定
    programs.emacs = {
      enable = true;
      inherit (cfg) package;
      
      # Nixで管理するElispパッケージ
      extraPackages = epkgs: (import ./packages.nix { inherit epkgs lib isAndroid; });
      
      # init.el
      extraConfig = builtins.readFile ./init.el;
    };

    # 2. early-init.el は XDG設定ディレクトリに直接配置
    xdg.configFile."emacs/early-init.el".source = ./early-init.el;

    # 3. カスタムスニペット・設定ファイル
    # xdg.configFile."emacs/snippets".source = ./snippets;

    # 4. システムパッケージ (LSP, ツール類)
    home.packages = with pkgs; mkIf (!isAndroid) [
      # Core Tools
      ripgrep
      fd
      git
      direnv

      # Spell Check
      (aspellWithDicts (dicts: with dicts; [ en en-computers en-science ]))

      # Fonts
      plemoljp

      # Language Servers & Formatters
      nil                                          # Nix
      nixpkgs-fmt
      pyright                                      # Python
      ruff                                         # Python linter/formatter
      nodePackages.typescript-language-server      # TS/JS
      nodePackages.vscode-langservers-extracted    # HTML/CSS/JSON
      nodePackages."@tailwindcss/language-server"  # Tailwind
      nodePackages.prettier                        # General Formatter
      gopls                                        # Go
      rust-analyzer                                # Rust
      
      # Optional: Formatters
      shfmt                                        # Shell script formatter
      nodePackages.stylelint                       # CSS linter
    ];

    # 5. 環境変数設定
    home.sessionVariables = mkIf (!isAndroid) {
      EDITOR = "emacsclient -c";
      VISUAL = "emacsclient -c";
    };

    # 6. Emacsデーモンの有効化 (高速起動)
    services.emacs = mkIf (cfg.enableDaemon && !isAndroid) {
      enable = true;
      client.enable = true;
      startWithUserSession = true;
      socketActivation.enable = true;
    };
  };
}
