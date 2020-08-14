// Openscad extra linear array 
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

include <unit_vectors.scad>;

module linear_array(
     L=false,           // total Length between centers
     n=3,               // number of items
     dx=false,          // distance between centres 
     center=true,       // center array
     v=i                // unit vector direction
     )
     let( v=v/norm(v)) // convert to unit vector
{
     msg1="Please specify a single option of \"L\" or \"dx\"!";
     if(L) assert(!dx, msg1);
     if(dx) assert(!L, msg1);

     if (n>1) {
	  let(
	       dx=(L ? L/(n-1) : dx),
	       L=(dx ? dx*(n-1) : L)
	       )
	       for(x=[1:n])
		    translate(center ? -L/2*v : O) // Centre in axis
			 translate(dx*(x-1)*v)
			 children();
     }
     else if(n==1||n==-1) {
	  children();
     }
     else if(n<-1) {
	  let(n=-n) // positive the negative n
	       let(dx=(L ? L/(n-1) : dx),
		   L=(dx ? dx*(n-1) : L))
	       for(x=[1:n])
		    translate(center ? L/2*v : O) // Centre in axis
			 translate(-dx*(x-1)*v)
			 children();
     }
}
