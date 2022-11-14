// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Reading input from the user and parsing it
with `scanf`.
*/

#include <stdio.h>

void main (void)
{
    char input[256];
    int age;

    printf ("What is your name, user?\n");
    scanf ("%s", input);

    printf ("Hello, %s. How old are you?\n", input);
    scanf ("%d", &age);

    printf ("Well, %s, you look young for %d...\n", input, age);
}
