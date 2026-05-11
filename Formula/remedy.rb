class Remedy < Formula
  desc "Full-featured less-like markdown pager for modern terminals"
  homepage "https://github.com/KerseyFabrications/remedy"
  url "https://github.com/KerseyFabrications/remedy/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "aff21cc1adbecbba28099f4f2d89222d8084f22dfa3f7c72edfa6345caf4087e"
  license "GPL-3.0-or-later"

  head "https://github.com/KerseyFabrications/remedy.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "cmark-gfm"
  depends_on "ncurses"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "make", "-C", "build", "-j#{ENV.make_jobs}"
    system "make", "-C", "build", "install"
  end

  test do
    assert_match "remedy #{version}", shell_output("#{bin}/remedy --version")
    pipe_output("#{bin}/remedy --diagnose", "# Hello World", 0)
  end
end
