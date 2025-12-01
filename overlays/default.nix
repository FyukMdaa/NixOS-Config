final: prev: {
  
  # niriパッケージを上書きする
  niri = prev.niri.overrideAttrs (oldAttrs: {
    # テストを無効化する
    doCheck = false;
  });
  
}
