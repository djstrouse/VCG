function [] = ProcPopSpeech(subjID)
% Analyzes recorded spoken answers to populations quiz
%
% Written by: DJ Strouse
% Last updated: July 20, 2013 by DJ Strouse
%
% INPUTS
% subjID [=] scalar = ID of subject set during quiz administration
%
% OUTPUTS
% none

% init
load('data/subjdata.mat');
fs = 8000; % MATLAB default sampling rate

% segment speech
Nq = size(PopAudio,2);
for n = 1:Nq
  filename = ['data/segments/subj',int2str(subjID),'_pop_q',int2str(n),'.wav'];
  audiowrite(filename,PopAudio{subjID,n},fs);
  [segments,fs2] = detectVoiced(filename);
  PopAudioSegmented{subjID,n} = segments;
  if fs~=fs2
    disp(...
      'Warning: sampling rate for question %i changed from %f to %f.',...
      n,fs,fs2)
  end
  clear filename segments fs2;
end
clear n fs Nq;

% find f0 and formants

% save
save('data/subjdata2.mat');

end

