// Test extended functions

use <../functions.scad>
use <../test.scad>

module test_slice() {
     // Test slice() function
     // Count starts from 0
     // 0, 1, 2, 3
     a = [1, 2, 3, 4];

     assert_equal(slice(a,start=0),a);
     assert_equal(slice(a,1),[2,3,4]);
     assert_equal(slice(a,end=2),[1,2,3]);
     assert_equal(slice(a,1,2),[2,3]);
}


module test_sum() {
     // Test sum() function
     assert_equal(sum(0),0);
     assert_equal(sum(1),1);
     assert_equal(sum([1,2,3,4]),10);
     assert_equal(sum([[1,2,3,4], [1,2,3,4]]),[2,4,6,8]);
}

module test_circle_3pt_to_xyr() {
     // Test circle_3pt_to_xyr() function

     let(r=1,
	 xc=0,
	 yc=0,
	 th=[0, 90, -90])
	  let(pt1=[r*cos(th[0]),r*sin(th[0])],
	      pt2=[r*cos(th[1]),r*sin(th[1])],
	      pt3=[r*cos(th[2]),r*sin(th[2])])
     {
	  assert_equal(circle_3pt_to_xyr(pt1,pt2,pt3),[0,0,1]);
     }

     let(pt1=[3,2],
	 pt2=[6,3],
	 pt3=[0,3])
     {
	  echo(
	       circle_3pt_to_xyr(pt1,pt2,pt3));
	  assert_equal(circle_3pt_to_xyr(pt1,pt2,pt3),[3,7,5]);
     }

}

test_slice();
test_sum();
test_circle_3pt_to_xyr();
