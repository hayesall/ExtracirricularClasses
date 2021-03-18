# distutils: sources = mcp/src/dice6_c.c
# distutils: include_dirs = mcp/src/

cimport cdice

def dice6_cwrap(int N, int ndice, int nsix):
  return cdice.dice6(N, ndice, nsix)
