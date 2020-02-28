// Openscad extended shapes
// Copyright (C) 2020  rjhwelsh

module fillet_cube(b=[1,1,1], r=0.3) {
		 // b = base dimension
		 // r = fillet radius
		 hull()
					let ( m = [b[0]/2 - r, b[1]/2 - r, 0] ) {
					for(i = [-1:2:1])
							 for(j = [-1:2:1])
										translate([i*m[0], j*m[1], m[2]])
												 cylinder(h=b[2],r=r,center=true,$fn=$fn);
		 }
}

module round_cube(b=[1,1,1], r=0.3) {
		 // b = base dimension
		 // r = fillet radius
		 hull()
					let ( m = [b[0]/2 - r, b[1]/2 - r, b[2]/2 - r] ) {
					for(i = [-1:2:1])
							 for(j = [-1:2:1])
                    for(k = [-1:2:1])
												 translate([i*m[0], j*m[1], k*m[2]])
															sphere(r=r, $fn=$fn);
		 }
}
