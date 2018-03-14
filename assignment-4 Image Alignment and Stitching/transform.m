function [image] = transform(img1, m1, m2, m3, m4, t1, t2, method)
    % REIMPLEMENT THIS!
    % maybe it helps: % http://inside.mines.edu/~whoff/courses/EENG510/lectures/04-InterpolationandSpatialTransforms.pdf
    % I am putting minus m2 and minus m3 because it makes the image
    % boat1 to rotate in the other direction. Although, I expected to rotate in
    % the good direction with m2 and m3 as they are.
    
    if strcmp(method,'own')
        T = [m1 m2 0; m3 m4 0; t1 t2 1];
        [h,w,~] = size(img1);

        ul = [1, 1, 1] / T;
        ur = [1, w, 1] / T;
        bl = [h, 1, 1] / T;
        br = [h, w, 1] / T;

        hOff = min([ul(1), ur(1), bl(1), br(1)])-1;
        wOff = min([ul(2), ur(2), bl(2), br(2)])-1;

        image = zeros;
        for ii = 1:h
            for jj = 1:w
                p = [ii, jj, 1] / T;
                image(round(p(1)-hOff), round(p(2)-wOff)) = img1(ii, jj);
            end
        end
    elseif strcmp(method,'matlab')
        tform = affine2d([m1 m2 0; m3 m4 0; t1 t2 1]);
        image = imwarp(img1,tform);
    end
    
    image = mat2gray(image);
end