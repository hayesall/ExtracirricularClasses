// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea: Defining new types, specifically enumerated types.
*/

#include <stdio.h>

typedef enum {
    false,
    true
} BOOLEAN;

int main (int argc, char *argv[]) {

    BOOLEAN b_var;

    b_var = false;

    if (b_var) {
        printf ("TRUE\n");
    } else {
        printf ("FALSE\n");
    }

    return 0;
}
