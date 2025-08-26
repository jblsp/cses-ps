// Aug 26 2025
// g++ 15.2.1

// CSES Problem Set
// Task 1068: Weird Algorithm
// https://cses.fi/problemset/task/1068/

#include <iostream>

using std::cout, std::cin;

int main() {
  long x;
  cin >> x;
  while (x != 1) {
    cout << x << " ";
    if (x % 2 == 0) {
      x /= 2;
    } else {
      x *= 3;
      x += 1;
    }
  }
  cout << x << " \n";
  return 0;
}
