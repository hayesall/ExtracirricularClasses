// Copyright 2019 Simon Long
// "Introduction to C and GUI Programming"
// License: CC BY-NC-SA 3.0

/*
There's some discussion online that the gcc build method as written
in the book will not work:

https://www.linuxquestions.org/questions/programming-9/undefined-reference-to-%60gtk_init%27-4175657203/

Something like this will be needed instead:

```
gcc `pkg-config --cflags gtk+-2.0` listing01.c `pkg-config --libs gtk+-2.0`
```
*/

#include <gtk/gtk.h>

int main(int argc, char *argv[])
{
    gtk_init (&argc, &argv);
    GtkWidget *win = gtk_window_new (GTK_WINDOW_TOPLEVEL);
    gtk_widget_show( win );
    gtk_main();

    return 0;
}
