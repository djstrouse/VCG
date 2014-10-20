function [] = PrintPopScore(subjID)
% Prints total score for population quiz
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
disp('POPULATION QUIZ')
disp(sprintf('Percent correct: %2.1f',100*PopPercCorr(subjID)))
disp(sprintf('Total score: %i',PopTotalScore(subjID)))
disp(' ')

end

