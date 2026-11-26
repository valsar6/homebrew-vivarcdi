cask "vivarcdi" do
  version "0.73.1"
  sha256 "2326d0009b7d548901a951459ad763cfda0c2b73624ae5c63f2750e2848ee5bb"

  url "https://github.com/valsar6/VivArcDi/releases/download/v#{version}/VivArcDi-#{version}.dmg"
  name "VivArcDi"
  desc "Make Vivaldi behave like Arc"
  homepage "https://github.com/valsar6/VivArcDi"

  depends_on :macos

  app "VivArcDi.app"

  uninstall launchctl: "io.github.valsar6.vivarcdi.reapply",
            delete:    "~/Library/LaunchAgents/io.github.valsar6.vivarcdi.reapply.plist"

  zap trash: [
    "~/Library/Application Support/VivArcDi/logs",
    "~/Library/Application Support/VivArcDi/managed-by",
    "~/Library/Application Support/VivArcDi/release-check.json",
  ]

  caveats <<~EOS
    The first time, macOS says it cannot verify VivArcDi, because the app is free and not notarized
    by Apple. Open System Settings > Privacy & Security, scroll down to the message about VivArcDi,
    click Open Anyway and confirm. Then open VivArcDi and click Install.

    macOS asks for the App Management permission again after each update, because the app is
    ad-hoc signed. If VivArcDi says macOS did not let it change Vivaldi, turn VivArcDi on in System
    Settings > Privacy & Security > App Management and click Try again.

    Before you run brew uninstall, click Uninstall in the VivArcDi app, so that Vivaldi is restored.
    brew uninstall removes the app and its background agent, but does not change Vivaldi.
  EOS
end
