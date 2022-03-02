// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea: Global variables
*/

#include <stdio.h>

int result;

void add (int a, int b) {
    result = a + b;
}

int main (int argc, char *argv[]) {
    add (3, 4);

    printf ("The result is %d\n", result);
}
