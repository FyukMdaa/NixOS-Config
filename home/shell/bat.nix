{...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
      style = "plain";
      pager = "less -FR";
    };
  };
}
