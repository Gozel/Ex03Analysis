function condition = condition_from_string(input)

    switch input
        case 'VISUAL'
            condition = VISUAL;
        case 'AUDITORY'
            condition = AUDITORY;
        case 'AMBIENT'
            condition = AMBIENT;
        case 'TACTILE'
            condition = TACTILE;
    end
    
end