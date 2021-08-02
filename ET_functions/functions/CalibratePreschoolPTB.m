function calibPlotData = CalibratePreschoolPTB(Calib,morder,iter,donts)
%CALIBRATE calibrate the eye tracker
%   This function is used to set and view the calibration results for the tobii eye tracker.
%   Feb 2018: 
%       - modified for calibration of preschoolers by added sounds
%       - modified for display in PTB, so no JVM is required for
%         presentation
%   
%
%   Input: 
%         Calib: The calib structure (see CalibParams)
%         morder: Order of the calibration point 
%         iter: 0/1 (0 = A new calibation call, esnure that calibration is not already started)
%                   (1 = just fixing a few Calibration points)
%         donts: Points (with one in the index) that are to be
%         recalibrated, 0 else where
%   Output: 
%         calibPlotData: The calibration plot data, specifying the input and output calibration data

   
%for TESTING
% ETinit;
% SetCalibParams; 
% calibpoints = [];
% morder = randperm(Calib.points.n);
% iter=0
% donts=[]
   
    %clc
    assert(Calib.points.n >= 2 && length(Calib.points.x)==Calib.points.n, ...
      'Err: Invalid Calibration params, Verify...');

  %% initiation Psychtoolbox
%         sca;
%         close all;
%         clearvars; %this command prevents movies from working
        
        %allow sync tests of PTB
        Screen('Preference', 'SkipSyncTests', 0);
        %and present only critical PTB errors (=1)
        Screen('Preference', 'Verbosity', 1);
        

        % Here we call some default settings for setting up Psychtoolbox
        PsychDefaultSetup(2);

        %set global variables
        global window windowRect bgd ifi waitframes;
        
        %open window
        [window, windowRect] = PsychImaging('OpenWindow', Calib.extscreen, bgd);
       
        %timing settings
        ifi = Screen('GetFlipInterval', window);
        %demands, timing can be improved by increasing waitframes to 2
        waitframes = 1;

        %set processing priority
        topPriorityLevel = MaxPriority(window);
        Priority(topPriorityLevel);
        
        %hide mouse cursor on presentation screen
        %HideCursor(screenNumber);
        
        %define path where stimuli are found
        global path %from global path definition
        
        %for TESTING
        %path = fullfile('C:','Users','Nico','Documents','ETbat');
        %path = strcat(path,filesep);
  
        stimpath=strcat(path,'DEV',filesep);
        
        
        %% preparation of sound        
        % Initialize Sounddriver - (=1) in low latency mode
        InitializePsychSound(1);
        
        %shrinking sound
        wavfilename=strcat(stimpath,'att8.wav');
        % Read WAV file from filesystem:
        [y, freq] = psychwavread(wavfilename);
        wavedata = y';
        nrchannels = size(wavedata,1); % Number of rows == number of channels.
        % Try with the 'freq'uency we wanted:
        pahandle = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
        % Fill the audio playback buffer with the audio data 'wavedata':
        PsychPortAudio('FillBuffer', pahandle, wavedata);
        
        %moving sound
        wavfilename=strcat(stimpath,'att9.wav');
        [y, freq] = psychwavread(wavfilename);
        wavedata = y';
        nrchannels = size(wavedata,1); % Number of rows == number of channels.
        % Try with the 'freq'uency we wanted:
        pahandle2 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
        % Fill the audio playback buffer with the audio data 'wavedata':
        PsychPortAudio('FillBuffer', pahandle2, wavedata);
        
        %gain attention sound
        wavfilename=strcat(stimpath,'startatt.wav');
        [y, freq] = psychwavread(wavfilename);
        wavedata = y';
        nrchannels = size(wavedata,1); % Number of rows == number of channels.
        % Try with the 'freq'uency we wanted:
        pahandle3 = PsychPortAudio('Open', [], [], 0, freq, nrchannels);
        % Fill the audio playback buffer with the audio data 'wavedata':
        PsychPortAudio('FillBuffer', pahandle3, wavedata);
        
        %% preparation of visual stimulus
        % Set up alpha-blending for smooth (anti-aliased) lines
        Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
        % Here we load in an image from file. This one is a image of rabbits that
        % is included with PTB
        theImageLocation = strcat(stimpath,'tigger.png');
        [theImage, ~, alpha] = imread(theImageLocation);
        % Get the size of the image
        [s1, s2, ~] = size(theImage);
        %prepare alpha channel for transparency
        theImage(:,:,4) = alpha;
              
  %% calibration specific
  
    Calib.mondims = Calib.mondims1;
    
    if (iter==0)
        tetio_startCalib;    
    end
    
    idx = 0;
    validmat = ones(1,Calib.points.n);
    
    %generate validity matrix 
    if ~isempty(donts)
        validmat = zeros(1,Calib.points.n);
        for i = 1:length(donts)
           validmat(morder==donts(i))=1;
        end
    end
    
    %disp(num2str(validmat)):
    pause(1);
    %step= 10; %(increase for powerful pcs) changed to Calib.step
    %Calib.step;
    xposfinal=Calib.mondims.width*Calib.points.x(morder(1));
    yposfinal=Calib.mondims.height*Calib.points.y(morder(1));
    
    %% gain attention sound
    %play sound during moving
    PsychPortAudio('Start', pahandle3, 1, 0, 1);
    %stop this audio after waited for playback
    PsychPortAudio('Stop', pahandle3, 1);
  
    
    
    %% presentation loop
    for  i =1:Calib.points.n
        %show the big marker on a random (morder) position
        if (validmat(i)==0)
            continue;
        end
        
        idx = idx+1;
        %if it is not first show of big marker, move to next positioN
        if (idx ~= 1)
%             linecord = Drawline([Calib.mondims.width*Calib.points.x(morder(idx-1)) Calib.mondims.height*Calib.points.y(morder(idx-1))],...
%                 [Calib.mondims.width*Calib.points.x(morder(i)) Calib.mondims.height*Calib.points.y(morder(i))]);
%             
            %XY Positions of the moving dot
            xposstart = Calib.mondims.width*Calib.points.x(morder(idx-1));
            xposend = Calib.mondims.width*Calib.points.x(morder(i));
            xposfinal=xposend;
            xincrement=(xposend-xposstart)/Calib.delta;
            xpos=xposstart:xincrement:xposend;
                %if dot remains on same axis position
                if isempty(xpos)
                    xpos=repelem(xposend,Calib.delta+1);
                end 
            yposstart = Calib.mondims.height*Calib.points.y(morder(idx-1));
            yposend = Calib.mondims.height*Calib.points.y(morder(i));
            yposfinal=yposend;
            yincrement=(yposend-yposstart)/Calib.delta; %make sure that same number of steps on y axis
            ypos = yposstart:yincrement:yposend;
                if isempty(ypos)
                    ypos=repelem(yposend,Calib.delta+1);
                end 
            
            %play sound during moving
            PsychPortAudio('Start', pahandle2, 1, 0, 1);

            %move the calibration dot to target position
            vbl = WaitSecs('YieldSecs', ifi);
            for k = 1:length(xpos)
                % Center the rectangle on the centre of the screen
                centeredRect = CenterRectOnPointd([0 0 Calib.BigMark Calib.BigMark], xpos(k), ypos(k));
                % Draw the rect to the screen
                Screen('FillOval', window, Calib.fgcolor, centeredRect);
                % Flip to the screen
                vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); 
            end  
            
        end
        
        %play sound during shrinking
        PsychPortAudio('Start', pahandle, 1, 0, 1);

        %now shrink
        for j = 1:Calib.step
            if (j==1)
                randcolor = Calib.fgcolor;
                bigshrink = (Calib.SmallMark-Calib.BigMark)/Calib.step;
                bigsizes = Calib.BigMark:bigshrink:Calib.SmallMark;
                vbl = WaitSecs('YieldSecs', ifi);
            end 
       
                %shrinking big marker
                centeredRect = CenterRectOnPointd([0 0 bigsizes(j) bigsizes(j)], xposfinal, yposfinal);
                Screen('FillOval', window, randcolor, centeredRect);
                %define random color for shrinking big marker
                randcolor = [rand(1) rand(1) rand(1)];         
                %small marker
                centeredRect = CenterRectOnPointd([0 0 Calib.SmallMark Calib.SmallMark], xposfinal, yposfinal);
                Screen('FillOval', window, Calib.fgcolor2, centeredRect);                
                %flip both markers to screen
                vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
            
                        %add calibration point when data is recorded for this point
                        if (j==Calib.step)
                            if ~isempty(donts)
                                tetio_removeCalibPoint(Calib.points.x(morder(i)), Calib.points.y(morder(i)));
                                disp(['deleted point ' num2str(morder(i)) ' and now adding it, where i = ' num2str(i)]);
                            end
                            tetio_addCalibPoint(Calib.points.x(morder(i)),Calib.points.y(morder(i)));
                            pause(0.2);
                        end
                         
        end
        
        %present visual stimulus - after marker shrinking
       %center rect of size the image (s1,s2) to final marker pos
       % Make the image into a texture
       imageTexture = Screen('MakeTexture', window, theImage);
       vbl = WaitSecs('YieldSecs', ifi);
       centeredRect = CenterRectOnPointd([0 0 s1 s2], xposfinal, yposfinal);
       Screen('DrawTexture', window, imageTexture, [], centeredRect, 0);
       vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
       WaitSecs('YieldSecs',1);
            
    end
    %% compute calibration and produce output for PLOT handle
    %pause(1);
    tetio_computeCalib;  
    calibPlotData = tetio_getCalibPlotData;
      
    %% stop audio
    PsychPortAudio('Stop', pahandle2);
    PsychPortAudio('Stop', pahandle);
    PsychPortAudio('Close', pahandle);
    PsychPortAudio('Close', pahandle2);
    PsychPortAudio('Close', pahandle3);
    
end



