function voddball2   

%initdummy
%Screen('Preference', 'TextRenderer', 1)

fprintf(1,'task:VISUAL ODDBALL\n');

    %visual oddb all paradigm 2
    
    %changes from voddball to voddball2 - July 2021
       %remove movie 
       %change stimuli: filled circles 
       %add sound 
       %changed code structure
       %able to skip
       %check if events are correctly written

global bgd windowRect window colran yCenter xCenter screenXpixels screenYpixels ifi waitframes vbl Dcol Tcol path;

%specific to voddball settings

    number_of_trials = 15;
    %target_probability = 0.2; %not needed as hardcoded, see below (thus no need for additional packages)
    
    stimpres = 0.250 ; %stimulus presentation time
    isi = 2; %inter stimulus interval
    
    base_size_stimuli = 120;
    ratio_stimuli = 1.5; %difference in size between target-distractor
    
    sound_duration = 0.1;
    base_frequency = 500; %base pitch of sound 500Hz   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function skip/break on keypress
  
   %Wait for seconds (defined by isi) or keypress
    break_loop = 0;
    function [break_loop] = wait_or_break(time,break_loop)
    
      tEnd=GetSecs+time;
      while GetSecs<tEnd
        WaitSecs(0.001);
        if KbCheck
          break_loop = 1;
        end
      end  
      
    end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      define target and distractor stimuli
       
      function display_target
        vbl = Screen('Flip', window); %timing 
        %make stimulus
        maxDiameter = max(size_target);
        centeredRect = CenterRectOnPointd(size_target, xCenter, yCenter);  
        Screen('FillOval', window, Tcol, centeredRect, maxDiameter);
        %play sound
        %Beeper(frequency_target, 1, sound_duration);
        PsychPortAudio('Start', pahandleTarget, 1, 0, waitForDeviceStart); 
        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        %note event
        ETevent(strcat('target_','col:',num2str(Tcol),'_freq:',num2str(frequency_target),'_size:',num2str(Tsize)))
        % Wait for presentation time
        [break_loop] = wait_or_break(stimpres,break_loop);
        % Color the screen to background
        Screen('FillRect', window, bgd);
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        %WaitSecs(isi);
        [break_loop] = wait_or_break(isi,break_loop);
      end
      
      function display_distractor
        vbl = Screen('Flip', window); %timing
        %make stimulus
        maxDiameter = max(size_distractor);
        centeredRect = CenterRectOnPointd(size_distractor, xCenter, yCenter);  
        Screen('FillOval', window, Dcol, centeredRect, maxDiameter);
        %play sound
        Beeper(frequency_distractor,1, sound_duration);
        PsychPortAudio('Start', pahandleDistractor, 1, 0, waitForDeviceStart);
        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        %note event
        ETevent(strcat('distractor_','col:',num2str(Dcol),'_freq:',num2str(frequency_distractor),'_size:',num2str(Dsize)))
        % Wait for presentation time
        [break_loop] = wait_or_break(stimpres,break_loop);
        % Color the screen to background
        Screen('FillRect', window, bgd);
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        %WaitSecs(isi);
        [break_loop] = wait_or_break(isi,break_loop);
    
      end
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      prepare display of stimuli with probability of 80%/20%

      %assign stimuli to idx values
      function rndstim(id) 
          if id == 1
              display_distractor;
          elseif id == 2
              display_target;
          end
      end
  
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% SPECIFIC INIT

       % Get the size of the on screen window
      [screenXpixels, screenYpixels] = Screen('WindowSize', window);
      % Get the centre coordinate of the window
      [xCenter, yCenter] = RectCenter(windowRect);  

      %timing settings
      vbl = Screen('Flip', window);
      ifi = Screen('GetFlipInterval', window);
      waitframes = 1;

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%      random selection of stimulus properties

   % random color
   colran = [0 0 1; 1 0 0];

       %chose random color for random stimuli 
       cposD = randi(size(colran,1));
       Dcol = colran(cposD,:);
       colran(cposD,:) = []; %prevent reselecting random color

       cposT = randi(size(colran,1));
       Tcol = colran(cposT,:);
       colran(cposT,:) = [];
       
   % random size
   sizeran = [base_size_stimuli; base_size_stimuli/ratio_stimuli];   
   
      sposD = randi(size(sizeran,1));
      Dsize = sizeran(sposD, :);
      size_distractor = [0 0 Dsize Dsize]; %assign size
      sizeran(sposD,:) = []; %prevent reselecting of size 
      
      sposT = randi(size(sizeran,1));
      Tsize = sizeran(sposT, :);
      size_target = [0 0 Tsize Tsize]; %assign size
      sizeran(sposT,:) = []; %prevent reselecting of size 
      
   % random frequency
   freqran = [base_frequency; base_frequency+250];
   
      fposD = randi(size(freqran,1));
      frequency_distractor = freqran(fposD, :);
      freqran(fposD,:) = [];
      
      fposT = randi(size(freqran,1));
      frequency_target = freqran(fposT, :);
      freqran(fposT,:) = [];      


 %% preparation of sound        
        % Initialize Sounddriver - (=1) in low latency mode
        InitializePsychSound(1);
        
        % Number of channels and Frequency of the sound
        nrchannels = 1;
        freq = 48000;
               
        % Should we wait for the device to really start (1 = yes)
        % INFO: See help PsychPortAudio
        waitForDeviceStart = 1;

        % Open Psych-Audio port, with the follow arguements
        % (1) [] = default sound device
        % (2) 1 = sound playback only
        % (3) 1 = default level of latency
        % (4) Requested frequency in samples per second
        % (5) 2 = stereo putput
        pahandleTarget = PsychPortAudio('Open', [], 1, 1, freq, nrchannels);
        pahandleDistractor = PsychPortAudio('Open', [], 1, 1, freq, nrchannels);

        % Set the volume to half for this demo
        %PsychPortAudio('Volume', pahandle, 1);
        %PsychPortAudio('Volume', pahandle, 1);

        % Make a beep which we will play back to the user
        BeepTarget = MakeBeep(frequency_target, sound_duration, freq);
        BeepDistractor = MakeBeep(frequency_distractor, sound_duration, freq);

        % Fill the audio playback buffer with the audio data, doubled for stereo
        % presentation
        PsychPortAudio('FillBuffer', pahandleTarget, BeepTarget);
        PsychPortAudio('FillBuffer', pahandleDistractor, BeepDistractor);
      
try
      
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%      experimental trial

   disp('Continue with EXPERIMENTAL trial...');

  ETevent('voddball_exptrials_start'); 
     
  %attention grabbing cross   
  %cblinkcross(5,1); 
  
  %random display if distractor and stimuli
  idx = [1 1 1 1 1 1 1 2 2 2]; %in the last 10 trials likeliood of target = 30% (20% in total of 15 trials)
        
  for i = 1:number_of_trials %error: out of range?
    
      %attention grabber
      cblinkcross(10,0.25);
      colscreen(bgd,0.25);
    
      if i<6
        display_distractor % first 5 trials show distractor
      else
       
        k = randi(numel(idx));
        %disp(idx(k)); %checks display of stimuli
        rndstim(idx(k));
        idx(k) = [];       
     % k = rand; #select random number between 0 and 1 
     % if k < 1-target_probability
     %  display_distractor
     % else 
     %  display_target
     % endif 
      
        %idx = randsample(2,10,true,[1-target_probability target_probability])
        
      end
      
      %break if key was pressed
      if break_loop == 1
        break; 
      end
    
  end

  %filler colors screen
  %colscreen(bgd,2); 

  ETevent('voddball_exptrials_end'); 
        
catch
    
  sca;
  psychrethrow(psychlasterror);
    
end  
  
 %enddummy
 
 PsychPortAudio('Stop', pahandleTarget);
 PsychPortAudio('Stop', pahandleDistractor);
 PsychPortAudio('Close', pahandleTarget);
 PsychPortAudio('Close', pahandleDistractor);

end   