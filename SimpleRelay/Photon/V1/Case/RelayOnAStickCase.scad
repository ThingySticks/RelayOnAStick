pcbWidth = 30;
pcbLength = 77;

$fn=20;

// -----------------------------------------
// -----------------------------------------
module GenericBase(xDistance, yDistance, zHeight) {
	translate([radius,radius,0]) {
		minkowski()
		{
			cube([xDistance-(radius*2), yDistance-(radius*2), (zHeight/2)]);
			cylinder(r=radius,h=(zHeight/2));
		}
	}
}

module MainPcb() {
    
    
    difference() {
        union() {
            cube([pcbWidth, pcbLength, 1.6]);
            
            // Add the LED.
            translate([3, 44.5,1.6]) {
                cube([2, 5, 1.5]);
                translate([1, 2.5, 1.5]) {
                    %cylinder(h=25, r=1);
                }
            }
        }
        union() {
            // Pcb Mount holes...
            
            // Hold under photon
            translate([pcbWidth/2, 14.5, -5]) {
                // NB: Does not actually come through the photon.
                #cylinder(h=30, r=1.5);
            }
            
            // Rear holes
            translate([pcbWidth/2, 72.5, -5]) {                
                
                translate([11.5, 0, 0]) {
                    #cylinder(h=30, r=1.5);
                }
                
                translate([-11.5, 0, 0]) {
                    // NB: Does not actually come through the photon.
                    #cylinder(h=30, r=1.5);
                }
            }
        }
    }
}

module UsbConnector() {
    // 15mm overhang, overall 19mm
    cube([12.1, 19, 4.6]);
}

module Relay() {
    cube([15.3, 19, 15.4]);
}

module PhotonInSocket() {
    cube([20.5, 37, 15.2]);
    
    // Add the LED.
    translate([10.3, 11.5, 3]) {
        %cylinder(h=25, r=1);
    }
    
    // Upper half of a USB plug.
    translate([(20.5/2) - (11.5/2), -18, 15.2]) {
        %cube([11.3, 25, 4.2]);
    }
}

module TerminalBlock() {
    cube([16, 12.0, 8.3]);
    
    translate([0,12.0,0]) {
        // With connector
        //%cube([16, 22, 8.3]);
    
        translate([0,0,0]) {
            %cube([16, 22-11.5, 16]);
        }
    }
}


// -----------------------------------------
// -----------------------------------------
module PcbModel() {
   
    difference() {
        union() {
            //MainPcb();
            cube([200,200,200], round=true);
            
            // move to on top of PCB and in the middle.
            translate([(pcbWidth/2),0, 1.6]) {
                translate([0-(15.3/2),44.5,0]) {
            //        Relay();
                }
                
                translate([0-(20.5/2),2,0]) {
              //      PhotonInSocket();
                }
                
                translate([0-(16/2),71,0]) {
              //      TerminalBlock();
                }
            }
        }
        union() {
            translate([(pcbWidth/2) - (12.1/2),-15, 0]) {
                #UsbConnector();
            }
        }
    }
}

PcbModel();