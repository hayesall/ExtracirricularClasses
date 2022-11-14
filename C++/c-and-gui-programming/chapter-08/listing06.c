// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
This is another case where I'm seeing an error since
the result of `strlen` is not necessarily an integer.

I've changed the `%d` to `%ld` as suggested by the compiler.
*/

#include <stdio.h>
#include <string.h>

void main (void)
{
    char str1[10] = "first";

    printf ("The length of the string '%s' is %ld\n", str1, strlen (str1));
}
