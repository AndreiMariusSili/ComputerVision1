function analyse_results()
    files = dir('./models/*.mat');
    vocab_size = [400, 800, 1600, 2000, 4000];
    
    map_150_gray_keypoint = zeros(1,5);
    map_100_gray_keypoint = zeros(1,5);
    map_50_gray_keypoint = zeros(1,5);
    map_150_gray_dense = zeros(1,5);
    map_100_gray_dense = zeros(1,5);
    map_50_gray_dense = zeros(1,5);
    
    N = [200,400,600];
    map_RGB = zeros(1,3);
    map_normRGB = zeros(1,3);
    map_opponent = zeros(1,3);
    map_gray = zeros(1,3);
    
    for file = files'
        params = strsplit(file.name, '_');
        load(fullfile('models', file.name), 'model');
        if strcmp(params{1}, 'gray')
            idx = vocab_size == str2double(params{3});
            if strcmp(params{2}, 'keypoint')
                if strcmp(params{4}, '150.mat')
                    map_150_keypoint(idx) = model.map;
                end
                if strcmp(params{4}, '100.mat')
                    map_100_keypoint(idx) = model.map;
                end
                if strcmp(params{4}, '50.mat')
                    map_50_keypoint(idx) = model.map;
                end
            end
            
            if strcmp(params{2}, 'dense')
                if strcmp(params{4}, '150.mat')
                    map_150_dense(idx) = model.map;
                end
                if strcmp(params{4}, '100.mat')
                    map_100_dense(idx) = model.map;
                end
                if strcmp(params{4}, '50.mat')
                    map_50_dense(idx) = model.map;
                end
            end
        end
        
        n = strsplit(params{4}, '.');
        n = str2double(n{1}) * 4;
        idxx = N == n;
        
        if strcmp(params{1}, 'gray')
            if strcmp(params{2}, 'dense')
                map_gray(idxx) = model.map;
            end
        end
        if strcmp(params{1}, 'RGB')
            if strcmp(params{2}, 'dense')
                map_RGB(idxx) = model.map;
            end
        end
        if strcmp(params{1}, 'normRGB') 
            if strcmp(params{2}, 'dense')
                map_normRGB(idxx) = model.map;
            end
        end
        if strcmp(params{1}, 'opponent')
            if strcmp(params{2}, 'dense')
                map_opponent(idxx) = model.map;
            end
        end
    end
    
    figure;
    hold on;
    plot(vocab_size, map_150_keypoint, '-or', 'LineWidth', 2);
    plot(vocab_size, map_100_keypoint, '-dg', 'LineWidth', 2);
    plot(vocab_size, map_50_keypoint, '-sb', 'LineWidth', 2);
    title('Mean Average Precision using Keypoint Descriptors')
    xlabel('Vocabulary Size')
    ylabel('MAP')
    ylim([0.8,1])
    legend('N=600', 'N=400', 'N=200');
    hold off;
    print('figures/map_keypoint', '-dpng')
    
    figure;
    hold on;
    plot(vocab_size, map_150_dense, '-or', 'LineWidth', 2);
    plot(vocab_size, map_100_dense, '-dg', 'LineWidth', 2);
    plot(vocab_size, map_50_dense, '-sb', 'LineWidth', 2);
    title('Mean Average Precision using Dense Descriptors')
    xlabel('Vocabulary Size')
    ylabel('MAP')
    ylim([0.8,1])
    legend('N=600', 'N=400', 'N=200', 'Location', 'southeast');
    hold off;
    print('figures/map_dense', '-dpng')
    
    figure;
    hold on;
    plot(N, map_RGB, '-or', 'LineWidth', 2);
    plot(N, map_normRGB, '-dg', 'LineWidth', 2);
    plot(N, map_opponent, '-sb', 'LineWidth', 2);
    plot(N, map_gray, '-^k', 'LineWidth', 2);
    title('Mean Average Precision using Colour-SIFT')
    xlabel('Training Set Size')
    ylabel('MAP')
    legend('RGB', 'rgb', 'opponent', 'gray', 'Location', 'southeast');
    hold off;
    print('figures/map_colour', '-dpng')
end