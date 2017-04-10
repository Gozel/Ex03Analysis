header;

gesture_expected = '';
gesture_performed = '';
gesture_start = 0.0;
index = 1;
hand_off = 1;
hand_on = 1;
toggle = 0;

gesture = {0,   ...     % pid
    0,          ...     % condition
    'INVALID',  ...     % expected gesture
    0,          ...     % success of gesture
    0.0,        ...     % instruction start
    0.0,        ...     % hand off wheel start
    0.0,        ...     % gesture duration for hand off till on wheel
    0,          ...     % number of attempts to perform gesture correctly
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
        hand = capacitive_data{i,j};
        
        for k = 1 : length(data{:,1})       
            
            if (strcmp('', string(data{k,3})) ...
                || strcmp('INVALID', string(data{k,3}))) ...
                && ~isempty(gesture_expected)
            
                gesture_performed = string(data{k,4});
                    
                %fprintf('expected: %s performed: %s\n', gesture_expected, gesture_performed);
                
                if ~contains(gesture_performed, 'INVALID') ...
                        && ~contains(gesture_performed, 'FIST')
                    gesture{9}= strcat(string(gesture{9}), gesture_performed, '; ');
                end
                
                if contains(gesture_performed, gesture_expected)    
                    gesture{4}= 1;
                end
            
            % get next expected gesture
            elseif ~strcmp('', string(data{k,3})) ...
                && ~strcmp('INVALID', string(data{k,3}))
             
                % find hand off index for current gesture
                while hand_off < length(hand{:,1}) - 1 ...
                        && hand{hand_off, 1} <= cell2mat(gesture(5)) 
                    hand_off = hand_off + 1; 
                end

                % find correct hand off index for current gesture
                while hand_off < length(hand{:,1}) - 1 ...
                        && hand{hand_off, 2} > CAPACITIVE_THRESHOLD
                    hand_off = hand_off + 1; 
                end

                gesture(6) = {hand{hand_off,1}};

                hand_on = hand_off + 1;
                while hand_on < length(hand{:,1}) - 1 ...
                        && hand{hand_on, 1} < data{k,1}
                    hand_on = hand_on + 1; 
                end

                for l = hand_off : hand_on
                   if hand{l,2} > CAPACITIVE_THRESHOLD

                       if 500 < hand{l,1} - hand{hand_off,1}
                           gesture(7) = {hand{l,1} - hand{hand_off,1}}; % add overall duration 
                           hand_off = hand_on + 1;
                           gesture(8) = {cell2mat(gesture(8)) + 1};
                           continue;
                       end
                   end
                end
                analysed = 1;
            end
            %gesture(7) = {hand{hand_on,1} - hand{hand_off,1}};
            gestures_data(index, :) = gesture;
            index = index + 1;

            % reset values
            gesture_expected = string(data{k,3});
            gesture_instruction_start = data{k,1};

            gesture = {i, j, gesture_expected, 0, gesture_instruction_start, 0.0, 0.0, 0, ''};
            hand_on = 1;
            hand_off = 1;
            
        end
    end
end

gestures_data = gestures_data(2:end,:); % remove empty first line
save('gestures_data.mat', 'gestures_data');
