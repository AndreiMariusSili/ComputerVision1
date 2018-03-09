function [f1, d1, f2, d2, matches, scores] = keypoint_matching(img1, img2)

    boat1 = single(img1); 
    [f1,d1] = vl_sift(boat1) ;

    boat2 = single(img2); 
    [f2,d2] = vl_sift(boat2) ;

    [matches, scores] = vl_ubcmatch(d1, d2) ;

end