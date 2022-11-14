// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea 1: Reading a file.

My `input.txt` contains something like this:

```
1 + 1
2 x 5
3 x 1
10 / 5
125 / 10
125 - 5
```

A simple exercise would be to refactor the
"simple calculator" example from the previous
chapter into a function, load problems from a
file, then print and evaluate the problems.
*/

#include <stdio.h>

int main (int argc, char *argv[])
{

    FILE *fp;
    int value;

    fp = fopen ("input.txt", "rb");
    if (fp) {
        while (1) {
            value = fgetc (fp);
            if (value == EOF) break;
            else printf ("%c", value);
        }
        fclose (fp);
    }

    return 0;
}
