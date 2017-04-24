% header;

% fileName = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data/Pilot/2017_02_22-15_06_48_John/webcamData_p1_0_gaze.txt';                
% test_data{1,1} = readtable(fileName, 'Delimiter', ',', 'Format', formatSpec, 'TreatAsEmpty',{'-nan(ind)'});

% manual classification
training_data = vertcat(pilot_gaze_data{2}{:,:}, pilot_gaze_data{3}{:,:}, pilot_gaze_data{5}{:,:}, pilot_gaze_data{6}{:,:});
% training_data = vertcat(pilot_gaze_data{2}{:,:}); %, pilot_gaze_data{5}{1:end/3,:}, pilot_gaze_data{6}{1:end/3,:});
c = cvpartition(length(training_data),'KFold',10);

opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
    'AcquisitionFunctionName','expected-improvement-plus');

svmmod_pose_john = fitcsvm(training_data(:,[5:10 14:16] ), training_data(:,17),'KernelFunction','linear',...
    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)

% test
% newPoint = svmclassify(svmStruct, pilot_gaze_data{6}{559,5:10});

% [~,~,id] = unique(training_data(1:877,17));
% colors = 'rgb';
% markers = 'osd';
% 
% figure;
% for idx = 1 : 3
%     data = training_data(id == idx,:);
%     plot3(data(:,5), data(:,6), data(:,7),...
%         [colors(idx) markers(idx)]);
%     hold on;
% end
% grid;

% for idx = 1 : 2
%     data = training_data(id == idx,:);
%     plot(data(:,8), data(:,9), [colors(idx) markers(idx)]);
%     hold on;
% end
% grid;
