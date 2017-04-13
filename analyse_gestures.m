header;

% absolutely correctly executed gestures
correct_gesture_execution_table = cell2mat(gestures_data(:,4));
correct_gesture_execution_rate = sum(correct_gesture_execution_table);
correct_gesture_execution_percentage = correct_gesture_execution_rate / length(correct_gesture_execution_table) * 100;

correct_gesture_execution_individual = zeros(NO_PARTICIPANTS, NO_CONDITIONS);
for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS
        
%         tmp = find();
%         correct_gesture_execution_individual(i,j) 
    end
end

% gestures thought to be executed correctly
perceived_correct_gesture_execution_table = string(gestures_data(1:end-3,7));
perceived_correct_gesture_execution_rate = 0;
for i = 1 : length(perceived_correct_gesture_execution_table)
    if ~strcmp('', perceived_correct_gesture_execution_table(i))
        perceived_correct_gesture_execution_rate = perceived_correct_gesture_execution_rate  + 1;
    end
end

perceived_correct_gesture_execution_percentage = perceived_correct_gesture_execution_rate / length(perceived_correct_gesture_execution_table) * 100;

% gesture execution correctness per gesture
[~, sorted_indeces] = sort(string(gestures_data(1:end-3,3)));

