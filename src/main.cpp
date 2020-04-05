#include <iostream>

#include "palindrom.hpp"

int main(int argc, char** argv) {
    std::string s = "gentleman";
    std::cout << s << " " <<  IsPalindrom(s) << std::endl;
    return 0;
}
