header;

% make sure extract_gestures_data.m was run before the execution of this
% script! 

index = 1;

for i = 3 : 3 %NO_PARTICIPANTS
   
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS
        
        cap_data = capacitive_data{i,j};
        
        while index <= length(gestures_data) - 3
            
            start_index = find(cap_data{:,2} <= CAPACITIVE_THRESHOLD & ...
                cap_data{:,1}  >= gestures_data{index,5}, 1, 'first');
            
%             while ~(cap_data{start_index - 1,2} > CAPACITIVE_THRESHOLD & ...
%                     cap_data{start_index + 1,2} > CAPACITIVE_THRESHOLD)
%                
%                 fprintf('old start index %f ', start_index);
%                 start_index = start_index + 1;
%                 fprintf('new start index %f\n', start_index);
%             end
            
            end_index = find(cap_data{start_index + 1:end,2} >= CAPACITIVE_THRESHOLD & ...
                cap_data{start_index + 1:end,1}  > gestures_data{index,5} & ...
                cap_data{start_index + 1:end,1}  <= gestures_data{index+1,5}, 1, 'first');
            
            end_index = end_index + start_index + 1;
            
%             while 500 > (cap_data{end_index,1} - cap_data{start_index,1})
%                 
%                 old_end_index = end_index;
%                 fprintf('current duration: %f ', cap_data{end_index,1} - cap_data{start_index,1});
%                 end_index = find(cap_data{old_end_index:end,2} >= CAPACITIVE_THRESHOLD & ...
%                     cap_data{old_end_index:end,1}  > gestures_data{index,5} & ...
%                     cap_data{old_end_index:end,1}  <= gestures_data{index+1,5}, 1, 'first');
%                 
%                 end_index = end_index + old_end_index;
%                 fprintf('new duration: %f\n', cap_data{end_index,1} - cap_data{start_index,1});
%             end
            
            if isempty(start_index)
                break;
            end
            
            gestures_data{index,8} = cap_data{start_index,1};
            gestures_data{index,9} = cap_data{end_index,1} - cap_data{start_index,1};
            index = index + 1;
        end
    end
end

save('gestures_data.mat', 'gestures_data');