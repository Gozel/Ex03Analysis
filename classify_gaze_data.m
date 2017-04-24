%header;

%gaze_data{i,j}{:,17} = [0];

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i 
        continue;
    end
       
    for j = 1 : NO_CONDITIONS

        for k = 1 : height(gaze_data{i,j})
            
            gaze_data{i,j}{k,17} = and(gaze_data{i,j}{k,4} ,predict(svmmod_pose_john, gaze_data{i,j}{k,[5:10 14:16]}));
        end
        
        fprintf('i: %d j: %d\n', i, j);
    end
end

save('gaze_data.mat', 'gaze_data');
