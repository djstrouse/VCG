function [] = EvalQuiz(subjID,GiveAns)
% Displays results of a country/pop/area quiz.
%
% Written by: DJ Strouse
% Last updated: July 16, 2013 by DJ Strouse
%
% INPUTS
% subjID [=] scalar = ID of subject set during quiz administration
% GiveAns [=] bool = display answer key?
%
% OUTPUTS
% none
  
% score the quiz
CalcScores(subjID);

% print performance summaries
PrintPopScore(subjID);
PrintAreaScore(subjID);

% print answer key and detailed performance
if GiveAns
  PrintPopKey(subjID);
  pause
  PrintAreaKey(subjID);
end
  
end