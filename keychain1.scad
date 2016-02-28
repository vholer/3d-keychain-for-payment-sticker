/*
 * Keychain for contactless payment stickers (40 x 30 x 0.8 mm)
 * Vlastimil Holer, <vlastimil.holer@gmail.com>
 */

// rounded cube
module rcube(x, y, z, r) {
	d = 2*r;
	translate([r, r, 0]) resize([x, y, z]) minkowski() {
		cube([x-d, y-d, z/2]);
		cylinder(r=r, h=z/2, $fn=128);
	}
}

// keychain parameters:
//   x, y, z    ... keychain size
//   xi, yi, zi ... card inner size
//   lr, lri    ... loop outer and inner radius
//   er         ... rounded edge radius
module keychain(x=43, y=33, z=2.5, xi=40.5, yi=30.5, zi=1, lr=5, lri=3, er=3) {
	difference() {
		union() {
			resize([x,y,z]) translate([0,0,0]) rcube(x, y, z, r=er);
			hull() {
				translate([-1,-1,0]) cylinder(r=lr, h=z, $fn=128);
				translate([lr,lr,0]) cylinder(r=lr, h=z, $fn=128);
			}
		}

		translate([(x-xi)/2, (y-yi)/2, z-zi+0.01]) rcube(xi, yi, zi+0.01, r=er);	
		translate([-1,-1,0]) cylinder(r=lri, h=z+1, $fn=128);
	}
}

keychain();
