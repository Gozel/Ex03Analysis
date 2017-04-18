header;

gestures_data(:,11) = {0};

for i = 3 : 3 %NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS

        gaze = gaze_data{i, j};
        
        time_stamp = experiment_data{i,j}{2,1};
        
        start_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'first');
        end_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'last');
        
        for k = start_index : end_index
                
            l = 1;
            while (gaze{l,2} * 1000 + time_stamp) < gestures_data{k,8}
                l = l + 1;
            end
            gaze_start = l;
            
            while (gaze{l,2} * 1000 + time_stamp) < gestures_data{k,8} + gestures_data{k,9}
                l = l + 1;
            end
            gaze_end = l;
            
%             gaze_start = find((gaze{:,2}+time_stamp) >= gestures_data{k,8}, 1, 'first');
%             gaze_end = find((gaze{:,2}+time_stamp) <= (gestures_data{k,8} + gestures_data{k,9}), 1, 'last');

            fprintf('i: %d, j: %d, k: %d, gaze start: %d, gaze end: %d\n', i, j, k, gaze_start, gaze_end);
            
            for l = gaze_start : gaze_end
              gestures_data{k,11} = gestures_data{k,11} + ifelse(0 == gaze{l,17}, gaze{l+1,2} - gaze{l,2}, 0);  
            end
        end
    end
end

save('gestures_data.mat', 'gestures_data');
