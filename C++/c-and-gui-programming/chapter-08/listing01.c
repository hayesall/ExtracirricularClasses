// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Strings are pretty common, so instead of reinventing
the wheel each time, we can use the string library
to perform common operations.

Here is a much easier way to do the string concatenation
operation from the previous chapter.
*/

#include <stdio.h>
#include <string.h>

void main (void)
{
    char str1[10] = "first";
    char str2[10] = "second";
    char str3[20];

    strcpy (str3, str1);
    strcat (str3, str2);

    printf ("%s + %s = %s\n", str1, str2, str3);
}
