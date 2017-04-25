

% left handed particpants
% gestures_data(721:840,12) = {2};
% gestures_data(1797:1916,12) = {2};

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (driving license obtained country) with 2 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,10)), cell2mat(gestures_data(1:end-3,12)), 'off');
fprintf('influence of driving license country on driving behavior. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

gestures_data_numeric = gestures_data(1:end-3,:);

for i = 1 : length(gestures_data)
    
    for j = 1 : length(GESTURES)
        
        if strcmp(string(GESTURES{j}),string(gestures_data{i,3}))
            gestures_data_numeric{i,3} = j;
        end
    end
end

stats = RMAOV1(cell2mat(gestures_data_numeric(:,[4 3 12])));