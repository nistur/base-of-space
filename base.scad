$fn=360;

stem_diameter=2;
stem_fit=0.05;
base_diameter=25;
base_height=2;
arc_spacing=1;
arc_depth=0.3;
arc_angle=45;
nameplate_spacing=1;
nameplate_depth=0.3;
nameplate_height=5;
nameplate_angle=90;
nameplate_thickness=1;

chamfer_height=1;
arc_diameter=base_diameter-((arc_spacing + chamfer_height)*2);
nameplate_diameter=base_diameter-((nameplate_spacing + chamfer_height)*2);

PI=3.141579;

nameplate_arc_length=(nameplate_angle * PI * nameplate_diameter)/360;
inner_nameplate_arc_length=nameplate_arc_length - (2*nameplate_thickness);
inner_nameplate_arc_angle=(inner_nameplate_arc_length*360)/(nameplate_diameter*PI);

module base()
{
	difference()
	{
		union()
		{
			cylinder(r=base_diameter/2,h=base_height-chamfer_height);
			translate([0,0,base_height-chamfer_height]) cylinder(r1=base_diameter/2, r2=(base_diameter/2)-chamfer_height,h=chamfer_height);
		}
		translate([0,0,0.5]) cylinder(r=(stem_diameter/2)+stem_fit, h=base_height+0.2);
	}
}

module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
}   

module firing_arc()
{
	difference()
	{
		sector(arc_depth+0.1, arc_diameter, -arc_angle/2, arc_angle/2);
		translate([0,0,-0.1]) cylinder(r=(stem_diameter/2)+arc_spacing,h=arc_depth+0.3);
	}
}

module name_plate()
{
	rotate([0,0,180])
	{
		difference()
		{
			sector(nameplate_depth, nameplate_diameter, -nameplate_angle/2, nameplate_angle/2);
			translate([0,0,-0.1]) cylinder(h=nameplate_depth+0.2,r=(nameplate_diameter/2)-nameplate_height);
			difference()
			{
				sector(nameplate_depth, nameplate_diameter-(nameplate_thickness*2), -inner_nameplate_arc_angle/2, inner_nameplate_arc_angle/2);
				translate([0,0,-0.2]) cylinder(h=nameplate_depth+0.4,r=nameplate_thickness+(nameplate_diameter/2)-nameplate_height);
			}
		}
	}
}

difference()
{
	union()
	{
		base();
		translate([0,0,base_height]) name_plate();
	}
	translate([0,0,base_height-arc_depth]) firing_arc();
}
