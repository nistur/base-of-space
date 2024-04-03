$fn=360;

peg_diameter = 2;
peg_height = 2;
pin_height = 2;
pin_diameter=1.5;
stem_height = 25;
stem_diameter = 3;
stem_taper=0.5;

union()
{    
    translate([ 0, 0, peg_height ]) cylinder(r1 = stem_diameter/2, r2 = (stem_diameter/2)-stem_taper, h = stem_height);
    cylinder(d=peg_diameter, h=peg_height);
    translate([0,0,peg_height + stem_height]) cylinder(d=pin_diameter, h=pin_height);
}
