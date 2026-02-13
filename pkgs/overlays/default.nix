final: prev: {
  # niriパッケージを上書きする
  niri = prev.niri.overrideAttrs (_oldAttrs: {
    # テストを無効化する
    doCheck = false;
  });

  # fcitx5-skkを拡張辞書対応にする
  fcitx5-skk = prev.fcitx5-skk.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
              echo "Patching fcitx5-skk dictionary_list for extended dictionaries..."

              dict_list="$out/share/fcitx5/skk/dictionary_list"

              if [ -f "$dict_list" ]; then
                # 既存の dictionary_list をバックアップ
                cp "$dict_list" "$dict_list.orig"

                # 新しい dictionary_list を作成（拡張辞書を追加）
                cat > "$dict_list" << EOF
        type=file,file=\$FCITX_CONFIG_DIR/skk/user.dict,mode=readwrite
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.L,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.jawiki,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.hukugougo,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.requested,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.assoc,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.fullname,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.edict2,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.geo,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.idiom,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.jinmei,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.propernoun,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.station,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.wrong,mode=readonly
        type-file,file=${final.skk-dicts-extended}/share/skk/SKK-JISYO.website,mode=readonly

        EOF

                echo "Updated dictionary_list:"
                cat "$dict_list"
              else
                echo "Warning: dictionary_list not found at $dict_list"
              fi
      '';
  });
}
