// Test extended shapes

include <extended_shapes.scad>;
use <extended_tests.scad>

module test_linear_array(check=check) {
     // Test array() module
     dx=3;


     // test dx override
     let(c=0)
	  color("cyan")
	  linear_array(dx=10, n=3, center=true)
	  translate(j*dx*c)
	  cube(1, center=false);

     // test length linear_array
     let(c=1)
	  color("red")
	  linear_array(10, n=3, center=false)
	  translate(j*dx*c)
	  cube(1);

     // test positive 1
     let(c=2)
	  color("blue")
	  linear_array(10, n=1, center=false)
	  translate(j*dx*c)
	  cube(1);

     // test zero = zero
     let(c=3)
	  color("cyan")
	  linear_array(10, n=0, center=false)
	  translate(j*dx*c)
	  cube(1);

     // test negative 1
     let(c=4)
	  color("green")
	  linear_array(10, n=-1, center=false)
	  translate(j*dx*c)
	  cube(1);

     // test negative n
     let(c=5)
	  color("yellow")
	  linear_array(10, n=-3, center=false)
	  translate(j*dx*c)
	  cube(1);

     // test center=true
     let(c=6)
	  color("cyan")
	  linear_array(10, n=3, center=true)
	  translate(j*dx*c)
	  cube(1, center=true);

     // test vector direction
     let(c=7)
	  color("red")
	  linear_array(10, n=3, center=true, v=k)
	  translate(j*dx*c)
	  cube(1, center=true);

     // test angles
     let(c=8)
	  color("yellow")
	  linear_array(10, n=3, center=true, v=(i+k))
	  translate(j*dx*c)
	  cube(1, center=true);

     // test conversion to unit vector (same length as previous)
     let(c=9)
	  color("orange")
	  linear_array(10, n=3, center=true, v=100*(i+k))
	  translate(j*dx*c)
	  cube(1, center=true);

     // Test assert fails (enable to test crash)
     *let(c=0)
	  color("cyan")
	  linear_array(10, dx=10, n=3, center=true)
	  translate(j*dx*c)
	  cube(1, center=true);

}

test_linear_array();
