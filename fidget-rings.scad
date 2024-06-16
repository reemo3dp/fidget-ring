height = 15; //0.1
radius = 30;
// 2.4 or higher in case of flexible filament
wall_thickness = 2.4;
// A distance of 0.2-0.4 should be good enough
distance = 0.4;
// The higher the number, the smaller the inner sphere.
core_factor = 1.5; // [0.5:0.1:2]
// Cross-section preview
cross_section = false;


$fn = $preview == true ? 20 : 250;

difference() {
    fidget_rings(height, radius, wall_thickness, distance, core_factor);
    if(cross_section) {
        translate([radius/2, 0, 0]) cube([radius, radius*2, height], center = true);
    }
};

module ring(height, radius, wallThickness) {
    intersection() {
        difference() {
            sphere(r = radius);
            sphere(r = radius-wallThickness);        
        };
        cube([radius*2, radius*2, height], center = true);
    };
}


module fidget_rings(height, max_radius, wall_thickness, distance, core_factor) {
    min_radius = height/core_factor;
    num_rings = floor((max_radius-min_radius)/(wall_thickness+distance));
    
    center_radius = max_radius-(num_rings)*(wall_thickness+distance);
    
    for(r = [0 : num_rings-1]) {
        ring(height, max_radius-r*(wall_thickness+distance), wall_thickness);
    }
    intersection() {
        sphere(r = center_radius );
        cube([center_radius *2, center_radius *2, height], center = true);
    }
};
