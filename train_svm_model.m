
%% train SVM classifier 

% manual classification
training_data = vertcat(pilot_gaze_data{2}{:,:}, pilot_gaze_data{3}{:,:}, pilot_gaze_data{5}{:,:}); %, pilot_gaze_data{6}{:,:});
%training_data = vertcat(pilot_gaze_data{2}{:,:}); %, pilot_gaze_data{5}{1:end/3,:}, pilot_gaze_data{6}{1:end/3,:});
c = cvpartition(length(training_data),'KFold',10);

% opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
%     'AcquisitionFunctionName','expected-improvement-plus');
% 
% svmmod_pose_john = fitcsvm(training_data(:,[5:10 14:16] ), training_data(:,17),'KernelFunction','linear',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts)


%% test svm model performance 

% test
% newPoint = svmclassify(svmStruct, pilot_gaze_data{6}{559,5:10});

groups = training_data(:,17);
k = 10;

cvFolds = crossvalind('Kfold',groups,k);
cp = classperf(groups);

for i = 1:k                                  %# for each fold
    testIdx = (cvFolds == i);                %# get indices of test instances
    trainIdx = ~testIdx;                     %# get indices training instances

    %# train an SVM model over training instances
    svmModel = fitcsvm(training_data(trainIdx,[5:10 14:16]), groups(trainIdx), ...
                 'BoxConstraint',0.030033, 'KernelScale',0.0010144, 'KernelFunction','linear');

    %# test using test instances
    pred = predict(svmModel, training_data(testIdx,[5:10 14:16]));

    %# evaluate and update performance object
    cp = classperf(cp, pred, testIdx);
end

cp.CorrectRate

%% plot svm model performance 

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
