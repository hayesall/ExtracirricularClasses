// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea 2: Writing to a file.

Values 48 - 57 correspond to characters 0, 1, ..., 9.
*/

#include <stdio.h>

int main (int argc, char *argv[])
{

    FILE *fp;
    fp = fopen ("output02.txt", "wb");

    if (fp) {
        for (int value = 48; value < 58; value++) {
            fputc (value, fp);
        }
        fclose (fp);
    }

    return 0;
}
