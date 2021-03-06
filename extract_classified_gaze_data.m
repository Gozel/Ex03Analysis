%header;

gestures_data(:,11) = {0};
gestures_data(:,12) = {0};
gestures_data(:,13) = {0};
gestures_data(:,14) = {0};

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i 
        continue;
    end
    
    for j = 1 : NO_CONDITIONS

        gaze = gaze_data{i, j};
        
        start_time_stamp = experiment_data{i,j}{find(strcmp('VC start', string(experiment_data{i,j}{:,2})),1,'first'),1}; 
        end_time_stamp = experiment_data{i,j}{find(strcmp('VC pause true', string(experiment_data{i,j}{:,2})),1,'last'),1}; 
        
        time_stamp_gaze = linmap(gaze{:,2}*1000, [start_time_stamp, end_time_stamp]);
        
        start_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'first');
        end_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'last');
        
        for k = start_index : end_index
                
            l = 1;
            while time_stamp_gaze(l) < gestures_data{k,8}
                l = l + 1;
            end
            gaze_start = l - 1;
            
            while time_stamp_gaze(l) < gestures_data{k,8} + gestures_data{k,9} && l < length(time_stamp_gaze)
                l = l + 1;
            end
            gaze_end = l - 1;
            
            for l = gaze_start : gaze_end
                
                gestures_data{k,11} = gestures_data{k,11} + ifelse(1 ~= gaze{l,17}, gaze{l+1,2} - gaze{l,2}, 0);  
                
                % count number of glances and save in column 12
                if gaze{l -1,17} == 1 && gaze{l,17} == 0 && gaze{l + 1,17} == 0
                    gestures_data{k,12} = gestures_data{k,12} + 1;  
                end
            end
            
            % avoid dividing by zero in the next step
            if gestures_data{k,11} > 0 && gestures_data{k,12} == 0
                gestures_data{k,12} = 1;
            end
            
            % get mean duration of glances and save in column 13
            if gestures_data{k,11} ~= 0 && gestures_data{k,12} ~= 0
                gestures_data{k,13} = gestures_data{k,11} / gestures_data{k,12};
            end
            
            % get average time between glances towards device 
            if gestures_data{k,12} > 1
                gestures_data{k,14} = (gaze{gaze_end, 1} - gaze{gaze_start, 1} - gestures_data{k,11}) / gestures_data{k,12};  
            end
        end
        fprintf('i: %d j: %d\n', i, j);
    end
end

save('gestures_data.mat', 'gestures_data');
