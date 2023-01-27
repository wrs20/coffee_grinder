$fn=50;

burrset_outer_radius = 35;
burrset_inner_radius = 16;
burrset_height = 9;
burrset_separation = 1;
burrset_rear_inner_radius = 31;
burrset_rear_inner_depth = 1;
burrset_hole_major_radius = 21;
burrset_hole_minor_radius = 2;
burrset_hole_recess_radius = burrset_hole_minor_radius+2;
burrset_hole_recess_offset = 2.5;

render_burrs = 1;

module burr(z) {
    translate([0,0,z]) {
    difference(){
        difference() {
            cylinder(r1=burrset_outer_radius, r2=burrset_outer_radius, h=burrset_height);
            translate([0,0,-0.5])
                cylinder(r1=burrset_inner_radius, r2=burrset_inner_radius, h=burrset_height+1);
            };
            translate([0,0,2])
            cylinder(r1=burrset_inner_radius, r2=burrset_outer_radius-1, h=burrset_height-1.9);
            translate([0,0, -burrset_height+burrset_rear_inner_depth]) 
                cylinder(
                    r1=burrset_rear_inner_radius, 
                    r2=burrset_rear_inner_radius, 
                    h=burrset_height
                );
            // Holes for retaining bolts
            for (angle = [0, 120, 240]){
                // The smaller hole for the retaining bolt
                rotate([0,0,angle])
                translate([burrset_hole_major_radius, 0, -1])
                cylinder(
                    r1=burrset_hole_minor_radius,
                    r2=burrset_hole_minor_radius,
                    h=burrset_height+2
                );
                // The recess for the head of the bolt
                rotate([0,0,angle])
                translate([burrset_hole_major_radius, 0, burrset_hole_recess_offset])
                cylinder(
                    r1=burrset_hole_recess_radius,
                    r2=burrset_hole_recess_radius,
                    h=burrset_height+2
                );
            }
            //burrs
            if (render_burrs){
                for (angle = [0:6:360]){
                    rotate([0,0,angle])
                    translate([0,0,burrset_height-7])
                    rotate([0,-8,0])    
                    rotate([220,0,0])    
                    rotate([0,90,0])    
                    linear_extrude(height=burrset_outer_radius+1)
                    polygon(points=[[0,0],[10,0],[10,4]]);
                }
            }
        }
    }
}

module lower_holder () {
    union() {
        cylinder(
            r1=burrset_rear_inner_radius, 
            r2=burrset_rear_inner_radius, 
            h=burrset_rear_inner_depth
        );
        plate_depth = 8;
        cone_depth = 8;
        translate([0,0,-plate_depth])
            cylinder(
                r1=burrset_outer_radius, 
                r2=burrset_outer_radius, 
                h=plate_depth
            );
        translate([0,0,burrset_rear_inner_depth])
            cylinder(
                r1=burrset_inner_radius, 
                r2=5, 
                h=cone_depth
            );
        translate([0,0,burrset_rear_inner_depth+cone_depth])
            cylinder(
                r1=5, 
                r2=5, 
                h=100
            );
        translate([0,0,-plate_depth-20])
            cylinder(
                r1=5, 
                r2=5, 
                h=20
            );
    }
}


// Bottom burr
#burr(0.0);

// Top burr
#translate([0,0, 2 * burrset_height + burrset_separation]) rotate([180, 0, 0]) burr(0.0);

lower_holder();


