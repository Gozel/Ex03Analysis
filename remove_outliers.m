function output = remove_outliers (input)

    % removes outliers form a 1-D input array
    % outliers are constituted with values 3 times bigger than the std of
    % the array
    
    std_input = std(input);
    j = 1;
    
    for i = 1 : length (input) 
       
        if (2 * std_input) > input(i)
            output(j,1) = input(i);
            j = j + 1;
        end
    end
end