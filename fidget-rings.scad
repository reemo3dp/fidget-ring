module ring(height, radius, wallThickness) {
    intersection() {
        difference() {
            sphere(r = radius, $fn = 200);
            sphere(r = radius-wallThickness, $fn = 200);        
        };
        cube([radius*2, radius*2, height], center = true);
    };
}


module fidget_rings(height, max_radius, wall_thickness, distance) {
    min_radius = height/1.8;
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



fidget_rings(15, 30, 2.4, 0.4);

