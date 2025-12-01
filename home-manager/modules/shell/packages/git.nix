{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "FyukMdaa";
      user.email = "mdaatiu@outlook.com";    
      init.defaultBranch = "main";
      core.editor = "micro";
      pull.rebase = false;
      push.autoSetupRemote = true;
      aliases = {
       st = "status";
       co = "checkout";
       br = "branch";
       ci = "commit";
       unstage = "reset HEAD --";
       last = "log -1 HEAD";
       lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      };
    };
  };
}
