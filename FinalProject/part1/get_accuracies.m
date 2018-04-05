function get_accuracies()
    files = dir('./models/*.mat');
    
    N = [150 100 50];
    
    figure;
    hold on;
    
    list = [];
    for file = files'    
        load(fullfile('models', file.name), 'model');
        accuracy = (model.motorbikes.accuracy + model.cars.accuracy + model.faces.accuracy + model.airplanes.accuracy)/4;
        filename = strcat('accurac','_',model.faces.colour,'_',model.faces.type,'_',string(model.faces.vocab_size),'_',string(model.faces.train_data_size), '.html');
        display(filename + ": " + accuracy )
        
        if model.faces.vocab_size == 2000
            accuracy = accuracy/100;
            list = [list, accuracy];
            if model.faces.train_data_size == 50
                
                
                plot(N, list, 'LineWidth', 2);
                list = [];
            end
            
        end
        
    end
    under = 0.001;
    
    y = 0.99;
    line([50,150],[y,y])
    txt1 = 'CNN([batch, epochs]=[50,50])';
    text(50,y-under,txt1)
    
    y = 0.98;
    line([50,150],[y,y])
    txt1 = 'CNN([batch, epochs]=[50,80],[50,100])';
    text(50,y-under,txt1)
    
    y = 0.97;
    line([50,150],[y,y])
    txt1 = 'CNN([batch, epochs]=[50,40],[100,40],[100,50])';
    text(50,y-under,txt1)


    title('Mean Accuracy(vocabulary size = 2000)')
    xlabel('Training Set Size')
    ylabel('Accuracy')
    legend('RGB', 'Opponent', 'rgb', 'Gray Keypoints','Gray Dense', 'Location', 'southeast');
    hold off;
end
