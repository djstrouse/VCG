function [] = PlotAllSubj(saveplots)
% Plots summary of all subject data
%
% Written by: DJ Strouse
% Last updated: July 22, 2013 by DJ Strouse
%
% INPUTS
% saveplots [=] bool = save plots?
%
% OUTPUTS
% none

% init
if ~exist('saveplots','var')
  saveplots = false; % defaults to off
end
load('data/subjdata.mat');
load('data/subjresults.mat');
xfig = 5;
yfig = 5;
wfig = 20;
hfig = 15;

% who predicts performance better?
h = figure();
set(h,'units','centimeters','outerposition',[xfig yfig wfig hfig])
scatter(SubjConfVsPerfCorr,ObsConfVsPerfCorr);
xlim([-.3 .5])
ylim([-.3 .5])
refline(1,0)
% legend('','','Location','NorthEast')
prettyplot
xlabel('Corr(SubjConf,Perf)')
ylabel('Corr(ObsConf,Perf)')
title('Who predicts performance better?')
if saveplots
  file_name = 'figures/SubjVsObsPredictivePerf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% which more informative: delays or reported conf? 
h = figure();
set(h,'units','centimeters','outerposition',[xfig+wfig yfig wfig hfig])
scatter(SubjConfVsPerfCorr,DelayVsPerfCorr);
xlim([-.3 .5])
ylim([-.3 .5])
refline(-1,0)
% legend('','','Location','NorthEast')
prettyplot
xlabel('Corr(SubjConf,Perf)')
ylabel('Corr(Delay,Perf)')
title('More informative: delay or report?')
if saveplots
  file_name = 'figures/DelayVsConfReportPredictivePerf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% combined P(correct) vs both confidences
h = figure();
set(h,'units','centimeters','outerposition',[xfig yfig 3*wfig 3*hfig]);
for n = 1:15
  subplot(3,5,n)
  plot(...
    (1:5)',CombScoreVsSubjConf(n,:),'b',...
    (1:5)',CombScoreVsObsConf(n,:),'g',...
    'LineWidth',2)
  xlim([.75 5.25])
  ylim([0 1])
  set(gca,...
    'XTick',1:5,...
    'XTickLabel',{'1','2','3','4','5'});
  prettyplot
  xlabel('Confidence')
  ylabel('Percent Correct')
end
clear n;
if saveplots
  file_name = 'figures/CombScoreVsBothConf_AllSubj';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% P(correct) vs subject confidence
h = figure();
set(h,'units','centimeters','outerposition',[xfig yfig wfig hfig]);
errorbar(...
  1:5,...
  PopScoreVsSubjConfAll,...
  PopScoreVsSubjConfAllLEB,...
  PopScoreVsSubjConfAllUEB,...
  'LineWidth',2)
xlim([.75 5.25])
ylim([0 1])
prettyplot
xlabel('Subject Confidence Rating')
ylabel('Percent Correct')
title('POPULATION QUIZ')
if saveplots
  file_name = 'figures/PopScoreVsSubjConf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

h = figure();
set(h,'units','centimeters','outerposition',[xfig+wfig yfig wfig hfig]);
errorbar(...
  1:5,...
  AreaScoreVsSubjConfAll,...
  AreaScoreVsSubjConfAllLEB,...
  AreaScoreVsSubjConfAllUEB,...
  'LineWidth',2)
xlim([.75 5.25])
ylim([0 1])
prettyplot
xlabel('Subject Confidence Rating')
ylabel('Percent Correct')
title('AREA QUIZ')
if saveplots
  file_name = 'figures/AreaScoreVsSubjConf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% P(correct) vs observer estimated confidence
h = figure();
set(h,'units','centimeters','outerposition',[xfig yfig+hfig wfig hfig]);
errorbar(...
  1:5,...
  PopScoreVsObsConfAll,...
  PopScoreVsObsConfAllLEB,...
  PopScoreVsObsConfAllUEB,...
  'LineWidth',2)
xlim([.75 5.25])
ylim([0 1])
prettyplot
xlabel('Observer Confidence Rating')
ylabel('Percent Correct')
title('POPULATION QUIZ')
if saveplots
  file_name = 'figures/PopScoreVsObsConf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

h = figure();
set(h,'units','centimeters','outerposition',[xfig+wfig yfig+hfig wfig hfig]);
errorbar(...
  1:5,...
  AreaScoreVsObsConfAll,...
  AreaScoreVsObsConfAllLEB,...
  AreaScoreVsObsConfAllUEB,...
  'LineWidth',2)
xlim([.75 5.25])
ylim([0 1])
prettyplot
xlabel('Observer Confidence Rating')
ylabel('Percent Correct')
title('AREA QUIZ')
if saveplots
  file_name = 'figures/AreaScoreVsObsConf';
  saveas(h,[file_name,'.fig']);
  export_fig(file_name,'-pdf','-transparent');
end

% P(correct) vs delay


% delay vs confidence


end

