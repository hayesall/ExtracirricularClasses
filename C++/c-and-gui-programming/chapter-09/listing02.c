// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
A *better* way to handle user inputs by
guarding against a malicious user who
inputs more characters than we've allocated
memory for, and looping until they behave
correctly.
*/

#include <stdio.h>

void main (void)
{
    char input[256], name[256];
    int age;

    printf ("What is your name, user?\n");
    fgets (input, 256, stdin);
    sscanf (input, "%s", name);

    printf ("Hello, %s. How old are you?\n", name);

    while (1) {
        fgets (input, 256, stdin);
        if (sscanf (input, "%d", &age) == 1) break;
        printf ("I don't recognize that as an age - try again!\n");
    }

    printf ("Well, %s, you look young for %d...\n", name, age);
}
