
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

gestures_data_numeric = data(indeces, :); %A;

for i = 1 : length(data)
    
    for j = 1 : length(GESTURES)
        
        if strcmp(string(GESTURES{j}),string(data{i,3}))
            gestures_data_numeric{i,3} = j;
        end
    end
end

% [means, sem, ocunts, gname] = grpstats(cell2mat(gestures_data_numeric(:,9)), cell2mat( gestures_data_numeric(:,3)));

% gaze_per_ges_per_con = {14,4};

% for i = 1 : length(gestures_data_numeric)
%     gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}) = ...
%         {gaze_per_ges_per_con(gestures_data_numeric{i,3}, gestures_data_numeric{i,2}), ...
%         gestures_data_numeric{i,11}};
% end
% 
% gaze_per_ges_per_con(8,:)  = [];
% gaze_per_ges_per_con(14,:) = gaze_per_ges_per_con(7,:);
% gaze_per_ges_per_con(7,:) = [];

% figure, 
% hold on,
% grid on,
% bar(gaze_per_ges_per_con)
% %xlabel('Conditions grouped by Gestures'),
% ylabel('EORT in secs'),
% title('Total EORT per Gesture during Conditions'),
% colormap(jet(4)),
% set(gca, 'XTickLabel', GESTURES_ALPHABET(1:end-1)),
% % ylim([-0.5 4]),
% %xlim([0 14]),
% set(gca,'Xtick',1:1:13)
% set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 30 20])
% xtickangle(45),
% legend(CONDITIONS);
% hold off;
% saveas(gca,'figures/gaze_across_gestures_conditions','epsc');


%% influence of gaze behaviour on primary task

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (total gaze) 
[p, tbl, stats] = kruskalwallis(clean_data, cell2mat(data(indeces,11)), 'off');
fprintf('total gaze on lane dev: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (number of glances) 
[p, tbl, stats] = kruskalwallis(clean_data, cell2mat(data(indeces,12)), 'off');
fprintf('number of glances on lane dev: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (avg duration of glances) 
[p, tbl, stats] = kruskalwallis(clean_data, cell2mat(data(indeces,13)), 'off');
fprintf('avg duration of glances on lane dev: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (avg duration of glances) 
[p, tbl, stats] = kruskalwallis(clean_data, cell2mat(data(indeces,14)), 'off');
fprintf('avg duration of time between glances on lane dev: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});


%% influence of gaze on 2nd task performance

[p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,4)), cell2mat(data(indeces,11)), 'off');
fprintf('gaze duration on 2nd task performance: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

[p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,4)), cell2mat(data(indeces,12)), 'off');
fprintf('number of glances on 2nd task performance: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

[p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,4)), cell2mat(data(indeces,13)), 'off');
fprintf('avg glance duration on 2nd task performance: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

[p, tbl, stats] = kruskalwallis(cell2mat(data(indeces,4)), cell2mat(data(indeces,14)), 'off');
fprintf('avg time between glances 2nd task performance: p = %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

%% correlation between glances and gestures

[tbl,chi2stat,p] = crosstab(cell2mat(gestures_data_numeric(:,3)),cell2mat(data(:,11)));
fprintf('correlation type of gesture and total glance duration: p = %f, chi^2(%d) = %f\n', p, tbl(2,3), tbl(2,5));

[tbl,chi2stat,p] = crosstab(cell2mat(gestures_data_numeric(:,3)),cell2mat(data(:,12)));
fprintf('correlation type of gesture and number of glance: p = %f, chi^2(%d) = %f\n', p, tbl(2,3), tbl(2,5));

%% correlation between glances and gesture success

%[tbl,chi2stat,p] = crosstab(cell2mat(gestures_data_numeric(:,4)),cell2mat(data(:,11)));
[p,h,stats] = ranksum(cell2mat(gestures_data_numeric(:,4)),cell2mat(data(indeces,11)));
fprintf('correlation success of gesture and total glance duration: p = %f, Z = %f\n', p, stats.zval);

[p,h,stats] = ranksum(cell2mat(gestures_data_numeric(:,4)),cell2mat(data(indeces,12)));
fprintf('correlation success of gesture and number of glances: p = %f, Z = %f\n', p, stats.zval);


%% no of glances vs duration of glances on primary task

x1 = cell2mat(gestures_data_numeric(:,13));
x2 = cell2mat(gestures_data_numeric(:,12));
X = [ones(size(x1)) x1 x2 x1.*x2];
y = cell2mat(gestures_data_numeric(:,10));
[b, ~, ~, ~, stats] = regress(cell2mat(gestures_data_numeric(:,10)),X);

fprintf('no of glances and duration of glances on primary task: F(3,95)= %f, R^2 = %f, p = %f\n', stats(1,2), stats(1,1), stats(1,3));

figure,
scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):1:max(x1);
x2fit = min(x2):1:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('duration')
ylabel('number of glances')
zlabel('lane dev')
view(50,10)


%% no of glances vs duration of glances on secondayr task

x1 = cell2mat(gestures_data_numeric(:,13));
x2 = cell2mat(gestures_data_numeric(:,12));
X = [ones(size(x1)) x1 x2 x1.*x2];
y = cell2mat(gestures_data_numeric(:,4));
[b, ~, ~, ~, stats] = regress(y,X);

fprintf('no of glances and duration of glances on secondary task: F(3,95)= %f, R^2 = %f, p = %f\n', stats(1,2), stats(1,1), stats(1,3));

figure,
scatter3(x1,x2,y,'filled')
hold on
x1fit = min(x1):1:max(x1);
x2fit = min(x2):1:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = b(1) + b(2)*X1FIT + b(3)*X2FIT + b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT)
xlabel('duration')
ylabel('number of glances')
zlabel('lane dev')
view(50,10)


%% differences of total gaze duration between conditions 

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