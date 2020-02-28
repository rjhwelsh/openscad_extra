// Openscad extended shapes
// Copyright (C) 2020  rjhwelsh

module rounded_square(b, r) {
        // b = base width
        // r = fillet radius
        projection()
        hull()
        let ( m = [b/2 - r, b/2 - r, 0] ) {
            for(i = [-1:2:1])
                for(j = [-1:2:1])
        translate([i*m[0], j*m[1], m[2]])
        cylinder(h=1,r=r,center=true,$fn=$fn);
        }
}
