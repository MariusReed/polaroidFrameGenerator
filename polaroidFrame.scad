$fn = $preview ? 32 : 64;
//variables
cutOut = 0.2;
frameWallThickness = 2.4;

polaroidOuterX = 54;
polaroidOuterY = 85;
polaroidOuterZ = 0.8;

frameOuterX = polaroidOuterX+frameWallThickness*2+cutOut*2;
frameOuterY = polaroidOuterY+frameWallThickness*2+cutOut*2;
frameOuterZ = polaroidOuterZ+frameWallThickness*2+cutOut*2;

polyhedronCutOutZ = frameOuterZ-frameWallThickness-polaroidOuterZ;
polyhedronCutOutTaper = 1;

//counter sunk screw type: M3 DIN 7982-Torx
screwHeadHeight = 1.6+cutOut;
mountingHoleHeight = frameWallThickness+cutOut;
mountingHoleMinDiameter = 3+cutOut;
mountingHoleMaxDiameter = 5.5+cutOut;
mountingHoleOffsetX = polaroidOuterX/2+mountingHoleMaxDiameter/2;
mountingHoleOffsetY = polaroidOuterY/4;


//moduls
module frame(){
	
	difference(){
		
		cube([frameOuterX,frameOuterY,frameOuterZ]);
		
		translate([frameWallThickness+cutOut,
				frameWallThickness+cutOut,
				frameWallThickness+polaroidOuterZ+cutOut]){
			
			CubePoints = [
			[0,0,0],  
			[polaroidOuterX,0,0],  
			[polaroidOuterX,polaroidOuterY,0],  
			[0,polaroidOuterY,0],  
			[polyhedronCutOutTaper,polyhedronCutOutTaper,polyhedronCutOutZ],  
			[polaroidOuterX-polyhedronCutOutTaper,polyhedronCutOutTaper,polyhedronCutOutZ],  
			[ polaroidOuterX-polyhedronCutOutTaper,polaroidOuterY-polyhedronCutOutTaper,polyhedronCutOutZ],  
			[polyhedronCutOutTaper,polaroidOuterY-polyhedronCutOutTaper,polyhedronCutOutZ]
			]; 
  
			CubeFaces = [
			[0,1,2,3],  
			[4,5,1,0],  
			[7,6,5,4],  
			[5,6,2,1], 
			[6,7,3,2],  
			[7,4,0,3]]; 
  
			polyhedron(CubePoints,CubeFaces);
		}
		translate([frameWallThickness+cutOut,-cutOut,frameWallThickness+cutOut]){
			
			cube([polaroidOuterX,polaroidOuterY+frameWallThickness+cutOut*3,polaroidOuterZ+cutOut/100]);
		}
		
		translate([mountingHoleOffsetX,mountingHoleOffsetY,mountingHoleHeight-screwHeadHeight+cutOut]){
			
			cylinder(h=screwHeadHeight,d1=mountingHoleMinDiameter, d2=mountingHoleMaxDiameter);
			
			translate([0,0,-mountingHoleHeight+screwHeadHeight-cutOut*2])
			
				cylinder(h=mountingHoleHeight,d=mountingHoleMinDiameter);
		}	
	}
}


//callBack

frame();