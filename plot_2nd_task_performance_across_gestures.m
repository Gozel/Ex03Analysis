header;

% make sure to run first: 
% analyse_lane_deviation_across_gestures;

% one-by-one factor analysis: one dependent variable (success rate) and one
% independent variable (gesture) with 13 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,4)), string(gestures_data(1:end-3,3)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% one-by-one factor analysis: one dependent variable (success rate) and one
% independent variable (condition) with 4 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,4)), string(gestures_data(1:end-3,2)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% columns: 2nd task performance across gestures
% gesture_success_rates = cell(length(GESTURES), 2);
% 
% for i = 1 : length(GESTURES)
%     indeces = find(strcmp(string(gestures_data(1:end-3,3)), GESTURES{i}));
%     gesture_success_rates(i,:) = {GESTURES(i), sum(cell2mat(gestures_data(indeces,4))) / length(gestures_data(indeces,4)) * 100};
% end

% columns: 2nd task performance across gestures
gesture_success_rates_condition = cell(NO_CONDITIONS, 2, 3);

for i = 1 : NO_CONDITIONS % length(GESTURES)
    indeces = find(cell2mat(gestures_data(1:end-3,2)) == i);
    gesture_success_rates_condition(i,:) = {CONDITIONS(i), sum(cell2mat(gestures_data(indeces,4))) / length(gestures_data(indeces,4)) * 100};
end

row_labels = CONDITIONS;
column_labels = {'Gesture success rate'};
matrix2latex(cell2mat(gesture_success_rates_condition(:,2:end)), 'tables/gesture_success_rates_across_conditions.tex', ... 
    'rowLabels', row_labels, ...
    'columnLabels', column_labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'normalsize');
