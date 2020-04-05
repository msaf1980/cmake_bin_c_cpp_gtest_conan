#include <stdlib.h>

#include <algorithm>

#include "palindrom.hpp"

bool IsPalindrom(const std::string& s) {
    if (s.length() <= 1)
        return true;
    for (size_t i = 0; i < s.length() / 2; i ++) {
       if (s[i] != s[s.length() - i - 1])
           return false;
    }
    return true;
}

