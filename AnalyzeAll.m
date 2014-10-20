function [] = AnalyzeAll()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

% run individual analyses
load('data/subjdata.mat');
Nsubj = length(SubjNames);
for n = 1:Nsubj
  AnalyzeSubj(n);
end
clear n;

% init
load('data/subjresults.mat');

% prepare ScoresVsSubjConf for plotting
minconf = 1;
maxconf = 5;
CI = .9;
for n = minconf:maxconf
  popscores = PopScoreVsSubjConf(:,n);
  popscores = popscores(~isnan(popscores)); % remove NaNs
  PopScoreVsSubjConfAll(n) = mean(popscores);
  [PopScoreVsSubjConfAllLEB(n),PopScoreVsSubjConfAllUEB(n)] = CIeb(popscores,CI);
  areascores = AreaScoreVsSubjConf(:,n);
  areascores = areascores(~isnan(areascores)); % remove NaNs
  AreaScoreVsSubjConfAll(n) = mean(areascores);
  [AreaScoreVsSubjConfAllLEB(n),AreaScoreVsSubjConfAllUEB(n)] = CIeb(areascores,CI);
end
clear n minconf maxconf popscores areascores CI;

% prepares ScoresVsObsConf for plotting
minconf = 1;
maxconf = 5;
CI = .9;
for n = minconf:maxconf
  popscores = PopScoreVsObsConf(:,n);
  popscores = popscores(~isnan(popscores)); % remove NaNs
  PopScoreVsObsConfAll(n) = mean(popscores);
  [PopScoreVsObsConfAllLEB(n),PopScoreVsObsConfAllUEB(n)] = CIeb(popscores,CI);
  areascores = AreaScoreVsObsConf(:,n);
  areascores = areascores(~isnan(areascores)); % remove NaNs
  AreaScoreVsObsConfAll(n) = mean(areascores);
  [AreaScoreVsObsConfAllLEB(n),AreaScoreVsObsConfAllUEB(n)] = CIeb(areascores,CI);
end
clear n minconf maxconf popscores areascores;

% calculate correlations...
Nsubj = length(SubjNames);
Nquiz = 2;
Npair = 26;
subjconfs = zeros(Nsubj,Nquiz,Npair);
obsconfs = zeros(Nsubj,Nquiz,Npair);
subjdelays = zeros(Nsubj,Nquiz,Npair);
scores = zeros(Nsubj,Nquiz,Npair);
for n = 1:Nsubj
  subjconfs(n,1,:) = PopConf(n,PopQOrder(n,:));
  subjconfs(n,2,:) = AreaConf(n,AreaQOrder(n,:));
  obsconfs(n,1,:) = ObsPopConf(n,:);
  obsconfs(n,2,:) = ObsAreaConf(n,:);
  subjdelays(n,1,:) = PopDelay(n,PopQOrder(n,:));
  subjdelays(n,2,:) = AreaDelay(n,AreaQOrder(n,:));
  scores(n,1,:) = PopMark(n,PopQOrder(n,:));
  scores(n,2,:) = AreaMark(n,AreaQOrder(n,:));
end
clear n;
% ...between subj/obs confidence estimates
[SubjVsObsConfPCorrAll,SubjVsObsConfPCorrAllPV] =...
  corr(subjconfs(:),obsconfs(:),'type','Pearson');
[SubjVsObsConfKCorrAll,SubjVsObsConfKCorrAllPV] =...
  corr(subjconfs(:),obsconfs(:),'type','Kendall');
[SubjVsObsConfSCorrAll,SubjVsObsConfSCorrAllPV] =...
  corr(subjconfs(:),obsconfs(:),'type','Spearman');
%...between subj delay and obs confidence estimate
[ObsConfVsSubjDelayPCorrAll,ObsConfVsSubjDelayPCorrAllPV] =...
  corr(subjdelays(:),obsconfs(:),'type','Pearson');
[ObsConfVsSubjDelayKCorrAll,ObsConfVsSubjDelayKCorrAllPV] =...
  corr(subjdelays(:),obsconfs(:),'type','Kendall');
[ObsConfVsSubjDelaySCorrAll,ObsConfVsSubjDelaySCorrAllPV] =...
  corr(subjdelays(:),obsconfs(:),'type','Spearman');
%...between subj delay and subj confidence
[SubjConfVsDelayPCorrAll,SubjConfVsDelayPCorrAllPV] =...
  corr(subjdelays(:),subjconfs(:),'type','Pearson');
[SubjConfVsDelayKCorrAll,SubjConfVsDelayKCorrAllPV] =...
  corr(subjdelays(:),subjconfs(:),'type','Kendall');
[SubjConfVsDelaySCorrAll,SubjConfVsDelaySCorrAllPV] =...
  corr(subjdelays(:),subjconfs(:),'type','Spearman');
%...between subj conf and scores
[SubjConfVsScorePCorrAll,SubjConfVsScorePCorrAllPV] =...
  corr(subjconfs(:),scores(:),'type','Pearson');
[SubjConfVsScoreKCorrAll,SubjConfVsScoreKCorrAllPV] =...
  corr(subjconfs(:),scores(:),'type','Kendall');
[SubjConfVsScoreSCorrAll,SubjConfVsScoreSCorrAllPV] =...
  corr(subjconfs(:),scores(:),'type','Spearman');
%...between obs conf and scores
[ObsConfVsScorePCorrAll,ObsConfVsScorePCorrAllPV] =...
  corr(obsconfs(:),scores(:),'type','Pearson');
[ObsConfVsScoreKCorrAll,ObsConfVsScoreKCorrAllPV] =...
  corr(obsconfs(:),scores(:),'type','Kendall');
[ObsConfVsScoreSCorrAll,ObsConfVsScoreSCorrAllPV] =...
  corr(obsconfs(:),scores(:),'type','Spearman');
%...between subj delay and scores
[DelayVsScorePCorrAll,DelayVsScorePCorrAllPV] =...
  corr(subjdelays(:),scores(:),'type','Pearson');
[DelayVsScoreKCorrAll,DelayVsScoreKCorrAllPV] =...
  corr(subjdelays(:),scores(:),'type','Kendall');
[DelayVsScoreSCorrAll,DelayVsScoreSCorrAllPV] =...
  corr(subjdelays(:),scores(:),'type','Spearman');

% are people who are good at predicting their own confidence also good at predicting others'...?
% ...confidence in an absolute sense
[SelfPredVsConfPredPCorr,SelfPredVsConfPredPCorrPV] =...
  corr(SubjConfVsScorePCorr(1:end-1)',SubjVsObsConfPCorr(2:end)','type','Pearson');
[SelfPredVsConfPredKCorr,SelfPredVsConfPredKCorrPV] =...
  corr(SubjConfVsScoreKCorr(1:end-1)',SubjVsObsConfKCorr(2:end)','type','Kendall');
[SelfPredVsConfPredSCorr,SelfPredVsConfPredSCorrPV] =...
  corr(SubjConfVsScoreSCorr(1:end-1)',SubjVsObsConfSCorr(2:end)','type','Spearman');
% ...performance in an absolute sense
[SelfPredVsScorePredAbsPCorr,SelfPredVsScorePredAbsPCorrPV] =...
  corr(SubjConfVsScorePCorr(1:end-1)',ObsConfVsScorePCorr(2:end)','type','Pearson');
[SelfPredVsScorePredAbsKCorr,SelfPredVsScorePredAbsKCorrPV] =...
  corr(SubjConfVsScoreKCorr(1:end-1)',ObsConfVsScoreKCorr(2:end)','type','Kendall');
[SelfPredVsScorePredAbsSCorr,SelfPredVsScorePredAbsSCorrPV] =...
  corr(SubjConfVsScoreSCorr(1:end-1)',ObsConfVsScoreSCorr(2:end)','type','Spearman');
% ...performance relative to the other's prediction of self
[SelfPredVsScorePredRelPCorr,SelfPredVsScorePredRelPCorrPV] =...
  corr(...
  SubjConfVsScorePCorr(1:end-1)',...
  (ObsConfVsScorePCorr(2:end)-SubjConfVsScorePCorr(2:end))','type','Pearson');
[SelfPredVsScorePredRelKCorr,SelfPredVsScorePredRelKCorrPV] =...
  corr(...
  SubjConfVsScoreKCorr(1:end-1)',...
  (ObsConfVsScoreKCorr(2:end)-SubjConfVsScorePCorr(2:end))','type','Kendall');
[SelfPredVsScorePredRelSCorr,SelfPredVsScorePredRelSCorrPV] =...
  corr(...
  SubjConfVsScoreSCorr(1:end-1)',...
  (ObsConfVsScoreSCorr(2:end)-SubjConfVsScorePCorr(2:end))','type','Spearman');

% save
save(...
  'data/subjresults.mat',...
  'PopScoreVsSubjConfAll',...
  'PopScoreVsSubjConfAllLEB',...
  'PopScoreVsSubjConfAllUEB',...
  'AreaScoreVsSubjConfAll',...
  'AreaScoreVsSubjConfAllLEB',...
  'AreaScoreVsSubjConfAllUEB',...
  'PopScoreVsObsConfAll',...
  'PopScoreVsObsConfAllLEB',...
  'PopScoreVsObsConfAllUEB',...
  'AreaScoreVsObsConfAll',...
  'AreaScoreVsObsConfAllLEB',...
  'AreaScoreVsObsConfAllUEB',...
  'SubjVsObsConfPCorrAll',...
  'SubjVsObsConfPCorrAllPV',...
  'SubjVsObsConfKCorrAll',...
  'SubjVsObsConfKCorrAllPV',...
  'SubjVsObsConfSCorrAll',...
  'SubjVsObsConfSCorrAllPV',...
  'ObsConfVsSubjDelayPCorrAll',...
  'ObsConfVsSubjDelayPCorrAllPV',...
  'ObsConfVsSubjDelayKCorrAll',...
  'ObsConfVsSubjDelayKCorrAllPV',...
  'ObsConfVsSubjDelaySCorrAll',...
  'ObsConfVsSubjDelaySCorrAllPV',...
  'SubjConfVsDelayPCorrAll',...
  'SubjConfVsDelayPCorrAllPV',...
  'SubjConfVsDelayKCorrAll',...
  'SubjConfVsDelayKCorrAllPV',...
  'SubjConfVsDelaySCorrAll',...
  'SubjConfVsDelaySCorrAllPV',...
  'SubjConfVsScorePCorrAll',...
  'SubjConfVsScorePCorrAllPV',...
  'SubjConfVsScoreKCorrAll',...
  'SubjConfVsScoreKCorrAllPV',...
  'SubjConfVsScoreSCorrAll',...
  'SubjConfVsScoreSCorrAllPV',...
  'ObsConfVsScorePCorrAll',...
  'ObsConfVsScorePCorrAllPV',...
  'ObsConfVsScoreKCorrAll',...
  'ObsConfVsScoreKCorrAllPV',...
  'ObsConfVsScoreSCorrAll',...
  'ObsConfVsScoreSCorrAllPV',...
  'DelayVsScorePCorrAll',...
  'DelayVsScorePCorrAllPV',...
  'DelayVsScoreKCorrAll',...
  'DelayVsScoreKCorrAllPV',...
  'DelayVsScoreSCorrAll',...
  'DelayVsScoreSCorrAllPV',...
  'SelfPredVsConfPredPCorr',...
  'SelfPredVsConfPredPCorrPV',...
  'SelfPredVsConfPredKCorr',...
  'SelfPredVsConfPredKCorrPV',...
  'SelfPredVsConfPredSCorr',...
  'SelfPredVsConfPredSCorrPV',...
  'SelfPredVsScorePredAbsPCorr',...
  'SelfPredVsScorePredAbsPCorrPV',...
  'SelfPredVsScorePredAbsKCorr',...
  'SelfPredVsScorePredAbsKCorrPV',...
  'SelfPredVsScorePredAbsSCorr',...
  'SelfPredVsScorePredAbsSCorrPV',...
  'SelfPredVsScorePredRelPCorr',...
  'SelfPredVsScorePredRelPCorrPV',...
  'SelfPredVsScorePredRelKCorr',...
  'SelfPredVsScorePredRelKCorrPV',...
  'SelfPredVsScorePredRelSCorr',...
  'SelfPredVsScorePredRelSCorrPV',...
  '-append');

end