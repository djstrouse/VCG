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
load('prequiz.mat');
load('subjdata.mat');
if Nrep>Npair
  disp(sprintf(...
    'Warning: value of Nrep (%i) larger than Npair (%i), so Nrep set to Npair',...
    Nrep,Npair));
  Nrep = Npair;
end

% administer pop prequiz
disp(' ')
disp('POPULATION PREQUIZ')
disp(' ')
for n = randperm(Npair,Nrep)
  disp('Larger population:')
  disp(['1: ',SubSampedCountry{PopPairs(n,1)}])
  disp('OR')
  disp(['2: ',SubSampedCountry{PopPairs(n,2)}])
  disp('?')
  answer = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2)); clear answer;
  conf = inputv(...
    'Rate your confidence from 1 (low) to 5 (high) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5)); clear conf;
  disp(' ')
end
clear n;

% administer area prequiz
disp(' ')
disp('AREA PREQUIZ')
disp(' ')
for n = randperm(Npair,Nrep)
  disp('Larger area:')
  disp(['1: ',SubSampedCountry{AreaPairs(n,1)}])
  disp('OR')
  disp(['2: ',SubSampedCountry{AreaPairs(n,2)}])
  disp('?')
  answer = inputv(...
    'Choose 1 or 2 by speaking: ',...
    @(x) (x==1)||(x==2)); clear answer;
  conf = inputv(...
    'Rate your confidence from 1 (low) to 5 (high) by typing: ',...
    @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5)); clear conf;
  disp(' ')
end
clear n;

end

