function [model] = svm_train(data, targets)
    best = train(targets, sparse(data), '-C -q');
    model = train(targets, sparse(data), sprintf('-c %f', best(1)));
end