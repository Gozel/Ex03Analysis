

%header;

data = gestures_data([1:960 1081:end-3],:);
[clean_data, indeces] = remove_outliers(cell2mat(data(:,10)));

% one-by-one factor analysis: one dependent variable (gaze) and one
% independent variable (gesture) with 13 factors
% [p, tbl, stats] = kruskalwallis(clean_data, string(data(indeces,3)), 'off');
% fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});
% 
tmp = data(indeces,:);
[B, idx] = sort(string(tmp(:,3)), 'ascend');
%indeces = idx;
A = tmp(idx,:);

gestures_data_numeric = A;

for i = 1 : length(A)
    
    for j = 1 : length(GESTURES)
        
        if strcmp(string(GESTURES{j}),string(A{i,3}))
            gestures_data_numeric{i,3} = j;
        end
    end
end

% [means, sem, ocunts, gname] = grpstats(cell2mat(gestures_data_numeric(:,11)),cell2mat( gestures_data_numeric(:,3)));
% 
% idxVF = find(1 == [A{:,2}]);
% idxAF = find(2 == [A{:,2}]);
% idxPALF = find(3 == [A{:,2}]);
% idxTF = find(4 == [A{:,2}]);

gaze_per_ges_per_con = zeros(14,4);

for i = 1 : length(gestures_data_numeric)
    gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}) = ...
        (gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}) + ...
        gestures_data_numeric{i,10}) / 2;
end

gaze_per_ges_per_con(8,:)  = [];
gaze_per_ges_per_con(14,:) = gaze_per_ges_per_con(7,:);
gaze_per_ges_per_con(7,:) = [];

figure, 
hold on, 
bar(gaze_per_ges_per_con)
xlabel('Gestures grouped by conditions'),
ylabel('Lane deviation in metres'),
title('Total Lane Devition over Gestures and Conditions'),
colormap(jet(4)),
set(gca, 'XTickLabel', GESTURES_ALPHABET(1:end-1)),
% ylim([-0.5 4]),
%xlim([0 14]),
set(gca,'Xtick',1:1:13)
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
xtickangle(45),
legend(CONDITIONS);
hold off;
saveas(gca,'figures/lane_dev_across_gestures_conditions','epsc');


% make sure to run first: 
% analyse_lane_deviation_across_gestures;

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (gesture) with 13 factors
% [p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,10)), string(gestures_data(1:end-3,3)), 'off');
% fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

[B, idx] = sort(string([gestures_data{:,3}]), 'ascend');
%indeces = idx;
A = gestures_data(idx,:);

figure, 
hold on,
boxplot(cell2mat(A(1:end-3,10)), string(A(1:end-3,3))),
xlabel('Gestures'),
ylabel('Lane deviation in metres'),
title('Lane deviation across gestures'),
set(gca, 'XTickLabel', GESTURES_ALPHABET),
set(gca,'YLim',[0 2]),
xtickangle(45),
hold off;
saveas(gca,'figures/lane_dev_across_gestures','epsc');

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
set(gca, 'XTickLabel', GESTURES_SHORT),
set(gca,'XLim',[0 15]),
set(gca,'XTick',[1:1:14]),
xtickangle(45),
hold off;
saveas(gca,'figures/lane_dev_means_across_gestures','epsc');

row_labels = GESTURES_SHORT;
column_labels = {'Mean Lane Dev', 'Std Lane Dev', 'Duration in ms'};
matrix2latex(cell2mat(gesture_means(:,2:end)), 'tables/lane_dev_gestures_means_stds.tex', ... 
    'rowLabels', row_labels, ...
    'columnLabels', column_labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'normalsize');
