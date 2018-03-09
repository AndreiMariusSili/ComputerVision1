function plot_images(img1,img2, x1,y1,x2,y2)
    [h,w,~] = size(img1);
    
    figure
    imshow([img1, img2])
    hold on
    
    scatter(x1,y1,'filled', 'MarkerFaceColor', 'g')
    scatter(x2+w,y2,'filled', 'MarkerFaceColor', 'g')
    for i = 1:max(size(x1,1),size(x1,2))
        plot([x1(i) x2(i)+w], [y1(i) y2(i)], 'b');
    end
    hold off
end