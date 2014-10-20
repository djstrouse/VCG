%% init
close all; clear all;
load('data/CountriesPopsAreas.mat');
region = '';
L = 5; % number of difficulty levels
Qs = [8 8 8 8 8]; % number of area/pop questions for each difficulty level
if length(Qs)~=L
  error('Qs should have length L.')
end
Q = sum(Qs); % total number of questions per subject per question type

%% filter out regional data
if ~isempty(region)
  regionmask = strcmp(Region,region);
  SubSampedCountry = Country(regionmask);
  SubSampedLandAreakm2 = LandAreakm2(regionmask);
  SubSampedLandAreami2 = LandAreami2(regionmask);
  SubSampedPopulation = Population(regionmask);
else
  SubSampedCountry = Country;
  SubSampedLandAreakm2 = LandAreakm2;
  SubSampedLandAreami2 = LandAreami2;
  SubSampedPopulation = Population;
end

%% calculate difficulties, levels, and categorical assigments

% difficulities
C = length(SubSampedLandAreakm2);
LandAreaDifficulties = zeros(C,C);
PopulationDifficulties = zeros(C,C);
for n = 1:C
  for m = 1:C
    LandAreaDifficulties(n,m) =...
      abs(SubSampedLandAreami2(n)-SubSampedLandAreami2(m))/SubSampedLandAreami2(n);
    PopulationDifficulties(n,m) =...
      abs(SubSampedPopulation(n)-SubSampedPopulation(m))/SubSampedPopulation(n);
  end; clear m;
end; clear n;

% levels
LandAreaLevels = quantile(LandAreaDifficulties(:),L);
PopulationLevels = quantile(PopulationDifficulties(:),L);

% categorical assignments
LandAreaDifficultyAssignments = zeros(C,C);
PopulationDifficultyAssignments = zeros(C,C);
for l = L:-1:1
  mask = LandAreaDifficulties<LandAreaLevels(l);
  LandAreaDifficultyAssignments(mask) = l; clear mask;
  mask = PopulationDifficulties<PopulationLevels(l);
  PopulationDifficultyAssignments(mask) = l; clear mask;
end; clear l C;

%% create test with difficulty blocks

PopPairs = []; % pairs ordered in difficulty blocks
AreaPairs = [];
for l = 1:L
  [y1,y2] = find(LandAreaDifficultyAssignments==l);
  Y = length(y1);
  mask = randperm(Y,Qs(l));
  AreaPairs = cat(1,AreaPairs,[y1(mask),y2(mask)]);
  clear y1 y2 Y mask;
  [y1,y2] = find(PopulationDifficultyAssignments==l);
  Y = length(y1);
  mask = randperm(Y,Qs(l));
  PopPairs = cat(1,PopPairs,[y1(mask),y2(mask)]);
  clear y1 y2 Y mask;
end; clear l;

%% calculate correct answers
PopKey = zeros(Q,1);
AreaKey = zeros(Q,1);
for n = 1:Q
  if SubSampedPopulation(PopPairs(n,1))>SubSampedPopulation(PopPairs(n,2))
    PopKey(n) = 1;
  else
    PopKey(n) = 2;
  end
  if SubSampedLandAreakm2(AreaPairs(n,1))>SubSampedLandAreakm2(AreaPairs(n,2))
    AreaKey(n) = 1;
  else
    AreaKey(n) = 2;
  end
end
clear n;

%% save data
clear AreaRankkm2 AreaRankmi2 Country DateofPopEstimate;
clear LandAreakm2 LandAreami2 PercWorldPop PopSource Population Region;
clear SortedAreaskm2 SortedAreasmi2;
save('data/quiz.mat');