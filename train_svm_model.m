header;

% fileName = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data/Pilot/2017_02_22-15_06_48_John/webcamData_p1_0_gaze.txt';                
% test_data{1,1} = readtable(fileName, 'Delimiter', ',', 'Format', formatSpec, 'TreatAsEmpty',{'-nan(ind)'});

% manual classification
training_data = vertcat(pilot_gaze_data{2}{:,:}, pilot_gaze_data{3}{:,:}, pilot_gaze_data{5}{:,:}); %, pilot_gaze_data{6}{:,:});
c = cvpartition(length(training_data),'KFold',10);

% pd_r = makedist('Normal','mu',mean(training_data(:, [5,6])),'sigma',std(training_data(:,[5,6])));

% opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
%     'AcquisitionFunctionName','expected-improvement-plus');
% svmmod_right = fitcsvm(training_data(:,5:7), training_data(:,17),'KernelFunction','rbf',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)
% 
% svmmod_left = fitcsvm(training_data(:,8:10), training_data(:,17),'KernelFunction','rbf',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)

% test
% newPoint = svmclassify(svmStruct, pilot_gaze_data{6}{559,5:10});

 x1 = pilot_gaze_data{5,1}{1:1139, 5};
 y1 = pilot_gaze_data{5,1}{1:1139 ,6};

 vi = convhull(x1,y1)
 polyarea(x1(vi),y1(vi))

 fill ( x1(vi), y1(vi), 'r' ); 
 hold on
 plot(x1,y1,'.')
 hold off

% [~,~,id] = unique(training_data(:,17));
% colors = 'rgb';
% markers = 'osd';
% 
% figure;
% for idx = 1 : 2
%     data = training_data(id == idx,:);
%     plot(data(:,5), data(:,6),[colors(training_data(:,17)) markers(idx)]);
%     hold on;
% end
% grid;

% for idx = 1 : 2
%     data = training_data(id == idx,:);
%     plot(data(:,8), data(:,9), [colors(idx) markers(idx)]);
%     hold on;
% end
% grid;

