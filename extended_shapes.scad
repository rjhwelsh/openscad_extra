// Openscad extended shapes
// Copyright (C) 2020  rjhwelsh

// Define standard vector directions
// i, j, k
i = [1,0,0];
j = [0,1,0];
k = [0,0,1];

module fillet_cube(size=[1,1,1], r=0.3, center=false) {
     // rounds cornes in xy dimension only
     // size = outer dimensions of cube
     // r = fillet radius
     let( r_max = min(size[0], size[1])/2)
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
     let( r_max = min(size[0], size[1])/2)
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
     let( r_max = min(size[0], size[1], size[2])/2)
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

module rotate_extrude_hull(
     angle=360,
     convexity=2,
     create_hull=true // Use hull unless working with concave shapes
     ) {
     total_angle=angle;
     module section_nohull(angle) {
	  rotate_extrude(angle=$fa)
	       projection(cut=true)
	       translate([0,0,1]*(-angle))
	       children();
     }

     module section_hull(angle, $fs=0.01) {
	  module cut(fa=0, fs=$fs) {
	       let (
		    trans = (angle+fa),
		    trans2 = (trans >= total_angle ? total_angle : trans))
		    rotate(a=fa, v=[0,1,0])
		    linear_extrude(height=fs/2)
		    projection(cut=true)
		    translate(-trans2*[0,0,1])
		    children();
	  }

	  rotate(a=90, v=[1,0,0])
	       hull() {
	       cut(fa=0) children();
	       cut(fa=$fa) children();
	  }
     }

     module main(total_angle=angle, create_hull=create_hull) {
	  let(
	       n = round(total_angle / $fa),
	       $fa = total_angle / n
	       )
	       if (create_hull) {
		    for (i=[0:$fa:total_angle-$fa])
			 let (angle=i)
			      rotate(a=angle, v=[0,0,1])
			      section_hull(angle=angle)
			      children();
	       }
	       else {
		    for (i=[0:$fa:total_angle-$fa])
			 let (angle=i)
			      rotate(a=angle, v=[0,0,1])
			      section_nohull(angle=angle)
			      children();
	       }
     }
     union() main() children();
}
