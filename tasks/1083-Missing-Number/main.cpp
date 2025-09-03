// Aug 27 2025
// g++ 17.0.0

// CSES Problem Set
// Task 1083: Missing Number
// https://cses.fi/problemset/task/1083/

#include <iostream>
#include <unordered_set>

using std::cout, std::cin, std::unordered_set;

int main() {
  int n;
  cin >> n;

  unordered_set<int> missing;
  for (int i = 1; i <= n; i++) {
    missing.insert(i);
  }

  int j;
  for (int i = 1; i <= n; i++) {
    cin >> j;
    missing.erase(j);
  }

  cout << *missing.begin() << "\n";
  return 0;
}
