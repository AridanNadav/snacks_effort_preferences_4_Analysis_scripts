Hi=[mean(summary(:,3)) mean(summary(:,9)) mean(summary(:,15))];
Mi=[mean(summary(:,2)) mean(summary(:,8)) mean(summary(:,14))];
Li=[mean(summary(:,1)) mean(summary(:,7)) mean(summary(:,13))];

HiSE=[std(summary(:,3))/sqrt(25) std(summary(:,9))/sqrt(25) std(summary(:,15))/sqrt(25)];
MiSE=[std(summary(:,2))/sqrt(25) std(summary(:,8))/sqrt(25) std(summary(:,14))/sqrt(25)];
LiSE=[std(summary(:,1))/sqrt(25) std(summary(:,7))/sqrt(25) std(summary(:,13))/sqrt(25)];

effort_levels=[1,2,3];


% Plot
figfig=figure;
errorbar(effort_levels,Hi,HiSE,'r')
hold on
errorbar(effort_levels,Mi,MiSE,'b')
hold on
errorbar(effort_levels,Li,LiSE,'g')

title( 'all subs VAS Recognition')
xlabel('Perceived effort run') % x-axis label
ylabel('Perceived effort rating (1 to 4)') % y-axis label
legend('High effort',' Medium effort',' Low effort','Location','northwest')
axis([0,4,1,4])
ax = gca;  %% get handle to current axes
ax.XTick = [1 2 3];
ax.XTickLabel = {'mid training','end of training','end of experiment'};
