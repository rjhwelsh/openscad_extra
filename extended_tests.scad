// Openscad extended test functions and modules
// Copyright (C) 2020  rjhwelsh

// assert_equal; Test first and second are equal
module assert_equal(first, second, msg) {
     msg = msg ? msg : str(first, " is not equal to ", second);
     assert(first==second, msg);
}
