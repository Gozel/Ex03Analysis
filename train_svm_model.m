header;

% fileName = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data/Pilot/2017_02_22-15_06_48_John/webcamData_p1_0_gaze.txt';                
% test_data{1,1} = readtable(fileName, 'Delimiter', ',', 'Format', formatSpec, 'TreatAsEmpty',{'-nan(ind)'});

% manual classification
training_data = vertcat(pilot_gaze_data{2}{:,:}, pilot_gaze_data{3}{:,:}, pilot_gaze_data{5}{:,:}); %, pilot_gaze_data{6}{:,:});
c = cvpartition(length(training_data),'KFold',10);

opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
    'AcquisitionFunctionName','expected-improvement-plus');
svmmod = fitcsvm(training_data(:,5:10), training_data(:,17),'KernelFunction','rbf',...
    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)


% train
% svmStruct_left = svmtrain(training_data(:,8:10), training_data(:,17));
% svmStruct_right = svmtrain(training_data(:,5:7), training_data(:,17));

% svmStruct = svmtrain(training_data(:,5:10), training_data(:,17));

% test
% newPoint_left = svmclassify(svmStruct_left, pilot_gaze_data{6}{557,5:7});
% newPoint_right = svmclassify(svmStruct_right, pilot_gaze_data{6}{557,8:10});

newPoint = svmclassify(svmStruct, pilot_gaze_data{6}{559,5:10});

% md1 = fitcknn(training_data(:,8:10), training_data(:,17));

% [~,~,id] = unique(training_data(:,17));
% colors = 'rgb';
% markers = 'osd';
% 
% figure;
% for idx = 1 : 3
%     data = training_data(id == idx,:);
%     plot3(data(:,5), data(:,6), data(:,7), [colors(idx) markers(idx)]);
%     hold on;
% end
% grid;
% 
% for idx = 1 : 3
%     data = training_data(id == idx,:);
%     plot3(data(:,8), data(:,9), data(:,10), [colors(idx) markers(idx)]);
%     hold on;
% end
% grid;