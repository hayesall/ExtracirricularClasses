// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea 3: Formatting the output in some way using fprintf
*/

#include <stdio.h>

int main (int argc, char *argv[])
{
    FILE *fp;
    fp = fopen ("output03.txt", "wb");

    if (fp) {
        fprintf (fp, "This is some text.\n");
        fclose (fp);
    }
}
