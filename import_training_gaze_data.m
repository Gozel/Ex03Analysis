
path = '/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Data/Introduction/';
extension = 'gaze';
training_gaze_data = cell(20,1);

files = dir(path);
% Get a logical vector that tells which is a directory.

% Get a logical vector that tells which is a directory.
dirFlags = ~[files.isdir];
subFolders = files(dirFlags);

for j = 1 : length(subFolders)

    if contains(subFolders(j).name, extension)

        fprintf('       Sub sub sub folder #%d = %s\n', j, subFolders(j).name);
        fileName = strcat(path, subFolders(j).name);

        formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';

        training_gaze_data{ifelse(j>=2, j+1,j)}= readtable(fileName, 'Delimiter', ',', 'Format', formatSpec, 'TreatAsEmpty',{'-nan(ind)'});
    end
end

training_gaze_data{1} = training_gaze_data{1}{281:595,:};

training_gaze_data{3} = training_gaze_data{3}{1:1645,:};
training_gaze_data{4} = training_gaze_data{4}{1:1330,:};
training_gaze_data{5} = training_gaze_data{5}{2451:2590,:};
training_gaze_data{6} = training_gaze_data{6}{4936:6405,:};
training_gaze_data{7} = training_gaze_data{7}{351,980,:};
training_gaze_data{8} = training_gaze_data{8}{1681:end,:};
training_gaze_data{9} = training_gaze_data{9}{1:245,:};
training_gaze_data{10} = training_gaze_data{10}{1:630,:};

save('training_gaze_data.mat', 'training_gaze_data');