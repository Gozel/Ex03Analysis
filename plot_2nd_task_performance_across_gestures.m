header;

% make sure to run first: 
% analyse_lane_deviation_across_gestures;

% one-by-one factor analysis: one dependent variable (success rate) and one
% independent variable (gesture) with 13 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,4)), string(gestures_data(1:end-3,3)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% =========================================================================

% one-by-one factor analysis: one dependent variable (success rate) and one
% independent variable (condition) with 4 factors
[p, tbl, stats] = kruskalwallis(cell2mat(gestures_data(1:end-3,4)), string(gestures_data(1:end-3,2)), 'off');
fprintf('success rates of gestures. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});

% =========================================================================

% columns: 2nd task performance across gestures
% gesture_success_rates = cell(length(GESTURES), 2);

for i = 1 : length(GESTURES)
    indeces = find(strcmp(string(gestures_data(1:end-3,3)), GESTURES{i}));
    gesture_success_rates(i,:) = {GESTURES(i), sum(cell2mat(gestures_data(indeces,4))) / length(gestures_data(indeces,4)) * 100};
end

fontSize = 30;
format compact

x = 1 : length(GESTURES);
y = gesture_success_rates;
numberOfBars = length(y);

button = 3; %menu('Use which colormap?', 'Custom', 'Random', 'Jet', 'Hot', 'Lines');
if button == 1
	% Make up a custom colormap specifying the color for each bar series.
	barColorMap(1,:) = [.2 .71 .3];	% Green Color for segment 1.
	barColorMap(2,:) = [.25 .55 .79];	% Blue Color for segment 2.
	barColorMap(3,:) = [.9 .1 .14];	% Red Color for segment 3.
	barColorMap(4,:) = [.9 .9 .14];	% Yellow Color for segment 4.
	% I have not defined any more than 4 colors in this demo.
	% For any number of bars beyond 4, just make up random colors.
	if numberOfBars > 4
		barColorMap(5:numberOfBars, 1:3) = rand(numberOfBars-4, 3);
	end
elseif button == 2
	% Example of using colormap with random colors
	barColorMap = rand(numberOfBars, 3); 
elseif button == 3
	% Example of using pre-defined jet colormap
	barColorMap = jet(numberOfBars); 
elseif button == 4
	% Example of using pre-defined Hot colormap
	barColorMap = hot(numberOfBars); 
else
	% Example of using pre-defined lines colormap
	barColorMap = lines(numberOfBars); 
end

% Plot each number one at a time, calling bar() for each y value.
barFontSize = 15;
for b = 1 : numberOfBars
	% Plot one single bar as a separate bar series.
	handleToThisBarSeries(b) = bar(x(b), y{b,2}, 'BarWidth', 0.9);
	% Apply the color to this bar series.
	set(handleToThisBarSeries(b), 'FaceColor', barColorMap(b,:));
	% Place text atop the bar
	barTopper = sprintf('%.2f', y{b,2});
	text(x(b)-0.4, y{b,2}+3, barTopper, 'FontSize', barFontSize);
	hold on;
end

% Fancy up the graph.
grid on;
caption = sprintf('2nd Task Performance per Gesture');
title(caption, 'FontSize', fontSize);
xlabel('Gestures', 'FontSize', fontSize);
ylabel('2nd Task Performance', 'FontSize', fontSize);
% Restore the x tick marks.
%set(gca, 'XTickMode', 'Auto');
set(gca, 'XTickLabel', string(GESTURES_SHORT)),
set(gca,'XLim',[0 15]),
set(gca,'YLim',[0 110]),
set(gca,'XTick',[1:1:14]),
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off');

saveas(gca,'figures/2nd_task_performance_gestures','epsc');

% =========================================================================

% columns: 2nd task performance across gestures
%gesture_success_rates_condition = cell(NO_CONDITIONS, 2, 3);

for i = 1 : NO_CONDITIONS % length(GESTURES)
    indeces = find(cell2mat(gestures_data(1:end-3,2)) == i);
    gesture_success_rates_condition(i,:) = {CONDITIONS(i), sum(cell2mat(gestures_data(indeces,4))) / length(gestures_data(indeces,4)) * 100};
end

figure,
hold on, 
h = bar(cell2mat(gesture_success_rates_condition(:,end)), 'grouped'),
xlabel('Conditions'),
ylabel('Average Performance'),
title('2nd Task Performance per Condition'),
%xticklabels(measures),
set(gca, 'XTickLabel', string(CONDITIONS)),
set(gca,'XLim',[0 5]),
set(gca,'YLim',[0 100]),
set(gca,'XTick',[1:1:4]),
hBarChildren = get(h, 'Children');
set(hBarChildren, 'CData', [1 2 3 4]),
colormap(jet(4)),
%set(hBarChildren(2), 'FaceColor',colormap(summer(2))),
%xtickangle(45),
%legend(h, {'Ambient' 'Auditory' 'Tactile' 'Visual'});
hold off;
saveas(gca,'figures/2nd_task_performance_conditions','epsc');

row_labels = CONDITIONS;
column_labels = {'Gesture success rate'};
matrix2latex(cell2mat(gesture_success_rates_condition(:,2:end)), 'tables/gesture_success_rates_across_conditions.tex', ... 
    'rowLabels', row_labels, ...
    'columnLabels', column_labels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'normalsize');
