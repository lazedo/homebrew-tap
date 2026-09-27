class Krew < Formula
  desc "Package manager for kubectl plugins, with oci:// plugin archives (krew#913)"
  homepage "https://github.com/lazedo/krew-upstream"
  # +oci.1 is semver build metadata: krew's upgrade check sees v0.5.0 and stays
  # quiet until upstream releases a newer version
  url "https://github.com/lazedo/krew-upstream.git",
      tag:      "v0.5.0+oci.1",
      revision: "b0ed015dbceb16025bb97117fbb342a62604d66f"
  version "0.5.0+oci.1"
  license "Apache-2.0"

  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"
    ldflags = "-s -w -X sigs.k8s.io/krew/internal/version.gitTag=v#{version}"
    system "go", "build", "-trimpath", "-ldflags", ldflags, "-o", "kubectl-krew", "./cmd/krew"
    bin.install "kubectl-krew"
  end

  test do
    assert_match "oci", shell_output("#{bin}/kubectl-krew version")
  end
end
