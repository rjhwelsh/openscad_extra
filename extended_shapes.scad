// Openscad extended shapes
// Copyright (C) 2020  rjhwelsh

module fillet_cube(size=[1,1,1], r=0.3, center=false) {
		 // rounds cornes in xy dimension only
		 // size = outer dimensions of cube
		 // r = fillet radius
		 recenter=(center ? 0 : 0.5);
		 translate(recenter*[size[0],size[1],0])
					hull()
					let ( m = [size[0]/2 - r, size[1]/2 - r, 0] ) {
					for(i = [-1:2:1])
							 for(j = [-1:2:1])
										translate([i*m[0], j*m[1], m[2]])
												 cylinder(h=size[2],r=r,$fn=$fn);
		 }
}

module round_cube(size=[1,1,1], r=0.3, center=false) {
		 // rounds all corners in xyz
		 // size = outer dimensions of cube
		 // r = fillet radius
		 recenter=(center ? 0 : 0.5);
		 translate(recenter*size)
					hull()
					let ( m = [size[0]/2 - r, size[1]/2 - r, size[2]/2 - r] ) {
					for(i = [-1:2:1])
							 for(j = [-1:2:1])
                    for(k = [-1:2:1])
												 translate([i*m[0], j*m[1], k*m[2]])
															sphere(r=r, $fn=$fn);
		 }
}
