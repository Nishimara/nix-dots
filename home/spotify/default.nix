{ inputs, pkgs, ... }: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify.legacyPackages."${pkgs.system}";
  in {
    enable = true;

    spotifyPackage = pkgs.spotify.overrideAttrs (_: {
      postInstall = ''
        # Hide placeholder for ad banner
        ${pkgs.unzip}/bin/unzip -p $out/share/spotify/Apps/xpui.spa xpui.js | sed 's/adsEnabled:\!0/adsEnabled:false/' > $out/share/spotify/Apps/xpui.js
        ${pkgs.zip}/bin/zip --junk-paths --update $out/share/spotify/Apps/xpui.spa $out/share/spotify/Apps/xpui.js
        rm $out/share/spotify/Apps/xpui.js
      '';
    });

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];

    windowManagerPatch = true;

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}