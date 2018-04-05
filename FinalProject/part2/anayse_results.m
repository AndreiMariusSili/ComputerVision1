function anayse_results()

    number_of_epochs = [40, 50, 80, 100];
    
%   Values were extracted using the code provided in main.m
    CNN = [ 0.97, 0.99, 0.98, 0.98];
    SVM_PT = [ 0.945, 0.940, 0.95, 0.945];
    SVM_FT = [ 0.975, 0.965, 0.975, 0.975];

    figure;
    hold on;
    plot(number_of_epochs, CNN, '-or', 'LineWidth', 2);
    plot(number_of_epochs, SVM_PT, '-dg', 'LineWidth', 2);
    plot(number_of_epochs, SVM_FT, '-sb', 'LineWidth', 2);
    title('Accuracy')
    xlabel('Number of epochs')
    ylabel('Accuracy')
    ylim([0.8,1])
    legend('CNN', 'SVM:Pre-Trained', 'SVM:Fine-Tuned', 'Location', 'southeast');
    hold off;
%     print('figures/accuracy_50_batch', '-dpng')

%   Values were extracted using the code provided in main.m
    CNN = [0.97, 0.97, 0.98, 0.98];
    SVM_PT = [0.94, 0.94, 0.945, 0.945];
    SVM_FT = [0.955, 0.985, 0.975, 0.970];
    
    figure;
    hold on;
    plot(number_of_epochs, CNN, '-or', 'LineWidth', 2);
    plot(number_of_epochs, SVM_PT, '-dg', 'LineWidth', 2);
    plot(number_of_epochs, SVM_FT, '-sb', 'LineWidth', 2);
    title('Accuracy')
    xlabel('Number of epochs')
    ylabel('Accuracy')
    ylim([0.8,1])
    legend('CNN', 'SVM:Pre-Trained', 'SVM:Fine-Tuned', 'Location', 'southeast');
    hold off;
%     print('figures/accuracy_100_batch', '-dpng')
end