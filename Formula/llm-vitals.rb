class LlmVitals < Formula
  desc "Live tokens per second for Claude Code and Codex"
  homepage "https://hamperpick.in/tools/llm-vitals"
  url "https://registry.npmjs.org/llm-vitals/-/llm-vitals-0.1.0.tgz"
  sha256 "66e45c026abb1edb6f2ab9e5b35c6bd303d6071f9b4717373e77f7e343dcd17c"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/llm-vitals --version")

    # No sessions in an empty home folder: an empty JSON list.
    ENV["CLAUDE_CONFIG_DIR"] = testpath/".claude"
    ENV["CODEX_HOME"] = testpath/".codex"
    assert_equal "[]\n", shell_output("#{bin}/llm-vitals --json")

    # The status line prints a reading even from input it cannot parse.
    assert_match "tok/s", pipe_output("#{bin}/llm-vitals statusline", "{}")
  end
end
