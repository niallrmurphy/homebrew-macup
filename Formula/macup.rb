class Macup < Formula
  desc "macOS application inventory and update checker"
  homepage "https://github.com/niallrmurphy/macup"
  url "https://github.com/niallrmurphy/macup/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "149ee4a63ccce493bfed869bcedb46697fce41b53146e080e3103dc597975922"
  license "MIT"
  head "https://github.com/niallrmurphy/macup.git", branch: "main"

  bottle do
    root_url "https://github.com/niallrmurphy/homebrew-macup/releases/download/macup-1.0.2_1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "198d19fd02e627a526d570a62aa74cb6eed4f93fd2e1a12e6b091dda265c392e"
  end

  depends_on "go" => :build
  depends_on :macos

  def install
    ldflags = "-s -w -X main.version=#{version} -X main.commit=homebrew -X main.date=#{time.strftime("%Y-%m-%d")}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/macup"
  end

  test do
    assert_match "macup #{version}", shell_output("#{bin}/macup version")
    assert_match "SOURCE", shell_output("#{bin}/macup scan --offline --apps --roots #{testpath} --quiet")
  end
end
