boat1 = single(imread('./boat1.pgm')); 
[f1,d1] = vl_sift(boat1) ;

boat2 = single(imread('./boat2.pgm')); 
[f2,d2] = vl_sift(boat2) ;

[matches, scores] = vl_ubcmatch(d1, d2) ;