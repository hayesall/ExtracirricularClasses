// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea 4: Moving the file pointer around to visit different places.
*/

#include <stdio.h>

int main (int argc, char *argv[])
{
    int value;

    FILE *fp;
    fp = fopen ("input.txt", "rb");

    if (fp) {

        fseek (fp, 6, SEEK_CUR);

        while (1) {
            value = fgetc (fp);
            if (value == EOF) break;
            else printf ("%c", value);
        }

        fclose (fp);
    }
}
