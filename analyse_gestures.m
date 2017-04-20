header;

% absolutely correctly executed gestures
% correct_gesture_execution_table = cell2mat(gestures_data(:,4));
% correct_gesture_execution_rate = sum(correct_gesture_execution_table);
% correct_gesture_execution_percentage = correct_gesture_execution_rate / length(correct_gesture_execution_table) * 100;
% 
% correct_gesture_execution_individual = zeros(NO_PARTICIPANTS, NO_CONDITIONS);
% for i = 1 : NO_PARTICIPANTS
%     
%     % skipping participant 2 
%     if 2 == i
%         continue;
%     end
%     
%     for j = 1 : NO_CONDITIONS
%         
% %         tmp = find();
% %         correct_gesture_execution_individual(i,j) 
%     end
% end
 
% % gesture execution correctness per gesture
% [~, sorted_indeces] = sort(string(gestures_data(1:end-3,3)));

% one-by-one factor analysis: one dependent variable (gesture duration) and one
% independent variable (condition) with 4 factors
% [p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,9)), cell2mat(gestures_data(1:end-3,2)), 'off');
% fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});
% 
% [p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,9)), string(gestures_data(1:end-3,3)), 'off');
% fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

