#include <gtest/gtest.h>

#include "palindrom.hpp"

TEST(PalindromTest, Negative) {
    std::string s = "gentleman";
    EXPECT_EQ(false,  IsPalindrom(s));

    s = "123";
    EXPECT_EQ(false,  IsPalindrom(s));
}

TEST(PalindromTest, Positive) {
    std::string s = "";
    EXPECT_EQ(true,  IsPalindrom(s));

    s = "X";
    EXPECT_EQ(true,  IsPalindrom(s));

    s = "121";
    EXPECT_EQ(true,  IsPalindrom(s));

    s = "madam";
    EXPECT_EQ(true,  IsPalindrom(s));
}


int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

