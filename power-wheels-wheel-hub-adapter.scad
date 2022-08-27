$fn=100;

outer_diameter = 3.95;
inner_diameter = 0.487;
wheel_hub_adapter_height = 0.191;
screw_hole_diameter = 0.162;
screw_hole_offset = 1.603;

cut_out_offset = 1.41;

// Bottom adaptor for wheel hub
difference() {
    cylinder(h=wheel_hub_adapter_height, d=outer_diameter);
    cylinder(h=wheel_hub_adapter_height, d=inner_diameter);
    translate([screw_hole_offset, 0, 0])
    cylinder(h=wheel_hub_adapter_height, d=screw_hole_diameter);
    translate([-screw_hole_offset, 0, 0])
    cylinder(h=wheel_hub_adapter_height, d=screw_hole_diameter);
    translate([0, screw_hole_offset, 0])
    cylinder(h=wheel_hub_adapter_height, d=screw_hole_diameter);
    translate([0, -screw_hole_offset, 0])
    cylinder(h=wheel_hub_adapter_height, d=screw_hole_diameter);
    
    translate([cut_out_offset, cut_out_offset, 0]) {
        rotate([0, 0, 45]) {
            minkowski() {
                cube(size=[0.773, 0.42, 0.5], center=true);
                sphere(0.15);
            }
        }
    }
    
    translate([-cut_out_offset, -cut_out_offset, 0]) {
        rotate([0, 0, 45]) {
            minkowski() {
                cube(size=[0.773, 0.42, 0.5], center=true);
                sphere(0.15);
            }
        }
    }
    
    translate([cut_out_offset, -cut_out_offset, 0]) {
        rotate([0, 0, 45]) {
            minkowski() {
                cube(size=[0.42, 0.773, 0.5], center=true);
                sphere(0.15);
            }
        }
    }
    
    translate([-cut_out_offset, cut_out_offset, 0]) {
        rotate([0, 0, 45]) {
            minkowski() {
                cube(size=[0.42, 0.773, 0.5], center=true);
                sphere(0.15);
            }
        }
    }
}

// Top Adapter for Gear  Box
gear_box_adapter_outer_diameter = 2.800; // originally 2.692
gear_box_adapter_inner_diameter = 2.592;
gear_box_adapter_height = 0.496;

translate([0, 0, wheel_hub_adapter_height]) {
    difference() {
        cylinder(h=gear_box_adapter_height, d=gear_box_adapter_outer_diameter);
        cylinder(h=gear_box_adapter_height, d=gear_box_adapter_inner_diameter);
    }
}

translate([0, 0, wheel_hub_adapter_height]) {
    difference() {
        cylinder(h=gear_box_adapter_height, d=0.694);
        cylinder(h=gear_box_adapter_height, d=inner_diameter);
    }
}

// Generate spokes inside gear box adapter
number_of_spokes = 10;
spoke_width = 0.098;
spoke_length = 0.970;
spoke_offset = spoke_width / 2;

step = 360 / number_of_spokes;
for (i=[0:step:359]) {
    rotate([0, 0, i]) {
        translate([-spoke_offset, 0.330, wheel_hub_adapter_height]) {
            cube([spoke_width, spoke_length, gear_box_adapter_height], false);
        }
    }
}
