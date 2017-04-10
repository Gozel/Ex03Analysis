

experiment_end = 1.490089440396000e+12; %experiment_data{3,3}{end,1};

data = car_data{3,3}{:,1};

for i = 1 : length (data)

    if data(i) > experiment_end
        fprintf('index of experiment end in car data: %d\n', i);
    end
end

