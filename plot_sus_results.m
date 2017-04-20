load('sus.mat');

% questions = {'I think that i would like to use this system frequently',...
%     'I found the system unnecessarily complex', ...
%     'I thought the system was easy to use', ...
%     'I think that I would need the support of a technical person to be able to use this system', ...
%     'I found the various functions in this system very well integrated', ...
%     'I thought there was too much inconsistency in this system', ...
%     'I would imagine that most people would learn to use this system very quickly', ...
%     'I found the system very cumbersome to use', ...
%     'I felt very confident using the system', ...
%     'I needed to learn a lot of things before I could get going with this system'};

% figure, 
% hold on, 
% boxplot(SUS{:,9:18}), 
% xlabel('SUS Questions'),
% ylabel('Average Rating per Question'),
% title('SUS Results'),
% %set(gca, 'XTickLabel', string(questions)),
% %xtickangle(45),
% hold off;
% saveas(gca,'figures/sus_results','epsc');

visual = SUS(2:end,19);
[uniqueXX, ~, J]=unique(visual)
occ = histc(J, 1:numel(uniqueXX))

ambient = SUS(2:end,20);
[uniqueXX, ~, J]=unique(ambient)
occ = histc(J, 1:numel(uniqueXX))

tactile = SUS(2:end,21);
[uniqueXX, ~, J]=unique(tactile)
occ = histc(J, 1:numel(uniqueXX))

audio = SUS(2:end,22);
[uniqueXX, ~, J]=unique(audio)
occ = histc(J, 1:numel(uniqueXX))
