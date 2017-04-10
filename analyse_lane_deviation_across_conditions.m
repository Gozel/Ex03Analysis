header;

lane_dev = zeros(NO_PARTICIPANTS + 2, NO_CONDITIONS);
index = 1;
end_index = 0;

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS
        
        % get time of experiment start
        start_time = experiment_data{i,j}{1,1};

        while start_time > car_data{i,j}{index,1}
            index = index + 1;
        end
        
        data = car_data{i,j};
        
        % trim P3_3 data 
        if 3 == i && 3 == j
            end_index = P3_3_END_INDEX;
        else
            end_index = length(data{:,2});
        end
        
        % remove outliers
        clean_data = remove_outliers((data{index:end_index,2}));
        
        % Kurtosis is a measure of how outlier-prone a distribution is. 
        % The kurtosis of the normal distribution is 3. Distributions that 
        % are more outlier-prone than the normal distribution have kurtosis 
        % greater than 3; distributions that are less outlier-prone have 
        % kurtosis less than 3. 
        % Kurtosis influence ANOVA more than skewness. 
%         k = kurtosis(data{index:end_index,2});
%         if k > 3
%             fprintf('not normally distributed for participant %d in condition %d with value: %f\n', i, j, k);
%         end
        
        % lane_dev(i,BLSQ(i,j)) = rmse(data{index:end_index,2}, zeros(size(data{index:end_index,2})));
        lane_dev(i,BLSQ(i,j)) = rmse(clean_data(:), zeros(size(clean_data(:))));
        
    end
end

lane_dev(2,:) = [];
% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (condition) with 4 factors
[p, tbl, stats] = kruskalwallis(lane_dev, {'Visual', 'Auditory', 'Ambient', 'Tactile'}, 'off');

figure, 
hold on,
boxplot(lane_dev(1:end-2,:),{'Visual', 'Auditory', 'Ambient', 'Tactile'}),
xlabel('Conditions'),
ylabel('Lane deviation in metres'),
title('Lane deviation across conditions'),
hold off;
saveas(gca,'figures/lane_dev_across_conditions','epsc');

% table of means and std of lane dev per condition
lane_dev(NO_PARTICIPANTS, 1) = mean(lane_dev(:,1));
lane_dev(NO_PARTICIPANTS + 1, 1) = std(lane_dev(:,1));
lane_dev(NO_PARTICIPANTS, 2) = mean(lane_dev(:,2));
lane_dev(NO_PARTICIPANTS + 1, 2) = std(lane_dev(:,2));
lane_dev(NO_PARTICIPANTS, 3) = mean(lane_dev(:,3));
lane_dev(NO_PARTICIPANTS + 1, 3) = std(lane_dev(:,3));
lane_dev(NO_PARTICIPANTS, 4) = mean(lane_dev(:,4)); 
lane_dev(NO_PARTICIPANTS + 1, 4) = std(lane_dev(:,4));

row_labels = {'P1', 'P3', 'P4', 'P5', 'P6', 'P7', 'P8', 'P9', 'P10', ...
    'P11', 'P12', 'P13', 'P14', 'P15', 'P16', 'P17', 'P18', 'P19', 'P20', '$\mu$', '$\sigma$'};
column_labels = {'Visual', 'Auditory', 'Ambient', 'Tactile'};
matrix2latex(lane_dev, 'tables/lane_dev_conditions_means_stds.tex', 'rowLabels', row_labels, ...
    'columnLabels', column_labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'normalsize');



