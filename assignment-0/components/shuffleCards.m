function [result] = shuffleCards(img_path)
%Cut an image into 4 pieces and shuffle them
X = imread(img_path);
A = X(:,1:end/2,1:end);
B = X(:,end/2:end, 1:end);

Xs = [B,A];

figure(1);
subplot(1,2,1);
imshow(X);
subplot(1,2,2);
imshow(Xs);

result = Xs;

end