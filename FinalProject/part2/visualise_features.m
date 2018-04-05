function visualise_features()

expdir = './data/cnn_assignment-lenet_50_50';

nets.fine_tuned = load(fullfile(expdir, 'net-epoch-50.mat')); nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net;
data = load(fullfile(expdir, 'imdb-caltech.mat'));


% replace loss with the classification as we will extract features
nets.pre_trained.layers{end}.type = 'softmax';
nets.fine_tuned.layers{end}.type = 'softmax';

[svm.pre_trained.trainset, svm.pre_trained.testset] = get_svm_data(data, nets.pre_trained);
[svm.fine_tuned.trainset,  svm.fine_tuned.testset] = get_svm_data(data, nets.fine_tuned);

o1 = svm.pre_trained.trainset;
o2 = svm.fine_tuned.trainset;

labels = ["airplanes" "cars" "faces" "motorbikes"];

my_tsne(o1.features, arrayfun(@(i) labels(o1.labels(i)),1:length(o1.labels)));
my_tsne(o2.features, arrayfun(@(i) labels(o2.labels(i)),1:length(o2.labels)));

end





function [trainset, testset] = get_svm_data(data, net)

trainset.labels = [];
trainset.features = [];

testset.labels = [];
testset.features = [];
for i = 1:size(data.images.data, 4)
    
    res = vl_simplenn(net, data.images.data(:,:,:, i));
    feat = res(end-3).x; feat = squeeze(feat);
    
    if(data.images.set(i) == 1)
        
        trainset.features = [trainset.features feat];
        trainset.labels   = [trainset.labels;  data.images.labels(i)];
        
    else
        
        testset.features = [testset.features feat];
        testset.labels   = [testset.labels;  data.images.labels(i)];
        
        
    end
    
end

trainset.labels = trainset.labels;
trainset.features = trainset.features';

testset.labels = testset.labels;
testset.features = testset.features';

end