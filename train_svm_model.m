
% manual classification
webcamDatap10pgaze(891:900,11) = {1};
webcamDatap10pgaze(901:975,11) = {0};
webcamDatap10pgaze(976:1231,11) = {1};

% train
svmStruct = svmtrain(cell2mat(webcamDatap10pgaze(1:1231,5:10)), cell2mat(classes));

% test
newPoint = svmclassify(svmStruct,cell2mat(webcamDatap10pgaze(1662,5:10)));