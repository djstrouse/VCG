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
load('quiz.mat');
load('subjdata.mat');

% administer pop quiz
disp(' ')
disp('POPULATION QUIZ')
disp(' ')
PopQOrder(subjID,1:Npair) = randperm(Npair);
for n = PopQOrder(subjID,1:Npair)
  recObj = audiorecorder; % init audio
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
    'Rate your confidence from 1 (low) to 5 (high) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5));
  disp(' ')
end
clear n;

% save subj data
clear AreaKey AreaPairs Ncountry Npair PopKey PopPairs region regionmask;
clear SubSampedCountry SubSampedLandAreakm2;
clear SubSampedLandAreami2 SubSampedPopulation;
clear subjID;
save('subjdata.mat');

end

