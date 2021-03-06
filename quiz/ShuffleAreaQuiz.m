%% init
close all; clear all;
load('data/CountriesPopsAreas.mat');
load('data/quiz.mat');

%% filter out regional data (only need if changing region)
% region = 'Europe';
% regionmask = strcmp(Region,region);
% SubSampedCountry = Country(regionmask);
% SubSampedLandAreakm2 = LandAreakm2(regionmask);
% SubSampedLandAreami2 = LandAreami2(regionmask);
% SubSampedPopulation = Population(regionmask);

%% randomly pair countries (twice)
perm = randperm(Ncountry);
AreaPairs = [perm(1:Npair)' perm(Npair+1:2*Npair)']; clear perm;

%% calculate correct answers
AreaKey = zeros(Npair,1);
for n = 1:Npair
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