class Macup < Formula
  desc "macOS application inventory and update checker"
  homepage "https://github.com/niallrmurphy/macup"
  url "https://github.com/niallrmurphy/macup/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "a40edaadb9615b1a1724ad0b1d3ca255eaab664373a855122b09dcb53f4b1174"
  license "MIT"
  head "https://github.com/niallrmurphy/macup.git", branch: "main"

  bottle do
    root_url "https://github.com/niallrmurphy/homebrew-macup/releases/download/macup-1.0.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "be228f4a34d594cc1e2acc46552b36a3c8bdd6bb8f069718f009b900bb941ce9"
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
