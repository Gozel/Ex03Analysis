header;

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS

        % data = gaze_data{i, j};
        
        for k = 1 : height(gaze_data{i,j})
            
            gaze_data{i,j}{k,17} = predict(svmmod, gaze_data{i,j}{k,5:10});
        end
    end
end

save('gaze_data.mat', 'gaze_data');
