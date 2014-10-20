function [] = GivePopQuiz(subjID)
% Delivers quiz on populations of countries
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

% administer pop quiz
disp(' ')
disp('POPULATION QUIZ')
disp(' ')
PopQOrder(subjID,1:Q) = randperm(Q);
feedback = zeros(20,1);
count = 0;
for n = PopQOrder(subjID,1:Q)
  count = count+1;
  recObj = audiorecorder; % init audio
  clc
  disp('Larger population:')
  disp(['1: ',SubSampedCountry{PopPairs(n,1)}])
  disp('OR')
  disp(['2: ',SubSampedCountry{PopPairs(n,2)}])
  disp('?')
  tic % start reaction timer
  record(recObj); % start recording audio
  PopAns(subjID,n) = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2));
  PopDelay(subjID,n) = toc; % stop/save reaction timer
  stop(recObj); % stop recording audio
  PopAudioObj{subjID,n} = recObj;
  PopAudio{subjID,n} = getaudiodata(recObj); clear recObj;
  PopConf(subjID,n) = inputv(...
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

