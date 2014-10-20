function [] = PlotSubj(subjID,saveplots)
% Plots summary of single subject data
%
% Written by: DJ Strouse
% Last updated: July 22, 2013 by DJ Strouse
%
% INPUTS
% subjID [=] scalar = ID of subject set during quiz administration
% saveplots [=] bool = save plots?
%
% OUTPUTS
% none

% init
load('data/quiz.mat');
load('data/subjdata.mat');
load('data/subjresults.mat');
xfig = 5;
yfig = 5;
wfig = 20;
hfig = 15;
minconf = 1;
maxconf = 5;

% plot performance vs subject confidence
h = figure(1);
set(h,'units','centimeters','outerposition',[xfig yfig wfig hfig])
plot(...
  [minconf:maxconf;minconf:maxconf],...
  [PopScoreVsSubjConf(subjID,:);AreaScoreVsSubjConf(subjID,:)],...
  'LineWidth',2);
% xlim([])
% ylim([])
legend('PopQuiz','AreaQuiz','Location','NorthEast')
prettyplot
xlabel('Subject Reported Confidence')
ylabel('Percent Correct')
% title('')
if saveplots
  file_name = ['figures/PerfVsSubjConf_subj',int2str(subjID)];
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% plot performance vs subject confidence
h = figure(2);
set(h,'units','centimeters','outerposition',[xfig+wfig yfig wfig hfig])
plot(...
  [minconf:maxconf;minconf:maxconf],...
  [PopScoreVsObsConf(subjID,:);AreaScoreVsObsConf(subjID,:)],...
  'LineWidth',2);
% xlim([])
% ylim([])
legend('PopQuiz','AreaQuiz','Location','NorthEast')
prettyplot
xlabel('Observer Estimated Confidence')
ylabel('Percent Correct')
% title('')
if saveplots
  file_name = ['figures/PerfVsObsConf_subj',int2str(subjID)];
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

end

