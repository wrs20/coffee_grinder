$fn=50;

burrset_outer_radius = 35;
burrset_inner_radius = 16;
burrset_height = 9;


module burr(z) {
    translate([0,0,z]) {
    difference(){
        difference() {
            cylinder(r1=burrset_outer_radius, r2=burrset_outer_radius, h=burrset_height);
            translate([0,0,-0.5])
                cylinder(r1=burrset_inner_radius, r2=burrset_inner_radius, h=burrset_height+1);
            };
            translate([0,0,2])
            cylinder(r1=burrset_inner_radius, r2=burrset_outer_radius-2, h=burrset_height-1.9);
        }
    }
}

burr(0.0);
//burr(burrset_height+2);





