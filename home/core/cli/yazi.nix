{pkgs, ...}: {
  # NOTE: Default keybinding are here: https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/keymap.toml
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    plugins = with pkgs.yaziPlugins; {
      git = git;
      piper = piper;
      ouch = ouch;
      rich-preview = rich-preview;
      jump-to-char = jump-to-char;
      mount = mount;
      restore = restore;
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "s";
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = "C";
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
      ];
    };
  };

  # aliases
  home.shellAliases = {
    y = "yazi";
  };
}
