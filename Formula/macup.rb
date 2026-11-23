class Macup < Formula
  desc "macOS application inventory and update checker"
  homepage "https://github.com/niallrmurphy/macup"
  url "https://github.com/niallrmurphy/macup/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "e6b327bbdd0212e9c9b75108996ece11b12216d69dcee9c79c99d884c54ea5dc"
  license "MIT"
  head "https://github.com/niallrmurphy/macup.git", branch: "main"

  bottle do
    root_url "https://github.com/niallrmurphy/homebrew-macup/releases/download/macup-1.2.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "91a4287ccbd767eed1caf4b5510b3a3960d7493b66e48288b787faec92b78af5"
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
