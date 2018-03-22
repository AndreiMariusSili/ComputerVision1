function [predicted_labels, accuracy, dec_val] = svm_predict(data, targets, model)
    [predicted_labels, accuracy, dec_val] = predict(targets, sparse(data), model);
end