function [] = SurveySubject(subjID)
% Asks subject for basic personal data
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
load('data/subjdata.mat');

% ask questions
SubjNames{subjID} = inputv('Enter name: ',@(x) ischar(x));
SubjAge(subjID) = inputv('Enter age: ',@(x) isint(x));
SubjSex(subjID) = inputv('Enter sex (0=f,1=m): ',@(x) (x==0)||(x==1));
SubjNationality{subjID} = inputv('Enter nationality: ',@(x) ischar(x));
SubjCurrLoc{subjID} = inputv('Enter current location (nation): ',@(x) ischar(x));
SubjNatLang{subjID} = inputv('Enter native language: ',@(x) ischar(x));
SubjNumLangSpok(subjID) = inputv('Enter number of languages spoken: ',@(x) isint(x));
SubjYrsEngStudy(subjID) = inputv('Enter years of English study: ',@(x) isint(x));
SubjYrsEngLived(subjID) = inputv('Enter years lived in English-speaking country: ',@(x) isint(x));
SubjEmail{subjID} = inputv('Enter email: ',@(x) ischar(x));

% save
clear subjID;
save('data/subjdata.mat');

end

