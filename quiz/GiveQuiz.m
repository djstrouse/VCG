%% init
close all; clear all;
if exist('data/subjdata.mat','file')
  load('data/subjdata.mat')
else
  SubjAge = [];
  SubjNames = [];
  SubjAge = [];
  SubjSex = [];
  SubjNationality = [];
  SubjCurrLoc = [];
  SubjNatLang = [];
  SubjNumLangSpoken = [];
  SubjYrsEngStudied = [];
  SubjYrsEngLived = [];
  SubjEmail = [];
  save('data/subjdata.mat')
end

%% assign subjID
disp(' ')
subjID = input('Enter 0 for new subject, or ID for old subject: ');
if subjID==0 % new subject
  subjID = length(SubjAge)+1; % set subjID
end

%% administer prequiz
GivePreQuiz(3); clc;
disp('Great job! We will now start the real quiz. Are you ready?')
pause
disp(' ')

%% administer pop quiz
GivePopQuiz(subjID); clc;
disp('Finished with population questions! Ready for the area quiz?')
pause
disp(' ')

%% administer area quiz
GiveAreaQuiz(subjID); clc;
disp('Phew! Done with the difficult questions. Just a little more info before you go...')
pause
disp(' ')

%% subject survey
SurveySubject(subjID);

%% calculate scores
% CalcScores(subjID);
disp(' ')
disp('Finished!')
disp(' ')