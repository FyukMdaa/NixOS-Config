_final: prev: {
  # niriパッケージを上書きする
  niri = prev.niri.overrideAttrs (_oldAttrs: {
    # テストを無効化する
    doCheck = false;
  });
}
