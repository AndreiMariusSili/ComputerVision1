image_dir = 'images_question_7';
files = dir(fullfile('images_question_7', '*.png'));
nfiles = length(files);

image1 = imread('./images/image1.jpg');
image1 = image1(:,:, 1);
for i = 1:nfiles

    filename = split(files(i).name, '.');
    filename = filename{1};
    
    % read input image
    imag = imread(fullfile(image_dir, files(i).name));
    imag = imag(:,:,1);
    {filename, myPSNR(image1, imag)}
end
