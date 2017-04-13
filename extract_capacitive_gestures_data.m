header;

% make sure extract_gestures_data.m was run before the execution of this
% script! 

index = 1; 
duration = 10;  % 20 lines of the capacitive data file are the equivalent of 
                % ~ 500 ms; 10 lines of output are ~250 ms
gestures_data(:,9) = [];

for i = 1 : NO_PARTICIPANTS
   
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS

        cap_data = capacitive_data{i,j};
        
        
        while index <= (length(gestures_data) - 3)
            
            start_index = 1;
            
            % find correct start index for hand off wheel 
            while CAPACITIVE_THRESHOLD < median(cap_data{start_index:start_index + duration,2})

                old_start_index = start_index;
                start_index = find(cap_data{old_start_index + 1:end,2} <= CAPACITIVE_THRESHOLD & ...
                cap_data{old_start_index + 1:end,1}  >= gestures_data{index,5} & ...
                cap_data{old_start_index + 1:end,1}  < gestures_data{index,6}, 1, 'first');

                start_index = old_start_index + start_index;
            end
            
            if 1465 == index || 1466 == index
                start_index = find(cap_data{old_start_index + 1:end,1}  >= gestures_data{index,5}, 1, 'first');
            end
            
            if isempty(start_index)
                break;
            end

            % find correct end index hand off wheel 
            end_index = start_index;
            while CAPACITIVE_THRESHOLD > median(cap_data{end_index:end_index + duration,2})

                old_end_index = end_index;
                end_index = find(cap_data{old_end_index + 1:end,2} > CAPACITIVE_THRESHOLD & ...
                    cap_data{old_end_index + 1:end,1}  < gestures_data{index+1,5} & ...
                     ifelse(~isempty(gestures_data{index,7}), cap_data{old_end_index + 1:end,1}  > (gestures_data{index,6}),1) ...
                     , 1, 'first');
                end_index = old_end_index + end_index;
            end

            gestures_data{index,8} = cap_data{start_index,1};
            gestures_data{index,9} = ifelse(~isempty(end_index) & start_index ~= end_index & ...
                (cap_data{end_index,1} - cap_data{start_index,1}) <= (gestures_data{index, 6} - gestures_data{index,5}), ...
                cap_data{end_index,1} - cap_data{start_index,1}, ...
                gestures_data{index,6} - cap_data{start_index, 1} );
            index = index + 1;
            
        end
    end
end

save('gestures_data.mat', 'gestures_data');

