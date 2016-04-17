class SignalDesktop < Formula
  desc "Signal Messenger Desktop App"
  homepage "https://whispersystems.org/"
  url "https://github.com/WhisperSystems/Signal-Desktop.git"
  head "https://github.com/WhisperSystems/Signal-Desktop.git"
  version "0.1.0"

  resource "nwjs" do
    url "http://dl.nwjs.io/v0.13.0-beta3/nwjs-sdk-v0.13.0-beta3-osx-x64.zip"
    sha256 "3c9b8ab7724a7d22830ef3e8199ad14e76c72387d2bed34bd8cf2e538ea9d8b4"
  end

  depends_on "node"

  def install
    resource("nwjs").stage do
      system "cp", "-r", "nwjs.app", "#{prefix}/Signal Desktop.app"
    end

    ENV.prepend_path "PATH", "#{Formula["node"].opt_libexec}/npm/bin"
    system "npm", "install"
    system "node_modules/grunt-cli/bin/grunt --force"
    system "cp", "-r", "dist", "#{prefix}/Signal Desktop.app/Contents/Resources/app.nw"
    ln_s "#{prefix}/Signal Desktop.app", "/Applications/Signal Desktop.app"
  end
end
