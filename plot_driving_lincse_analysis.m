

% one-by-one factor analysis: one dependent variable (lane dev) and one
% independent variable (driving license obtained country) with 2 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,10)), cell2mat(gestures_data(1:end-3,12)), 'off');
fprintf('influence of driving license country on driving behavior. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});
