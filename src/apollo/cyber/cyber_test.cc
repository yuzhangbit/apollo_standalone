#include <gtest/gtest.h>


int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

TEST(cyber_test, util){
    std::cout << "cyber_gtest working." << std::endl;
}