// Copyright 2020 Alexander L. Hayes
// MIT License

#include <math.h>

double mysqrt(const double a) {
  double b = sqrt(a);

  if (b != b) {
    return -1.0;
  } else {
    return sqrt(a);
  }
}
