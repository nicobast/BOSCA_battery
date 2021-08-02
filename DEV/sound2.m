function sound2(repetitions, wavfilename)

 
%% sound preparation 
wavfilename='C:\Users\Nico\Documents\ETbat\DEV\boing_x.wav';
repetitions=1;

% Initialize Sounddriver - (=1) in low latency mode
InitializePsychSound(1);

% Read WAV file from filesystem:
[y, freq] = psychwavread(wavfilename);
wavedata = y';
nrchannels = size(wavedata,1); % Number of rows == number of channels.

% Try with the 'freq'uency we wanted:
pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);

% Fill the audio playback buffer with the audio data 'wavedata':
PsychPortAudio('FillBuffer', pahandle, wavedata);


%% start playback - comes within loop

% Start audio playback for 'repetitions' repetitions of the sound data,
% start it immediately (0) and wait for the playback to start, return onset
% timestamp.
PsychPortAudio('Start', pahandle, repetitions, 0, 1);

%wait during play? - what to do during play
WaitSecs(1);

%% end

% Stop playback:
PsychPortAudio('Stop', pahandle);

% Close the audio device:
PsychPortAudio('Close', pahandle);

end