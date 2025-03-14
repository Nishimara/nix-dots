{ pkgs, inputs, ...}:
let
  lock = Value: {
    inherit Value;
    Status = "locked";
  };
  profile-name = "alpha";
in {
  programs.firefox = {
    package = pkgs.firefox.override {
      extraPolicies = {
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableTelemetry = true;
        DisableForgetButton = true;
        DisableFirefoxStudies = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DNSOverHTTPS = {
          Value = true;
          ProviderURL = "https://1.1.1.1";
          Status = "locked";
        };
        EnableTrackingProtection = {
          Value = true;
          Status = "locked";
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisplayBookmarksToolbar = "never";
        SearchBar = "unified";
        NoDefaultBookmarks = true;
        NetworkPrediction = false;
        CaptivePortal = false;
        ExtensionUpdate = false;

        ExtensionSettings = {
          "dark-theme@mozilla.org" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-theme/addon-10668-latest.xpi";
            enabled = true;
          };
        };

        Preferences = {
          "browser.aboutConfig.showWarning" = lock false;
          "browser.cache.offline.enable" = lock false; # false cuz may be used for fingreprinting
          "browser.crashReports.unsubmittedCheck.autoSubmit" = lock false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = lock false;
          "browser.crashReports.unsubmittedCheck.enabled" = lock false;
          "browser.disableResetPrompt" = lock true;
          "browser.download.useDownloadDir" = lock false; # ask user each time where to save downloaded files
          "browser.newtab.preload" = lock false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock false;
          "browser.newtabpage.enchaced" = lock false;
          "browser.newtabpage.introShown" = lock true;
          "browser.safebrowsing.appRepURL" = lock "";
          "browser.safebrowsing.blockedURIs.enabled" = lock false;
          "browser.safebrowsing.downloads.enabled" = lock false;
          "browser.safebrowsing.downloads.remote.enabled" = lock false;
          "browser.safebrowsing.downloads.remote.url" = lock "";
          "browser.safebrowsing.enabled" = lock false;
          "browser.safebrowsing.malware.enabled" = lock false;
          "browser.safebrowsing.phishing.enalbed" = lock false;
          "browser.selfsupport.url" = lock "";
          "browser.send_pings" = lock false;
          "browser.sessionstore.privacy_level" = lock 0;
          "browser.startup.homepage_override.mstone" = lock "ignore";
          "browser.tabs.crashReporting.sendReport" = lock false;
          "browser.urlbar.groupLabels.enabled" = lock false;
          "browser.urlbar.quicksuggest.enabled" = lock false;
          "browser.urlbar.speculativeConnect.enabled" = lock false;
          "browser.urlbar.trimURLs" = lock false;
          "datareporting.policy.dataSubmissionEnabled" = lock false;
          "dom.battery.enabled" = lock false;
          "dom.event.clipboardevents.enabled" = lock false;
          "dom.security.https_only_mode" = lock true;
          "dom.security.https_only_mode_ever_enabled" = lock true;
          "dom.webaudio.enabled" = lock false;
          "media.autoplay.default" = lock 1; # 0 for allow and 2 for asking a user on each site
          "media.eme.enabled" = lock false; #drm
          "media.gmp-widevinecdm.enabled" = lock false; #drm
          "media.navigator.enabled" = lock false;
          "media.peerconnection.enabled" = lock false;
          "media.video_stats.enabled" = lock false;
          "network.allow-experiments" = lock false;
          "network.captive-portal-service.enabled" = lock false;
          "network.cookie.cookieBehavior" = lock 1;
          "network.dns.disablePrefetch" = lock true;
          "network.dns.disablePrefetchFromHTTPS" = lock true;
          "network.http.referer.spoofSource" = lock true;
          "network.http.speculative-parallel-limit" = lock 0;
          "network.predictor.enable-prefetch" = lock 0;
          "network.predictor.enabled" = lock false;
          "network.prefetch-next" = lock false;
          "network.trr.custom_uri" = lock "https://1.1.1.1";
          "network.trr.mode" = lock 2;
          "pdfjs.enableScripting" = lock false;
          "signon.autofillForms" = lock false;
          "browser.urlbar.suggest.searches" = lock false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock false;
          "browser.newtabpage.activity-stream.showSponsored" = lock false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock false;
          "extensions.pocket.enabled" = lock false;
          "extensions.screenshots.disabled" = lock true;
      
          # needed for custom css
          "toolkit.legacyUserProfileCustomizations.stylesheets" = lock true;
        };
      };

      # set some prefs here cuz firefox cannot handle this preferences
      extraPrefs = /* javascript */ ''
        lockPref("app.update.auto", false);
        lockPref("app.normandy.api_url", "");
        lockPref("app.normandy.enabled", false);
        lockPref("app.shield.optoutstudies", false);
        lockPref("beacon.enabled", false);
        lockPref("breakpad.reportURL", "");
        lockPref("datareporting.healthreport.service.enabled", false);
        lockPref("datareporting.healthreport.uploadEnabled", false);
        lockPref("device.sensors.motion.enabled", false);
        lockPref("device.sensors.enabled", false);
        lockPref("device.sensors.ambientLight", false);
        lockPref("device.sensors.orientation.enabled", false);
        lockPref("device.sensors.proximity.enabled", false);
        lockPref("experiments.activeExperiment", false);
        lockPref("experiments.enabled", false);
        lockPref("experiments.manifest.uri", "");
        lockPref("experiments.supported", false);
        lockPref("privacy.donottrackheader.enabled", true);
        lockPref("privacy.donottrackheader.value", 1);
        lockPref("privacy.query_stripping", true);
        lockPref("privacy.usercontext.about_new_tab_segregation.enabled", true);
        lockPref("security.ssl.disable_session_identifiers", true);
        lockPref("services.sync.nextSync", 0);
        lockPref("toolkit.telemetry.archive.enabled", false);
        lockPref("toolkit.telemetry.bhrPing.enabled", false);
        lockPref("toolkit.telemetry.cachedClientID", "");
        lockPref("toolkit.telemetry.enabled", false);
        lockPref("toolkit.telemetry.firstShutdownPing", false);
        lockPref("toolkit.telemetry.hybridContent.enabled", false);
        lockPref("toolkit.telemetry.newProfilePing.enabled", false);
        lockPref("toolkit.telemetry.prompted", 2);
        lockPref("toolkit.telemetry.rejected", true);
        lockPref("toolkit.telemetry.reportingpolicy.firstRun", false);
        lockPref("toolkit.telemetry.server", "");
        lockPref("toolkit.telemetry.shutdownPingSender.enabled", false);
        lockPref("toolkit.telemetry.unified", false);
        lockPref("toolkit.telemetry.unifiedOptIn", false);
        lockPref("toolkit.telemetry.updatePing.enabled", false);
      '';
#       lockPref("webgl.disabled", true);
#       lockPref("webgl.renderer-string-override", "");
#       lockPref("webgl.vendor-string-override", "");
#     '';
    };

    enable = true;

    profiles.${profile-name} = {
      id = 0;
      isDefault = true;
      extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
        # all the exts can be found there
        # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json?ref_type=heads

        clearurls
        darkreader
        dearrow
        istilldontcareaboutcookies
        ublock-origin
        seventv
        sponsorblock
        user-agent-string-switcher
        violentmonkey

        # missed:
        # * foxyproxy
        # * standart mozilla dark theme
      ];

      userContent = ''
        @-moz-document url-prefix("about:newtab"), url-prefix("about:home") {
            /* makes Support and Release Note invincible */
            .releasenote {
                color: #ffffff00 !important;
            }

            body {
                background: url(${../../imgs/firefox-wp.jpg}) !important; background-size: cover !important;
            }
        }
      '';

      userChrome = ''
        /* fuck webrtc duh */
        #webrtcIndicator {
            display: none;
        }

        /* disable flashbang during page loading */
        #tabbrowser-tabpanels,
        #browser vbox#appcontent tabbrowser,
        #content,
        browser[type="content-primary"],
        browser[type="content"] > html {
            background-color: -moz-Dialog !important;
        }
      '';

      search = {
        default = "DuckDuckGo";
        force = true;
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
                { name = "channel"; value = "unstable"; }
              ];
            }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAlias = [ "@np" ];
          };

          "MyNixOS" = {
            urls = [{
              template = "https://mynixos.com/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            # icon = "";
            definedAlias = [ "@mn" ];
          };

          "Google".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };
    };
  };
}