// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
We've been writing our main methods incorrectly this whole
time. If you're like me and have been driven crazy by
junk return values in your `$?`, you'll be glad to know
that we now know enough to write our methods the correct way.

Let's see what gets passed to the main method when we
run a program from the commandline.
*/

#include <stdio.h>

int main (int argc, char *argv[])
{
    int param = 0;
    while (param < argc)
    {
        printf ("Parameter %d is %s\n", param, argv[param]);
        param++;
    }

    return 0;
}
