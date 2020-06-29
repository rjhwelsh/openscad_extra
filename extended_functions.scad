// Openscad extended functions
// Copyright (C) 2020  rjhwelsh

// slice; slices array (similar to python a[1:] equivalent to slice(a,1))
function slice(a, start=0, end=undef) =
     let( start=start,
	  end= is_undef(end) ? len(a) - 1: end )
     [for (i = [start:end]) a[i]];

// sum; adds elements of a list together (recursively)
//  Supported types include:
//   single number
//   list of numbers
//   list of vectors
function sum(a) =
     (is_num(a) ? a : // Handle single number

      (is_list(a) && is_num(a[0]) ? // Handle list of numbers
       (len(a) == 0 ? 0 :
	(len(a) == 1 ? a[0] :
	 (a[0] + sum(slice(a,1)))
	     )) :

       (is_list(a) && is_list(a[0]) ?
	(let(aLast=len(a)-1, vLast=len(a[0])-1)
	 [ for (j=[0:vLast]) // iterate over each expected vector element
		   sum(
                        [for (i=[0:aLast])  // iterate over each vector
				  a[i][j]]    // obtain element j for each vector i
			)                 // add together
	      ]                       // return list
	     ) :
	undef )));
