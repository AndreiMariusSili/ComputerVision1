function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run('vl_setupnn.m') ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end

% opts.train.gpus = [1];



%% update model

net = update_model();

%% TODO: Implement getCaltechIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
image_height = 32;
image_width = 32;
num_channels = 3;
num_images = 0;
for c=classes
    class = c{1,1};
    for s=splits
        split = s{1,1};
        
        image_paths_file = fopen(sprintf("../Caltech4/ImageSets/%s_%s.txt", class, split), 'r');
        image_paths = textscan(image_paths_file, '%s');
        image_paths = image_paths{1,1};
        num_images = num_images + length(image_paths);
    end
end

data = single(zeros(image_height, image_width, num_channels, num_images));
labels = single(zeros(1, num_images));
sets = single(zeros(1, num_images));
image_no = 1;
for c=classes
    class = c{1,1};
    for s=splits
        split = s{1,1};
        
        image_paths_file = fopen(sprintf("../Caltech4/ImageSets/%s_%s.txt", class, split), 'r');
        image_paths = textscan(image_paths_file, '%s');
        image_paths = image_paths{1,1};
        
        for i=1:length(image_paths)
            image_path = fullfile('../Caltech4/ImageData', sprintf('%s.%s', image_paths{i}, 'jpg'));
            I = single(imresize(imread(image_path), [image_height, image_width]));
            if size(I,3) == 1
                I(:,:,1) = I(:,:,1);
                I(:,:,2) = I(:,:,1);
                I(:,:,3) = I(:,:,1);
            end
            data(:,:,:,image_no) = I;
            
            if strcmp(class, 'airplanes')
                labels(1, image_no) = 1;
            elseif strcmp(class, 'cars')
                labels(1, image_no) = 2;
            elseif strcmp(class, 'faces')
                labels(1, image_no) = 3;
            elseif strcmp(class, 'motorbikes')
                labels(1, image_no) = 4;
            end
            
            if strcmp(split, 'train')
               sets(1, image_no) = 1;
            elseif strcmp(split, 'test')
                sets(1, image_no) = 2;
            end
            
            image_no = image_no + 1;
        end
    end
end    


%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end