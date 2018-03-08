function [xs,ys,us,vs] = lucas_kanade(img1, img2, xy)
    window = 15;
    half = floor(window/2);
    [h, w, n] = size(img1);
    if n == 3
        img1_gray = im2double(rgb2gray(img1));
        img2_gray = im2double(rgb2gray(img2));
    else
        img1_gray = im2double(img1);
        img2_gray = im2double(img2);
    end
    
    switch nargin
        case 2
            step_size = 15; 
            x_range = 1+half:step_size:(h-half);
            y_range = 1+half:step_size:(w-half);
            [X,Y] = meshgrid(x_range, y_range);
            X = X(:);
            Y = Y(:);
        case 3
            x_range = xy(:, 1);
            X = x_range(:);
            y_range = xy(:, 2);
            Y = y_range(:);
    end

    xs = [];
    ys = [];
    us = [];
    vs = [];

    % Generating the derivatives
    Ix_m = conv2(img1_gray,[-1 1; -1 1], 'same'); % partial on x
    Iy_m = conv2(img1_gray, [-1 -1; 1 1], 'same'); % partial on y
    It_m = conv2(img1_gray, ones(2), 'same') + conv2(img2_gray, -ones(2), 'same'); % partial on t

    
    for ii = 1:length(X)
        i = X(ii);
        j = Y(ii);
        
        if (i-half < 1) || (i+half > h) || (j-half < 1) || (j+half > w)
            xs = [xs;j];
            ys = [ys;i];
            us = [us;0];
            vs = [vs;0];
            continue;
        end

        Ix = Ix_m(i-half:i+half,j-half:j+half,:);
        Iy = Iy_m(i-half:i+half,j-half:j+half,:);
        It = It_m(i-half:i+half,j-half:j+half,:);

        A = [Ix(:), Iy(:)];
        b = -It(:);
    
        v = pinv(A)*b;        
        
        xs = [xs;j];
        ys = [ys;i];
        us = [us;v(1)];
        vs = [vs;v(2)];
    end

    switch nargin
        case 2
            figure;
            imshow(img1)
            hold on
            quiver(xs,ys,us,vs, 'r');
            hold off
        case 3
            figure;
            set(gcf, 'Visible', 'off');
            imshow(img1_gray, [])
            hold on
            quiver(xs,ys,us,vs, 'r');
            plot(xs, ys, 'r.');
            hold off
    end
end