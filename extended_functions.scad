// Openscad extended functions
// Copyright (C) 2020  rjhwelsh

// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

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

// Circle functions

// circle_3pt_to_xyr; converts 3 points on a circle to a center coord, and radius
function circle_3pt_to_xyr(pt1, pt2, pt3) =
     // Obtain x1, y1, ... etc
     let(x1 = pt1[0],
	 y1 = pt1[1],
	 x2 = pt2[0],
	 y2 = pt2[1],
	 x3 = pt3[0],
	 y3 = pt3[1])
     // Obtain x1_2 (x1^2) .. etc
     let(x1_2 = pow(x1,2),
	 y1_2 =	pow(y1,2),
	 x2_2 =	pow(x2,2),
	 y2_2 =	pow(y2,2),
	 x3_2 =	pow(x3,2),
	 y3_2 = pow(y3,2))
     // Equation of a circle;
     // Ax^2 + Ay^2 + Bx + Cy + D = 0
     // Obtain A, B, C, D coeff
     let(A=x1*(y2-y3)-y1*(x2-x3)+x2*y3-x3*y2,
	 B=(x1_2+y1_2)*(y3-y2)      +(x2_2+y2_2)*(y1-y3)      +(x3_2+y3_2)*(y2-y1),
	 C=(x1_2+y1_2)*(x2-x3)      +(x2_2+y2_2)*(x3-x1)      +(x3_2+y3_2)*(x1-x2),
	 D=(x1_2+y1_2)*(x3*y2-x2*y3)+(x2_2+y2_2)*(x1*y3-x3*y1)+(x3_2+y3_2)*(x2*y1-x1*y2))
     // Calculate A_2 (A^2) .. etc
     let(A_2=pow(A,2),
	 B_2=pow(B,2),
	 C_2=pow(C,2),
	 D_2=pow(D,2))
     // Calculate coords and radius
     let(x_center=-B/(2*A),
	 y_center=-C/(2*A),
	 radius_2=(B_2+C_2-4*A*D)/(4*A_2),
	 radius=sqrt(radius_2)
	  )
     // Return xyr
     // Debug:: [A, B, C, D]
     [x_center, y_center, radius];
