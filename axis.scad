// Openscad extra axis transformations
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


// Axes are defined by [x, y, z] translation
// and a rotation defined by a vector perpendicular to the x and y axis
// So [[0,0,0], [0,0,1]] would define the origin in the regular orientation
// The goal is to standardize position and orientation in a single variable

include <unit_vectors.scad>

//axis_origin=[[0,0,0],[0,0,1]];

function angle_between_vectors(a, b) = acos(a*b/norm(a)/norm(b));

// translate from origin to axis
module to_axis(axis) {
     let(t=axis[0],
	 r=axis[1],
	 a=angle_between_vectors(r,k),
	 v=cross(k,r))
	  translate(t) rotate(a=a, v=v) children();
}

// translate from axis to origin
module from_axis(axis) {
     let(t=axis[0],
	 r=axis[1],
	 a=angle_between_vectors(r,k),
	 v=cross(k,r))
	  rotate(a=a, v=-v) translate(-t) children();
}

// transform object from axis a to axis b
module transform_axis(a, b){
     to_axis(b) from_axis(a) children();
}


