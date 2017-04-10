
% header file with variables other files need

% load('/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Analysis/capacitive_data.mat');
% load('/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Analysis/car_data.mat');
% load('/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Analysis/experiment_data.mat');
% load('/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Analysis/gaze_data.mat');
% load('/home/gozel/OneDrive/PhD/Reports_Papers_Documents/Ex03/Analysis/video_data.mat');
load('gestures_data.mat');

clearvars -except capacitive_data car_data experiment_data gaze_data video_data gestures

GESTURES = {'SWIPE LEFT 2'; 'SWIPE LEFT 3'; 'SWIPE LEFT 4';
    'SWIPE RIGHT 2'; 'SWIPE RIGHT 3'; 'SWIPE RIGHT 4';
    'VICTORY'; 'FIST';
    'CLOCKWISE 2'; 'CLOCKWISE 3'; 'CLOCKWISE 4';
    'COUNTER CLOCKWISE 2'; 'COUNTER CLOCKWISE 3'; 'COUNTER CLOCKWISE 4'};

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

P3_3_END_INDEX = 6818;  % due to some glitch, the car data was recorded for 
                        % longer than the experiment lasted. This is hereby
                        % corrected. 