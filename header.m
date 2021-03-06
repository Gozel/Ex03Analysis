
% header file with variables other files need

%clearvars -except capacitive_data car_data experiment_data gaze_data ...
%    video_data gestures_data pilot_gaze_data svmmod training_gaze_data

GESTURES = {'SWIPE LEFT 2'; 'SWIPE LEFT 3'; 'SWIPE LEFT 4';
    'SWIPE RIGHT 2'; 'SWIPE RIGHT 3'; 'SWIPE RIGHT 4';
    'VICTORY'; 'FIST';
    'CIRCLE CLOCKWISE 2'; 'CIRCLE CLOCKWISE 3'; 'CIRCLE CLOCKWISE 4';
    'CIRCLE COUNTER CLOCKWISE 2'; 'CIRCLE COUNTER CLOCKWISE 3'; 'CIRCLE COUNTER CLOCKWISE 4'};

GESTURES_SHORT = {'SL2'; 'SL3'; 'SL4'; 'SR2'; 'SR3'; 'SW4'; 'V'; 'F'; 'CC2'; 'CC3'; 'CC4'; 'CCC2'; 'CCC3'; 'CCC4'};
GESTURES_ALPHABET = {'CC2', 'CC3', 'CC4','CCC2', 'CCC3', 'CCC4', 'SL2', 'SL3', 'SL4', 'SR2', 'SR3','SR4','V', 'F'};

CONDITIONS = {'VISUAL', 'AUDITORY', 'AMBIENT', 'TACTILE'};

NO_PARTICIPANTS = 20;
NO_CONDITIONS = 4;
NO_GESTURES = 30; % 3 * (length(GESTURES) - 1);

INVALID = 0;
VISUAL = 1;
AUDITORY = 2;
AMBIENT = 3;
TACTILE = 4;

blsq = ballatsq(NO_CONDITIONS);
BLSQ = [blsq; blsq; blsq; blsq; blsq];

CAPACITIVE_THRESHOLD = 500; % larger than 500 -> hand is back on steering wheel
% MIN_HAND_OFF_WHEEL_DURATION = 500;

P3_3_END_INDEX = 6818;  % due to some glitch, the car data was recorded for 
                        % longer than the experiment lasted. This is hereby
                        % corrected. 
 