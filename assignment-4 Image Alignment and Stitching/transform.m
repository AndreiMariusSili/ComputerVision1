function [image] = transform(img1, m1, m2, m3, m4, t1, t2)
    % REIMPLEMENT THIS!
    % maybe it helps: % http://inside.mines.edu/~whoff/courses/EENG510/lectures/04-InterpolationandSpatialTransforms.pdf
    % I am putting minus m2 and minus m3 because it makes the image
    % boat1 to rotate in the other direction. Although, I expected to rotate in
    % the good direction with m2 and m3 as they are.

    tform = maketform('affine',[m1 -m2 0; -m3 m4 0; t1 t2 1]);
    image = imtransform(img1,tform);
end