function [] = GivePreQuiz(Nrep)
% Delivers a prequiz on populations/area of countries to prepare subjects
% for the real experiment.
%
% Written by: DJ Strouse
% Last updated: July 18, 2013 by DJ Strouse
%
% INPUTS
% Nrep [=] positive integer = number of reps for both pop and area
%
% OUTPUTS
% none

% init
load('data/quiz.mat');

% administer pop prequiz
disp(' ')
disp('POPULATION PREQUIZ')
disp(' ')
feedback = zeros(Nrep,1);
for n = 1:Nrep
  clc
  N = length(SubSampedCountry);
  tmp = randperm(N,2);
  x1 = tmp(1);
  x2 = tmp(2); clear N tmp;
  disp('Larger population:')
  disp(['1: ',SubSampedCountry{x1}])
  disp('OR')
  disp(['2: ',SubSampedCountry{x2}])
  disp('?')
  answer = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2));
  if SubSampedPopulation(x1)>SubSampedPopulation(x2)
    key = 1;
  else
    key = 2;
  end
  feedback(n) = answer==key; clear answer key x1 x2;
  conf = inputv(...
    'Place your bet from 1 (lowest confidence) to 5 (highest confidence) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5)); clear conf;
  disp(' ')
end
clear n;
disp(sprintf('You answered %i of the last %i questions correctly.',sum(feedback),Nrep))
disp('Press any key to continue with the quiz.')
pause
clear feedback;

% administer area prequiz
disp(' ')
disp('AREA PREQUIZ')
disp(' ')
feedback = zeros(Nrep,1);
for n = 1:Nrep
  clc
  N = length(SubSampedCountry);
  tmp = randperm(N,2);
  x1 = tmp(1);
  x2 = tmp(2); clear N tmp;
  disp('Larger area:')
  disp(['1: ',SubSampedCountry{x1}])
  disp('OR')
  disp(['2: ',SubSampedCountry{x2}])
  disp('?')
  answer = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2));
  if SubSampedLandAreakm2(x1)>SubSampedLandAreakm2(x2)
    key = 1;
  else
    key = 2;
  end
  feedback(n) = answer==key; clear answer key x1 x2;
  conf = inputv(...
    'Place your bet from 1 (lowest confidence) to 5 (highest confidence) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5)); clear conf;
  disp(' ')
end
clear n;
disp(sprintf('You answered %i of the last %i questions correctly.',sum(feedback),Nrep))
disp('Press any key to continue with the quiz.')
pause
clear feedback;

end

