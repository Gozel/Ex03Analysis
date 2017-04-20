% header;

for i = 13 : 13 % NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
%     idx = find(i == gestures_data{:,1}, 1, 'first');
%     start_time_stamp = experiment_data{i,1}{find(~strcmp('', string(experiment_data{i,j}{:,3})) && ~strcmp('INVALID', string(experiment_data{i,j}{:,3})),1,'first'),1}; 
%     
%     idx = linmap(gaze_data{i,1}{:,2}*1000, [1,start_time_stamp]);

    idx = 841;
    
    x1 = gaze_data{i,2}{1:idx, 5};
    y1 = gaze_data{i,2}{1:idx ,6};

    v1 = convhull(x1,y1);

    x2 = gaze_data{i,2}{1:idx, 8};
    y2 = gaze_data{i,2}{1:idx ,9};

    v2 = convhull(x2,y2);
    
    for j = 1 : NO_CONDITIONS

        
        % data = gaze_data{i, j};
        
        for k = 1 : height(gaze_data{i,j})
            
            [in1,on1] = inpolygon(gaze_data{i,j}{k, 5}, gaze_data{i,j}{k, 6}, x1(v1), y1(v1));
            [in2,on2] = inpolygon(gaze_data{i,j}{k, 8}, gaze_data{i,j}{k, 9}, x2(v2), y2(v2));
            gaze_data{i,j}{k,17} = and(or(or(in1,on1),or(in2,on2)), gaze_data{i,j}{k,4});
            % predict(svmmod_x, [gaze_data{i,j}{k,5},gaze_data{i,j}{k,5}]);
        end
        
        fprintf('i: %d j: %d\n', i, j);
    end
end

save('gaze_data.mat', 'gaze_data');
