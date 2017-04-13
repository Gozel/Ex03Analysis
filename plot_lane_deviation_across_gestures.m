
% make sure to run first: 
% analyse_lane_deviation_across_gestures;

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (gesture) with 13 factors
% [p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,10)), string(gestures_data(1:end-3,3)), 'off');
% fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% figure, 
% hold on,
% boxplot(cell2mat(gestures_data(1:end-3,10)), string(gestures_data(1:end-3,3))),
% xlabel('Gestures'),
% ylabel('Lane deviation in metres'),
% title('Lane deviation across gestures'),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/lane_dev_across_gestures','epsc');

% columns: gesture, mean lane dev, std lane dev, mean duration
gesture_means = cell(length(GESTURES), 4);

for i = 1 : length(GESTURES)
    indeces = find(strcmp(string(gestures_data(1:end-3,3)), GESTURES{i}));
    gesture_means(i,:) = {GESTURES(i), mean(cell2mat(gestures_data(indeces,10))), std(cell2mat(gestures_data(indeces,10))), mean(cell2mat(gestures_data(indeces,9)))};
end

% gesture_means(8,:) = [];
       
figure, 
hold on,
errorbar(cell2mat(gesture_means(:,2)),cell2mat(gesture_means(:,3)),'o','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red'),
xlabel('Gestures'),
ylabel('Lane deviation means in metres'),
title('Lane deviation means across gestures'),
set(gca, 'XTickLabel', string(gesture_means(:,1))),
xtickangle(45),
hold off;
saveas(gca,'figures/lane_dev_means_across_gestures','epsc');

row_labels = GESTURES;
column_labels = {'Mean Lane Dev', 'Std Lane Dev', 'Duration in ms'};
matrix2latex(cell2mat(gesture_means(:,2:end)), 'tables/lane_dev_gestures_means_stds.tex', ... 
    'rowLabels', row_labels, ...
    'columnLabels', column_labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'normalsize');
