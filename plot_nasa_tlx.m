
load('nasatlx.mat');

NASATLX = sortrows(NASATLX,'Condition','ascend');
measures = {'Mental Demand' 'Physical Demand' 'Temporal Demand' 'Performance' 'Effort' 'Frustration'};

[~,~,idx] = unique(NASATLX{:,3});
tmp = NASATLX{:,4:9}';
temp = [mean(tmp(1,1:18)) std(tmp(1,1:18)) mean(tmp(1,19:38)) std(tmp(1,19:38)) mean(tmp(1,39:59)) std(tmp(1,39:59)) mean(tmp(1,19:38)) std(tmp(1,80:60)); ...
    mean(tmp(2,1:18)) std(tmp(2,1:18)) mean(tmp(2,19:38)) std(tmp(2,19:38)) mean(tmp(2,39:59)) std(tmp(2,39:59)) mean(tmp(2,19:38)) std(tmp(2,80:60)); ...
    mean(tmp(3,1:18)) std(tmp(3,1:18)) mean(tmp(3,19:38)) std(tmp(3,19:38)) mean(tmp(3,39:59)) std(tmp(3,39:59)) mean(tmp(3,19:38)) std(tmp(3,80:60)); ...
    mean(tmp(4,1:18)) std(tmp(4,1:18)) mean(tmp(4,19:38)) std(tmp(4,19:38)) mean(tmp(4,39:59)) std(tmp(4,39:59)) mean(tmp(4,19:38)) std(tmp(4,80:60)); ...
    mean(tmp(5,1:18)) std(tmp(5,1:18)) mean(tmp(5,19:38)) std(tmp(5,19:38)) mean(tmp(5,39:59)) std(tmp(5,39:59)) mean(tmp(5,19:38)) std(tmp(5,80:60)); ...
    mean(tmp(6,1:18)) std(tmp(6,1:18)) mean(tmp(6,19:38)) std(tmp(6,19:38)) mean(tmp(6,39:59)) std(tmp(6,39:59)) mean(tmp(6,19:38)) std(tmp(6,80:60))];

figure,
hold on, 
h = bar(temp(:,[1,3,5,7]),'DisplayName','temp(:,[1,3,5,7])')
xlabel('NASA TLX Measures'),
ylabel('Average Rating'),
title('NASA TLX Results'),
%xticklabels(measures),
set(gca, 'XTickLabel', string(measures)),
set(gca,'XLim',[0 7]),
set(gca,'YLim',[0 10]),
set(gca,'XTick',[1:1:6]),
colormap(jet(4))
xtickangle(45),
legend(h, {'Ambient' 'Auditory' 'Tactile' 'Visual'});
hold off;
saveas(gca,'figures/nasatlx_results','epsc');

[p, tbl, stats] = kruskalwallis((tmp(6, :)), tmp(6,idx), 'off');
fprintf('influence of driving license country on driving behavior. p: %f, chi^2(%d) = %f\n', p, tbl{2,3}, tbl{2,5});


% figure, 
% hold on, 
% boxplot(NASATLX{1:18,4:9}), 
% xlabel('NASA TLX Measures'),
% ylabel('Average Rating'),
% title('NASA TLX Results for Ambient Feedback'),
% set(gca, 'XTickLabel', string(measures)),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/nasatlx_results_ambient','epsc');
% 
% figure, 
% hold on, 
% boxplot(NASATLX{19:38,4:9}), 
% xlabel('NASA TLX Measures'),
% ylabel('Average Rating'),
% title('NASA TLX Results for Auditory Feedback'),
% set(gca, 'XTickLabel', string(measures)),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/nasatlx_results_auditory','epsc');
% 
% figure, 
% hold on, 
% boxplot(NASATLX{39:59,4:9}), 
% xlabel('NASA TLX Measures'),
% ylabel('Average Rating'),
% title('NASA TLX Results for Tactile Feedback'),
% set(gca, 'XTickLabel', string(measures)),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/nasatlx_results_tactile','epsc');
% 
% figure, 
% hold on, 
% boxplot(NASATLX{60:80,4:9}), 
% xlabel('NASA TLX Measures'),
% ylabel('Average Rating'),
% title('NASA TLX Results for Visual Feedback'),
% set(gca, 'XTickLabel', string(measures)),
% xtickangle(45),
% hold off;
% saveas(gca,'figures/nasatlx_results_visual','epsc');
