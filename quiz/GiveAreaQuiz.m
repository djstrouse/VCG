function [] = GiveAreaQuiz(subjID)
% Delivers quiz on areas of countries
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

% administer area quiz
disp(' ')
disp('AREA QUIZ')
disp(' ')
AreaQOrder(subjID,1:Q) = randperm(Q);
feedback = zeros(20,1);
count = 0;
for n = AreaQOrder(subjID,1:Q)
  recObj = audiorecorder; % init audio
  clc
  disp('Larger area:')
  disp(['1: ',SubSampedCountry{AreaPairs(n,1)}])
  disp('OR')
  disp(['2: ',SubSampedCountry{AreaPairs(n,2)}])
  disp('?')
  tic % start reaction timer
  record(recObj); % start recording audio
  AreaAns(subjID,n) = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2));
  AreaDelay(subjID,n) = toc; % stop/save reaction timer
  stop(recObj); % stop recording audio
  AreaAudioObj{subjID,n} = recObj;
  AreaAudio{subjID,n} = getaudiodata(recObj); clear recObj;
  AreaConf(subjID,n) = inputv(...
    'Place your bet from 1 (lowest confidence) to 5 (highest confidence) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5));
  disp(' ')
  feedback(count) = PopAns(subjID,n)==PopKey(n);
  if count==20
    count = 0;
    clc
    disp(sprintf('You answered %i of the last 20 questions correctly.',sum(feedback)))
    disp('Press any key to continue with the quiz.')
    pause
    feedback = zeros(20,1);
  end
end
clear n;

% save subj data
clear AreaKey AreaPairs Ncountry Npair PopKey PopPairs region regionmask;
clear SubSampedCountry SubSampedLandAreakm2;
clear SubSampedLandAreami2 SubSampedPopulation;
clear subjID;
save('data/subjdata.mat');

end

