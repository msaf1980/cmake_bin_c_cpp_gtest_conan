#include <string>
#include <iostream>

#if USE_LZ4
#include <lz4.h>
#endif

#include <cxxopts.hpp>
#include <fmt/format.h>

#include "palindrom.hpp"

int main(int argc, char** argv) {
	std::string s = "gentleman";
	fmt::print("{0} {1}\n", s, IsPalindrom(s) ? 1 : 0);
#if USE_LZ4
	s = std::to_string(LZ4_versionNumber());
#endif
	return 0;
}
