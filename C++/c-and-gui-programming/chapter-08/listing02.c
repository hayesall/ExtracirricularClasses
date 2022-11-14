// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
A possible way to identify whether two strings are
the same using pointers to each element and breaking
if the things being pointed at are unequal.
*/

#include <stdio.h>

void main (void)
{
    char str1[10] = "first";
    char str2[10] = "second";
    char *ptr1 = str1, *ptr2 = str2;

    while (*ptr1 != 0 && *ptr2 != 0) {
        if (*ptr1 != *ptr2) {
            break;
        }
        ptr1++;
        ptr2++;
    }

    if (*ptr1 == 0 && *ptr2 == 0) {
        printf ("The two strings are identical.\n");
    } else {
        printf ("The two strings are different.\n");
    }
}
