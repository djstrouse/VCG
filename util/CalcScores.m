function [] = CalcScores(subjID)
% Calculates scores for population and area quizzes
%
% Written by: DJ Strouse
% Last updated: July 16, 2013 by DJ Strouse
%
% INPUTS
% subjID [=] scalar = ID of subject set during quiz administration
%
% OUTPUTS
% none

% init
load('data/quiz.mat');
load('data/subjdata.mat');
load('data/subjresults.mat');

% calculate scores
PopMark(subjID,1:Npair) = PopAns(subjID,1:Npair)==PopKey';
PopPercCorr(subjID) = sum(PopMark(subjID,1:Npair))/Npair;
AreaMark(subjID,1:Npair) = AreaAns(subjID,1:Npair)==AreaKey';
AreaPercCorr(subjID) = sum(AreaMark(subjID,1:Npair))/Npair;
CombPercCorr(subjID) = (PopPercCorr(subjID)+AreaPercCorr(subjID))/2;
save('data/subjresults.mat',...
  'PopMark','PopPercCorr',...
  'AreaMark','AreaPercCorr',...
  'CombPercCorr',...
  '-append');

end

