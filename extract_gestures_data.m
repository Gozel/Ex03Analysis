%header;

index = 1;

gesture = {0,   ...     % pid
    0,          ...     % condition
    'INVALID',  ...     % expected gesture
    0,          ...     % success of gesture
    0.0,        ...     % instruction start
    0.0,        ...     % end of interaction
    ''};                % perfromed gestures
           

gestures_data = cell((NO_PARTICIPANTS - 1) * NO_CONDITIONS * NO_GESTURES, length(gesture));

% gestures_data.Properties.VariableNames = {'PID' 'Condition' 'Exp Gest' 'Success' ...
%    'Instruction Start' 'Hand Off' 'Duration' 'Attempts' 'Performed Gestures'};

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS
        
        data = experiment_data{i,j};
        
        for k = 1 : length(data{:,1}) - 1      
            
            % get expected gesture
            if ~strcmp('', string(data{k,3})) ...
                && ~strcmp('INVALID', string(data{k,3})) 

                gesture = {i, BLSQ(i,j), string(data{k,3}), 0, data{k,1}, data{k+1,1}, ''};
                index = index + 1;
                gestures_data(index, :) = gesture;
            elseif (~strcmp('', string(data{k,4})) ...
                && ~strcmp('INVALID', string(data{k,4}))) ...
                && ~isempty(gesture{3})
            
                gesture_performed = string(data{k,4});
                
                if ~contains(gesture_performed, 'FIST')
                    gesture{7} = strcat(string(gesture{7}), gesture_performed, '; ');
                end
                
                if contains(gesture_performed, gesture{3})    
                    gesture{4} = 1;
                end
                
                gesture{6} = data{k,1};
                gestures_data(index, :) = gesture;
            end
        end
    end
end

gestures_data{end-2,5} = experiment_data{20,4}{end-4,1};
gestures_data = gestures_data(2:end,:); % remove empty first line
save('gestures_data.mat', 'gestures_data');
