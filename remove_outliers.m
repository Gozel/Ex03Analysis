function [output,indeces] = remove_outliers (input)

    % removes outliers form a 1-D input array
    % outliers are constituted with values 3 times bigger than the std of
    % the array
    
    std_input = std(input);    
    indeces = find(input(:) < 2 * std_input);
    output = input(indeces(:));
end