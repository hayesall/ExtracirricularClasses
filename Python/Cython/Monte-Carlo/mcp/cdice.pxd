# cdice.pxd

cdef extern from "src/dice6_c.h":
  double dice6(int N, int ndice, int nsix)
