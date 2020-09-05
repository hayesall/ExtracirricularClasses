cmake_minimum_required(VERSION 3.13)

find_package(GTest REQUIRED)
include_directories(${GTEST_INCLUDE_DIRS})

add_subdirectory(maybemath)
