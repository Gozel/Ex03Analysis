
header;

for i = 1 : NO_PARTICIPANTS
    
    % skipping participant 2 
    if 2 == i
        continue;
    end
    
    for j = 1 : NO_CONDITIONS

        lane_data = car_data{i, j};
        
        start_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'first');
        end_index = find(cell2mat(gestures_data(1:end-3,1)) == i ...
            & cell2mat(gestures_data(1:end-3,2)) == BLSQ(i,j), 1, 'last');
        
        for k = start_index : end_index
        
            frame_start = find(lane_data{:,1} >= gestures_data{k,8}, 1, 'first');
            frame_end = find(lane_data{:,1} <= (gestures_data{k,8} + gestures_data{k,9}), 1, 'last');

            clean_data = (lane_data{frame_start:frame_end,2});
            
            gestures_data{k,10} = rmse(clean_data(:), zeros(size(clean_data(:))));
        end
    end
end

save('gestures_data.mat', 'gestures_data');
