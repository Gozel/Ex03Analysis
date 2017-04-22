%header;

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i %|| 5 == i
        continue;
    end
       
    for j = 1 : NO_CONDITIONS

        for k = 1 : height(gaze_data{i,j})
            
            gaze_data{i,j}{k,17} = predict(md2, gaze_data{i,j}{k,5:10});
        end
        
        fprintf('i: %d j: %d\n', i, j);
    end
end

save('gaze_data.mat', 'gaze_data');
