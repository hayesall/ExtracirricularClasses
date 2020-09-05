cmake_minimum_required(VERSION 3.13)

# Link runTests with what we want to test and the GTest and pthread library
add_executable(test_all test.cpp)

target_link_libraries(test_all ${GTEST_LIBRARIES} pthread)
