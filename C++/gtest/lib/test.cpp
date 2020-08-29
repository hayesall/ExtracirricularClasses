// Copyright 2020 Alexander L. Hayes
// MIT License

#include "mysqrt.cpp"
#include <gtest/gtest.h>

TEST(test_mysqrt, positiives) {
  ASSERT_EQ(6.0, mysqrt(36.0));
  ASSERT_EQ(8.0, mysqrt(64.0));
}

TEST(test_mysqrt, negatives) {
  ASSERT_EQ(-1.0, mysqrt(-10.0));
  ASSERT_EQ(-1.0, mysqrt(-5.0));
}

int main(int argc, char **argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
