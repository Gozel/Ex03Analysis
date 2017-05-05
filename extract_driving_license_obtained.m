
load('gestures_data.mat');
load('nasatlx.mat');

for i = 1 : height(NASATLX)

    start_index = find(cell2mat(gestures_data(1:end-3,1)) == NASATLX{i,2}, 1, 'first');
    end_index = find(cell2mat(gestures_data(1:end-3,1)) == NASATLX{i,2}, 1, 'last');

    for k = start_index : end_index

        if strcmp(string(NASATLX{i,6}), 'UK')
            gestures_data{k,13} = 1;
        else 
            gestures_data{k,13} = 0;
        end
    end

    fprintf('i: %d j: %d\n', i, j);
end

save('gestures_data.mat', 'gestures_data');
