#include <stdio.h>

int fact(int x) {
  return x == 0 ? 1 : x * fact(x - 1);
}

int main() {
  int x = 5;
  printf("fact(%d) = %d", x, fact(x));
}