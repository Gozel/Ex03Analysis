header;

% fileName = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data/Pilot/2017_02_22-15_06_48_John/webcamData_p1_0_gaze.txt';                
% test_data{1,1} = readtable(fileName, 'Delimiter', ',', 'Format', formatSpec, 'TreatAsEmpty',{'-nan(ind)'});

% manual classification
training_data = vertcat(pilot_gaze_data{2}{:,:}, pilot_gaze_data{3}{:,:}); %, pilot_gaze_data{5}{:,:}); %, pilot_gaze_data{6}{:,:});
c = cvpartition(length(training_data),'KFold',10);

md1 = fitcknn(training_data(:,5:10), training_data(:,17), 'NumNeighbors',3, 'Distance', 'cityblock');

md2 = fitcknn(training_data(:,5:10), training_data(:,17), 'NumNeighbors',8, 'Distance', 'cityblock', ...
    'OptimizeHyperparameters','auto',...
    'HyperparameterOptimizationOptions',...
    struct('AcquisitionFunctionName','expected-improvement-plus'));


% opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
%     'AcquisitionFunctionName','expected-improvement-plus');

% svmmod_right = fitcsvm(training_data(:,5:7), training_data(:,17),'KernelFunction','rbf',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)
% 
% svmmod_left = fitcsvm(training_data(:,8:10), training_data(:,17),'KernelFunction','rbf',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)

% test
% newPoint = svmclassify(svmStruct, pilot_gaze_data{6}{559,5:10});

%  x1 = training_gaze_data{6}{:, 5};
%  y1 = training_gaze_data{6}{: ,7};
% 
%  vi = convhull(x1,y1)
%  polyarea(x1(vi),y1(vi))
% 
%  fill ( x1(vi), y1(vi), 'r' ); 
%  hold on
%  plot(x1,y1,'.')
%  plot(gaze_data{6,3}{212,5}, gaze_data{6,3}{212,7}, '*')
%  hold off
%  
%  x1 = training_gaze_data{6}{:, 8};
%  y1 = training_gaze_data{6}{: ,9};
% 
%  vi = convhull(x1,y1)
%  polyarea(x1(vi),y1(vi))
% 
%  figure,
%  fill ( x1(vi), y1(vi), 'r' ); 
%  hold on
%  plot(x1,y1,'.')
%  plot(gaze_data{6,3}{212,8}, gaze_data{6,3}{212,9}, '*')
%  hold off

% [~,~,id] = unique(training_gaze_data(:,17));
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
