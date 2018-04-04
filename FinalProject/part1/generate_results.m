function generate_results()
    files = dir('./models/*.mat');
    for file = files'    
        load(fullfile('models', file.name), 'model');
        HTML_write(model);
    end
end