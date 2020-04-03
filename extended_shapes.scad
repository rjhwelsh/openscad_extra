// Openscad extended shapes
// Copyright (C) 2020  rjhwelsh

module fillet_cube(size=[1,1,1], r=0.3, center=false) {
		 // rounds cornes in xy dimension only
		 // size = outer dimensions of cube
		 // r = fillet radius
		 let( r_max = max(size[0], size[1])/2)
					assert(r <= r_max, str("Radius does not fit within size! r_max=", r_max));
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

module fillet_trapezoid(size=[1,1,1], r=0.3, angle=45, center=false) {
		 // size = [xyz] outer dimensions to fit trapezoid in
		 // r = fillet radius
		 // angle = angle between base and sides
		 // center = true/false; whether to position in center (or not)
		 let( r_max = max(size[0], size[1])/2)
					assert(r <= r_max, str("Radius does not fit within size! r_max=", r_max));
		 let ( m = [size[0]/2 - r, size[1]/2 - r, 0],
					 dx_max = m[0],
					 dh_max = dx_max*tan(angle),
					 dh = 2*m[1],
					 dx = dh/tan(angle),
					 assert_message = str("fillet_trapezoid: Reduce height. Maximum height is ", dh_max + 2*r, "!")
					) {
					assert(dx <= dx_max, assert_message);
					recenter=(center ? 0 : 0.5);

					translate(recenter*[size[0],dh+2*r,0])
							 hull()
							 for(i = [-1:2:1])
										for(j = [-1:2:1])
												 translate([i*(m[0] - (j+1)/2*dx),
																		j*m[1],
																		m[2]])
															cylinder(h=size[2],r=r,$fn=$fn);
		 }
}

module round_cube(size=[1,1,1], r=0.3, center=false) {
		 // rounds all corners in xyz
		 // size = outer dimensions of cube
		 // r = fillet radius
		 let( r_max = max(size[0], size[1], size[2])/2)
					assert(r <= r_max, str("Radius does not fit within size! r_max=", r_max));
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
