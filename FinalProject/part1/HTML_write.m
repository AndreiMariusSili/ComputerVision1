function HTML_write(model)

    student1 = "Ruben-Laureniu Grab";
    student2 = "Andrei Marius Sili";

                        
    sift_step_size = '10'; % NOT SURE
    sift_block_sizes= 'default'; % NOT SURE
    sift_method= model.faces.type;
    sift_colour = model.faces.colour;
    vocabulaty_size= string(model.faces.vocab_size);
    sift_positive= string(model.faces.train_data_size);
    sift_negative= string(model.faces.train_data_size*3);
    sift_kernel_type= 'Linear';
    
    mAP = string(model.map);
    airplanes_mAP = string(model.airplanes.avg_prec);
    cars_mAP = string(model.cars.avg_prec);
    faces_mAP = string(model.faces.avg_prec);
    motorbikes_mAP = string(model.motorbikes.avg_prec);
    
    
    no_test_files = model.faces.no_test_data;
    
    sorted_airplanes_paths = model.airplanes.sorted_paths;
    sorted_cars_paths = model.cars.sorted_paths;
    sorted_faces_paths = model.faces.sorted_paths;
    sorted_motorbikes_paths = model.motorbikes.sorted_paths;
    
    
    filename = strcat('results','_',model.faces.colour,'_',model.faces.type,'_',string(model.faces.vocab_size),'_',string(model.faces.train_data_size), '.html');
    if ~exist('results', 'dir')
        mkdir('results')
    end
    fid=fopen(fullfile('results',char(filename)),'w');
    
    fprintf(fid, '<!DOCTYPE html>\n');
    fprintf(fid, '<html lang="en">\n');
        fprintf(fid, '\t<head>\n');
            fprintf(fid, '\t\t<meta charset="utf-8">\n');
            fprintf(fid, '\t\t<title>Image list prediction</title>\n');
            fprintf(fid, '\t\t<style type="text/css">\n');            
                fprintf(fid, '\t\t\timg {\n');            
                    fprintf(fid, '\t\t\t\twidth:200px;\n');            
                fprintf(fid, '\t\t\t}\n');
            fprintf(fid,'\t\t</style>\n');
        fprintf(fid, '\t</head>\n');
        fprintf(fid, '\t<body>\n');
            fprintf(fid, '\t\t<h2>%s, %s</h2>\n', student1, student2);
            fprintf(fid, '\t\t<h1>Settings</h1>\n');
            fprintf(fid, '\t\t<table>\n');
                fprintf(fid, '\t\t\t<tr><th>SIFT step size</th><td>%s px</td></tr>\n',sift_step_size);
                fprintf(fid, '\t\t\t<tr><th>SIFT block sizes</th><td>%s</td></tr>\n', sift_block_sizes);
                fprintf(fid, '\t\t\t<tr><th>SIFT method</th><td>%s-SIFT</td></tr>\n', sift_method);
                fprintf(fid, '\t\t\t<tr><th>SIFT colour</th><td>%s</td></tr>\n', sift_colour);
                fprintf(fid, '\t\t\t<tr><th>Vocabulary size</th><td>%s words</td></tr>\n', vocabulaty_size);
                fprintf(fid, '\t\t\t<tr><th>SVM training data</th><td>%s positive, %s negative per class</td></tr>\n',sift_positive, sift_negative);
                fprintf(fid, '\t\t\t<tr><th>SVM kernel type</th><td>%s</td></tr>\n',sift_kernel_type);
            fprintf(fid, '\t\t</table>\n');
            fprintf(fid, '\t\t<h1>Prediction lists (MAP: %s)</h1>\n',mAP);
            fprintf(fid, '\t\t<table>\n');
                fprintf(fid, '\t\t\t<thead>\n');
                    fprintf(fid, '\t\t\t\t<tr>\n');
                        fprintf(fid, '\t\t\t\t\t<th>Nr.Ctr</th>\n',airplanes_mAP);
                        fprintf(fid, '\t\t\t\t\t<th>Airplanes (AP: %s)</th>\n',airplanes_mAP);
                        fprintf(fid, '\t\t\t\t\t<th>Cars (AP: %s)</th>\n', cars_mAP);
                        fprintf(fid, '\t\t\t\t\t<th>Faces (AP: %s)</th>\n', faces_mAP);
                        fprintf(fid, '\t\t\t\t\t<th>Motorbikes (AP: %s)</th>\n', motorbikes_mAP);
                    fprintf(fid, '\t\t\t\t</tr>\n');
                fprintf(fid, '\t\t\t</thead>\n');
                fprintf(fid, '\t\t\t<tbody>\n');
                    for i=1:no_test_files
                        fprintf(fid, '\t\t\t\t<tr>\n');
                        fprintf(fid, '\t\t\t\t\t<td>%d</td>\n', i);
                        fprintf(fid, '\t\t\t\t\t<td><img src="..\\%s" /></td>\n', sorted_airplanes_paths(i));
                        fprintf(fid, '\t\t\t\t\t<td><img src="..\\%s" /></td>\n', sorted_cars_paths(i));
                        fprintf(fid, '\t\t\t\t\t<td><img src="..\\%s" /></td>\n', sorted_faces_paths(i));
                        fprintf(fid, '\t\t\t\t\t<td><img src="..\\%s" /></td>\n', sorted_motorbikes_paths(i));
                        fprintf(fid, '\t\t\t\t</tr>\n');
                    end
                fprintf(fid, '\t\t\t</tbody>\n');
            fprintf(fid, '\t\t</table>\n');
        fprintf(fid, '\t</body>\n');
    fprintf(fid, '</html>\n'); 

    fclose(fid);
end