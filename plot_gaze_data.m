
%header;

data = gestures_data([1:960 1081:end-3],:);
[clean_data, indeces] = remove_outliers(cell2mat(data(:,11)));

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
        gestures_data_numeric{i,11}) / 2;
end

gaze_per_ges_per_con(8,:)  = [];
gaze_per_ges_per_con(14,:) = gaze_per_ges_per_con(7,:);
gaze_per_ges_per_con(7,:) = [];

figure, 
hold on, 
bar(gaze_per_ges_per_con)
xlabel('Total EORT per Gesture per Condition'),
ylabel('EORT in secs'),
title('Total EORT over Gestures and Conditions'),
colormap(jet(4)),
set(gca, 'XTickLabel', GESTURES_ALPHABET(1:end-1)),
% ylim([-0.5 4]),
%xlim([0 14]),
set(gca,'Xtick',1:1:13)
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
xtickangle(45),
legend(CONDITIONS);
hold off;
saveas(gca,'figures/gaze_across_gestures_conditions','epsc');

% figure, 
% hold on,
% boxplot(cell2mat(A(idxVF,11)), string(A(idxVF,3))),
% xlabel('Gesture'),
% ylabel('EOR Time in secs'),
% title('EORT in VF across Gestures'),
% set(gca, 'XTickLabel', GESTURES_ALPHABET),
% ylim([-0.5 4]),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/gaze_across_gestures_VF','epsc');
% 
% figure, 
% hold on,
% boxplot(cell2mat(A(idxAF,11)), string(A(idxAF,3))),
% xlabel('Gesture'),
% ylabel('EOR Time in secs'),
% title('EORT in AF across Gestures'),
% set(gca, 'XTickLabel', GESTURES_ALPHABET),
% ylim([-0.5 4]),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/gaze_across_gestures_AF','epsc');
% 
% figure, 
% hold on,
% boxplot(cell2mat(A(idxPALF,11)), string(A(idxPALF,3))),
% xlabel('Gesture'),
% ylabel('EOR Time in secs'),
% title('EORT in PALF across Gestures'),
% set(gca, 'XTickLabel', GESTURES_ALPHABET),
% ylim([-0.5 4]),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/gaze_across_gestures_PALF','epsc');
% 
% figure, 
% hold on,
% boxplot(cell2mat(A(idxTF,11)), string(A(idxTF,3))),
% xlabel('Gesture'),
% ylabel('EOR Time in secs'),
% title('EORT in TF across Gestures'),
% set(gca, 'XTickLabel', GESTURES_ALPHABET),
% ylim([-0.5 4]),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/gaze_across_gestures_TF','epsc');

% one-by-one factor analysis: one dependent variable (gaze) and one
% independent variable (conditions) with 4 factors
% [p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,11)), string(data(indeces,2)), 'off');
% fprintf('success rates of conditions. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});
% 
% 
% figure, 
% hold on,
% boxplot(cell2mat(data(indeces,11)), (data(indeces,2))),
% xlabel('Condition'),
% ylabel('EOR Time in secs'),
% title('Eyes-Off-the-Roads Time across conditions'),
% %set(gca, 'XTickLabel', CONDITIONS),
% %xtickangle(45),
% hold off;
% saveas(gca,'figures/gaze_across_conditions','epsc');

% figure, 
% hold on,
% hcon = boxplot(cell2mat(A(:,9)), (A(:,2))),
% xlabel('Gesture'),
% ylabel('Avg Gesture Duration in secs'),
% title('Avg Gesture Duration across Conditions'),
% %set(gca, 'XTickLabel', CONDITIONS),
% xtickangle(45),
% hold off;
% 
% stats = grpstats(cell2mat(A(:,9)), string(A(:,3)))

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