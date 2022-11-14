// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
A super simple calculator program using the CLI

I modified this so it returns a non-zero output (1)
if bad data gets passed in and signals this to the
user with a "Bad input" message.
*/

#include <stdio.h>

int main (int argc, char *argv[])
{
    int arg1, arg2;
    if (argc == 4) {
        sscanf (argv[1], "%d", &arg1);
        sscanf (argv[3], "%d", &arg2);

        if (*argv[2] == '+') printf ("%d\n", arg1 + arg2);
        if (*argv[2] == '-') printf ("%d\n", arg1 - arg2);
        if (*argv[2] == 'x') printf ("%d\n", arg1 * arg2);
        if (*argv[2] == '/') printf ("%d\n", arg1 / arg2);
    } else {
        printf ("Bad input.\n");
        return 1;
    }
    return 0;
}
