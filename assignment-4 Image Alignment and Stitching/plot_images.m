function plot_images(img1,img2, x1,y1,x2,y2)
    [~,w,~] = size(img1);
    
    figure
    imshow([img1, img2])
    hold on
    
    scatter(x1,y1,'filled', 'MarkerFaceColor', 'g')
    scatter(x2+w,y2,'filled', 'MarkerFaceColor', 'g')
    colours = ['r', 'g', 'b', 'c', 'm', 'y', 'k', 'w'];
    for i = 1:max(size(x1,1),size(x1,2))
        col = colours(mod(i,length(colours))+1);
        plot([x1(i) x2(i)+w], [y1(i) y2(i)], col, 'LineWidth', 1.5);
    end
    hold off
end