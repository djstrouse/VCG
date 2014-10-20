function [] = PrintAreaScore(subjID)
% Prints total score for area quiz
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
load('data/subjresults.mat');

% print scores
disp(' ')
disp('AREA QUIZ')
disp(sprintf('Percent correct: %2.1f',100*AreaPercCorr(subjID)))
disp(sprintf('Total score: %i',AreaTotalScore(subjID)))
disp(' ')

end

