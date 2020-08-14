// Test axis modules

include <../axis.scad>;
//use <../test.scad> (not used yet)

visual_check=true;

module test_unit(size=[1,2,3],
		 pixel=[0.5,0.5,0.5]) {

     module dir(
	  n,
	  v,
	  c
	  ) {
	  color(c)
	       translate(v*pixel[n])
	       cube(pixel + (size[n]-2*pixel[n])*v);
     }
     color("white")
	  cube(size=pixel);
     dir(0,i,"red");
     dir(1,j,"green");
     dir(2,k,"blue");
}


module test_axis(visual_check=visual_check) {
     // Test axis() modules

     axis0=[[0,0,0],[0,0,1]];
     *to_axis(axis0) children();
     
     axis1=[2*[1,2,3],[0,0,1]]; // Translation no rotation
     to_axis(axis1) children();
     
     axis2=[[0,0,0],[0,1,0]]; // Rotation only (z->y) (x,y -> x,-z)
     to_axis(axis2) children();

     axis2a=[[0,0,0],[1,0,0]]; // Rotation only (z->x) (x,y -> -z,y)
     to_axis(axis2a) children();

     axis2b=[[0,0,0],[1,1,0]]; // Rotation only (z->(1,1,0)) 
     to_axis(axis2b) children();

     axis2c=[[0,0,0],[1,1,1]]; // Rotation only (z->(1,1,1))
     to_axis(axis2c) children();

     axis3=[2*[1,2,3],[1,1,0]]; // Translation and Rotation 
     to_axis(axis3) children();

     axis4=axis3;    // Translation and Rotation back
     from_axis(axis4) {
	  children();
	  to_axis(axis4) children();
     }
     
     // Visual test comparison stl
     if (visual_check==true) { color("black") import("test_axis.stl");}

}

test_axis() test_unit();
