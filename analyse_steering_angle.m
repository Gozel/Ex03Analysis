header;

steering_angle_dev = zeros(no_participants, no_conditions);

for i = 1 : no_participants
    
    
    for j = 1 : no_conditions
        
        data = car_data{i,j};
        
        steering_angle_dev(i,j) = rmse(data{:,5}, zeros(size(data{:,5})));
    end
end