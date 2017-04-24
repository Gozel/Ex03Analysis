
%header;

data = gestures_data([1:960 1081:end-3],:);
[clean_data, indeces] = remove_outliers(cell2mat(data(:,11)));

% one-by-one factor analysis: one dependent variable (gaze) and one
% independent variable (gesture) with 13 factors
[p, tbl, stats] = kruskalwallis(clean_data, string(data(indeces,3)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

figure, 
hold on,
boxplot(cell2mat(data(indeces,11)), string(data(indeces,3))),
xlabel('Gesture'),
ylabel('EOR Time in secs'),
title('Eyes-Off-the-Roads Time across gestures'),
%set(gca, 'XTickLabel', GESTURES_SHORT),
xtickangle(45),
hold off;
saveas(gca,'figures/gaze_across_gestures','epsc');


% one-by-one factor analysis: one dependent variable (gaze) and one
% independent variable (conditions) with 4 factors
[p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,11)), string(data(indeces,2)), 'off');
fprintf('success rates of conditions. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});


figure, 
hold on,
boxplot(cell2mat(data(indeces,11)), (data(indeces,2))),
xlabel('Condition'),
ylabel('EOR Time in secs'),
title('Eyes-Off-the-Roads Time across conditions'),
%set(gca, 'XTickLabel', CONDITIONS),
%xtickangle(45),
hold off;
saveas(gca,'figures/gaze_across_conditions','epsc');

% figure, 
% hold on,
% hcon = boxplot(cell2mat(gestures_data(indeces,9)), (gestures_data(indeces,2))),
% xlabel('Gesture'),
% ylabel('Avg Gesture Duration in secs'),
% title('Avg Gesture Duration across Conditions'),
% %set(gca, 'XTickLabel', CONDITIONS),
% xtickangle(45),
% hold off;

% obtain all video start times aka gaze data start times
% because gaze data time starts with zero... 
% [k,l] = size(experiment_data);
% gaze_data_start_time = zeros(size(experiment_data));
% 
% for i = 1 : k
%     for j = 1 : l
%         gaze_data_start_time(k,l) = experiment_data{1,1}(2,1);
%     end
% end