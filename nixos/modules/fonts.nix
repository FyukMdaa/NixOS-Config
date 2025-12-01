{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # 日本語フォント
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      
      # プログラミングフォント
      plemoljp-nf
      hackgen-nf-font
      moralerspace-hw
      
      # アイコンフォント
      font-awesome
    ];
    
    fontDir.enable = true;
    
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "Noto Serif CJK JP"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "Noto Sans CJK JP"
          "Noto Color Emoji"
        ];
        monospace = [
          "PlemolJP Console NF"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
