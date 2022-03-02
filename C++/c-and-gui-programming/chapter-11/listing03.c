// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
Idea: Defining types with structs and defining methods that operate
on those structs.
*/

#include <stdio.h>

typedef struct {
    int intval1;
    int intval2;
    int outval;
} MY_DATA;

void add (MY_DATA *d) {
    d->outval = d->intval1 + d->intval2;
}

int main (int argc, char *argv[]) {
    MY_DATA data;

    data.intval1 = 5;
    data.intval2 = 7;
    add (&data);

    printf ("The sum of %d and %d is %d\n", data.intval1, data.intval2, data.outval);
}
