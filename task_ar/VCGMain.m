% VCG study -- Main program
% Nov. 2014 
% DJ Strouse
% Angela Radulescu

function [] = VGCMain()

clear all;

addpath('/Applications/Psychtoolbox/PsychBasic');
addpath('/Applications/Psychtoolbox/PsychOneliners');
addpath('/Applications/Psychtoolbox/PsychPriority');
addpath('/Applications/Psychtoolbox/PsychJava');
addpath('/Applications/Psychtoolbox/PsychAlphaBlending');
addpath('/Applications/Psychtoolbox/PsychSound');

retina = input('Are you running this on a retina laptop? (1=yes, 0=no) = ');
% skip sink tests (so that I can develop on the retina MacBook)
if retina
    Screen('Preference', 'SkipSyncTests', 1);
end

% valid keys 
Keys = [KbName('1!')  KbName('2@') KbName('3#') KbName('4$') KbName('5%') KbName('q')];

%% PARAMETERS 

% ------- QUIZ ------- %

% create data dir if it does not exist yet
if exist('dataQ', 'dir') == 0
    mkdir('dataQ')
end

ParmsQ.NQuestions = 30;   % number of questions

% Instructions
ParmsQ.Instructions = 1;

% Timing 
ParmsQ.Timeout = 2.5;          
ParmsQ.OutcomeTime = 1;        
ParmsQ.StimTime = 0.5;
ParmsQ.ITImax = 2;              
ParmsQ.ITImin = 1;
ParmsQ.ITI = 1.5;
ParmsQ.ISI = 0.3;         

% % ------- PSYCHOPHYSICS ------- %
% 
% % create data dir if it does not exist yet
% if exist('dataT', 'dir') == 0
%     mkdir('dataT')
% end
% 
% % Timing 
% ParmsT.Timeout = 2.5;          
% ParmsT.OutcomeTime = 1;        
% ParmsT.StimTime = 0.5;
% ParmsT.ITImax = 2;              
% ParmsT.ITImin = 1;
% ParmsT.ITI = 1.5;
% ParmsT.ISI = 0.3; 

%% Run experiments

% get input from experimenter -- subject number and routine combination
SubjectNum = input('Please enter subject number: ');
ParmsQ.SubjectNum = SubjectNum;

Q = input('Give quiz? (1=yes, 0=no) = ');
if ~numel(Q)
    Q = 0;
end

T = input('Run task? (1=yes, 0=no) = ');
if ~numel(T)
    T = 0;
end

if Q+T == 0
   error('Please select at least one experiment!')
end

% make random seed different each time (mt19937ar is the name of the algorithm that matlab
% uses; type 'doc randstream' for others)
s = RandStream.create('mt19937ar','seed',sum(100*clock));
RandStream.setGlobalStream(s);
tSave = fix(clock);              % to use as a timestamp for saving later

% open window 
[windowmain, rect] = Screen('OpenWindow',0,[0 0 0]); % on black 
Screen('TextFont', windowmain, 'Courier New');
Screen('TextSize',windowmain,40);
HideCursor;
% Priority(9);

% welcome message
tstring = sprintf('Welcome and thank you for \n participating in this experiment! \n\n Please press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255]);
Screen('Flip',windowmain);
KbWait(-1); 
WaitSecs(0.5);

% running the quiz
if Q
    if ParmsQ.Instructions 
        QuizInstructions(windowmain,ParmsQ)
    end
    % GiveQuiz();     
end

Screen('CloseAll');
ShowCursor;
   
    
end

function [] = QuizInstructions(windowmain,Parms)
        
tstring = sprintf('You will be taking a quiz asking you to compare the areas and populations of countries.\n The first half of the quiz will focus on areas; the second half on populations.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1); 
WaitSecs(0.5);        
tstring = sprintf('For each question, the names of two countries will appear on the computer screen.\n One of them will have a one next to it, the other a two.\n You will be speaking the number corresponding the country you believe has the larger area/population.\n Do not say anything other than ?one? or ?two?, including ?um? or the names of the countries.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1); 
WaitSecs(0.5);
tstring = sprintf('Take the time you need to choose your answer, but do answer as soon as you can.\n After speaking your answer, you will hit any key on the keyboard \n and then be asked to enter your answer numerically as well.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1);
WaitSecs(0.5);
tstring = sprintf('Once you have answered the question, you will be asked to place a bet on your answer.\n The value of your bet will range from one to five (so one, two, three, four, or five).\n You should bet high when you are confident of your answer, low when you are not.\n So a five would correspond to near-certainty, and a one to pure guessing.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1);
WaitSecs(0.5);
tstring = sprintf('Later on, another person will be listening to your answers and also placing bets.\n For each correct answer, you will gain a number of points equal to the average bet that the two of you placed;\n for each incorrect answer, you will lose a number of points equal to the average bet.\n We will announce your score and the top performers later by email.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1);
WaitSecs(0.5);
tstring = sprintf('You will answer 40 questions on area, then 40 questions on population.\n After every 20 questions, you will get a report on how well you are performing.\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1);
WaitSecs(0.5);
tstring = sprintf('To help get you familiar with the experiment,\n you will first go through a ?pre-quiz? involving just three questions of each type.\n Do you have any questions before we begin?\n\n\n Press any key to continue.');
DrawFormattedText(windowmain,tstring,'center','center',[255 255 255],70);
Screen('Flip',windowmain);
KbWait(-1);
WaitSecs(0.5);


end


function [] = GiveQuiz()
    
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

end
    
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
  answer = input('Choose 1 or 2 by speaking: ');
    % @(x) (x==1)||(x==2));
  if SubSampedPopulation(x1)>SubSampedPopulation(x2)
    key = 1;
  else
    key = 2;
  end
  feedback(n) = answer==key; clear answer key x1 x2;
  conf = input('Place your bet from 1 (lowest confidence) to 5 (highest confidence) by typing: ');
    % @(x) (x==1)||(x==2)||(x==3)||(x==4)||(x==5)); clear conf;
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

    
    
    