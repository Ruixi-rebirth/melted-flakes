final: prev: {
  cinnamon = prev.cinnamon.overrideScope' (cfinal: cprev: {
    nemo = cprev.nemo.overrideAttrs (old: {
      patches = old.patches ++ [ ./nemo-avoid-segfault.patch ];
    });
  });
}
