function lucas_kanade(img1, img2)
    window_size = 15;
    
    if mod(window_size,2) == 0
        fprintf("Window size must be odd.");
    end

    [h, w, n] = size(img1);
    if n == 3
        img1_gray = im2double(rgb2gray(img1));
        img2_gray = im2double(rgb2gray(img2));
    else
        img1_gray = im2double(img1);
        img2_gray = im2double(img2);
    end

    xs = [];
    ys = [];
    us = [];
    vs = [];
    
    Ix_m = conv2(img1_gray,[-1 1; -1 1], 'valid'); % partial on x
    Iy_m = conv2(img1_gray, [-1 -1; 1 1], 'valid'); % partial on y
    It_m = conv2(img1_gray, ones(2), 'valid') + conv2(img2_gray, -ones(2), 'valid'); % partial on t
    for i= 1:window_size:(h-window_size)
        for j= 1:window_size:(w-window_size)
            
            Ix = Ix_m(i:i+window_size-1,j:j+window_size-1,:);
            Iy = Iy_m(i:i+window_size-1,j:j+window_size-1,:);
            It = It_m(i:i+window_size-1,j:j+window_size-1,:);
            
            A = [Ix(:), Iy(:)];
            A_t = A';
            b = -It(:);
            
            v = (A_t * A) \ (A_t * b);
            
            xs = [xs,j+floor(window_size/2)];
            ys = [ys,i+floor(window_size/2)];            
            us = [us,v(1)];
            vs = [vs,v(2)];         
        end
    end
    us(isnan(us))=0;
    vs(isnan(vs))=0;
    
    figure
    imshow(img1);
    hold on
    quiver(xs,ys,us,vs, 'r');
    hold off
end