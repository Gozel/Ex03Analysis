
data = gestures_data([1:960 1081:end-3],:);
[clean_data, indeces] = remove_outliers(cell2mat(data(:,9)));

% one-by-one factor analysis: one dependent variable (gesture duration) and one
% independent variable (gesture) with 13 factors
[p, tbl, stats] = kruskalwallis(clean_data, string(data(indeces,2)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

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

gaze_per_ges_per_con = zeros(14,4);

for i = 1 : length(gestures_data_numeric)
    gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}) = ...
        (gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}) + ...
        gestures_data_numeric{i,9}) / 2;
end

gaze_per_ges_per_con(8,:)  = [];
gaze_per_ges_per_con(14,:) = gaze_per_ges_per_con(7,:);
gaze_per_ges_per_con(7,:) = [];

figure, 
hold on, 
bar(gaze_per_ges_per_con)
xlabel('Conditions grouped by Gestures'),
ylabel('Duration in secs'),
title('Total Duration of Gestures during each Condition'),
colormap(jet(4)),
set(gca, 'XTickLabel', GESTURES_ALPHABET(1:end-1)),
% ylim([-0.5 4]),
%xlim([0 14]),
set(gca,'Xtick',1:1:13)
%set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
xtickangle(45),
legend(CONDITIONS);
hold off;
saveas(gca,'figures/gestures_duration_conditions','epsc');


[B, idx] = sort(string([gestures_data{:,3}]), 'ascend');
%indeces = idx;
A = gestures_data(idx,:);

figure, 
hold on,
boxplot(cell2mat(A(1:end-3,9)), string(A(1:end-3,2))),
xlabel('Gestures'),
ylabel('Lane deviation in metres'),
title('Lane deviation across gestures'),
set(gca, 'XTickLabel', GESTURES_ALPHABET),
%set(gca,'YLim',[0 2]),
xtickangle(45),
hold off;
saveas(gca,'figures/gestures_duration_across_conditions','epsc');


