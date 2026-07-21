class Krew < Formula
  desc "krew with oci:// plugin distribution (lazedo fork: docker-keychain auth, private ghcr)"
  homepage "https://github.com/lazedo/krew"
  url "https://github.com/lazedo/krew.git", tag: "v0.4.5-oci.1"
  version "0.4.5-oci.1"
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
