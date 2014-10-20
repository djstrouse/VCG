function [] = PrintAreaKey(subjID)
% Prints area answer key and detailed subject results
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

% print key and results
disp(' ')
disp('AREA ANSWER KEY')
for n = 1:Npair
  disp([int2str(AreaMark(subjID,n)),': ',...
    SubSampedCountry{AreaPairs(n,AreaKey(n))},...
    ' > ',...
    SubSampedCountry{AreaPairs(n,(AreaKey(n)==1)+1)}])
end
clear n;

end

