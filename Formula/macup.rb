class Macup < Formula
  desc "macOS application inventory and update checker"
  homepage "https://github.com/niallrmurphy/macup"
  url "https://github.com/niallrmurphy/macup/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "4a528fcf0f3df0a0795a12b8351ff432ffa740e8756e288e2ddc83d177a6577c"
  license "MIT"
  head "https://github.com/niallrmurphy/macup.git", branch: "main"


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
