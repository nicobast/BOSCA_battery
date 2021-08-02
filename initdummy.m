function initdummy
 
devmode = 1; %set to 1 to deactivate eye-tracking, DEFAULT = 0

%% DEV MODE - changes eye-tracking functions to dummy
    if devmode==1
    disp('DEV MODE IS ACTIVATED: NO EYE-TRACKING - NO DATA SAVE')
    %Screen('Preference', 'SkipSyncTests', 1) %skips synchronization testing
    global path
    path = fullfile('C:','Users','Nico','PowerFolders','ETbat');
    path = strcat(path,filesep);
    addpath(genpath(path));
    %remove ET functions and add dummy func prevent eye and data recording
    rmpath(strcat(path,'ET_functions'));
    locdummyET = fullfile('C:','Users','Nico','PowerFolders','ETfunction_dummys');
    addpath(locdummyET);
    end

 % Clear the workspace and the screen
        sca;
        close all;
        %clearvars; %this command prevents movies from working
        
        %start of the experiment to later calculate duration
        startexp = GetSecs;
        
        % Here we call some default settings for setting up Psychtoolbox
        PsychDefaultSetup(2);

        % Get the screen numbers. This gives us a number for each of the screens
        % attached to our computer.
        % on LINUX, need to run XOrgConfCreator.m to setup multidisplay
        % set the multidisplay setup by XOrgConfSelector once
        screens = Screen('Screens');
        
        % To draw we select the maximum of these numbers. So in a situation where we
        % have two screens attached to our monitor we will draw to the external
        % screen.
        %LINUX safe:
        screenNumber = max(screens);
        %WINDOWS OS: depending on connecting of displays, OS assigns screen numbers
        %assign the screen number of DISPLAY1
        %screenNumber = 1;
           
        % Define black and white (white will be 1 and black 0). This is because
        % in general luminace values are defined between 0 and 1 with 255 steps in
        % between. All values in Psychtoolbox are defined between 0 and 1
        white = WhiteIndex(screenNumber);
        black = BlackIndex(screenNumber);
        
        %set global variables
        global window windowRect bgd path ifi waitframes session;
          
        %global path definition
        if devmode==0
        path = fullfile('C:','Users','Nico','Documents','ETbat');
        path = strcat(path,filesep);
        addpath(genpath(path));
        
            %% initialize & start eye tracker on devmode=0
             global pname;
             pname = input('Enter ID:','s'); %enter participant ID
             cd(fullfile('C:','Users','Nico','Documents','ETbat')); %switch to main directory
             ETinit;
             ETstart;
             %ETevent('start');
        end
        
        %Psychtoolbox Preferences
        %change start up screen to black slide
        Screen('Preference', 'VisualDebugLevel', 1);
        %output errors and warnings of psychtoolbox (=2)
        Screen('Preference', 'Verbosity', 2);
        %activate synchronization testing
        Screen('Preference', 'SkipSyncTests', 0) 
        
        % Open an on screen window using PsychImaging and color it according to bgd.
        bgd = 1;
        if devmode==1
           %[window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
           [window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd, [1 1 1280 720]);
           Screen('Preference', 'SkipSyncTests', 1) %skips synchronization testing
        else 
           [window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
        end 
        
        
        % in devmode present smaller window in upper right quarter
        
        %timing settings
        ifi = Screen('GetFlipInterval', window);
        %demands, timing can be improved by increasing waitframes to 2
        waitframes = 1;

        %set processing priority
        topPriorityLevel = MaxPriority(window);
        Priority(topPriorityLevel);
        
        %hide mouse cursor on presentation screen
        HideCursor(screenNumber);
        %send print directly to command window (OCTAVE)
        %more off;
            
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% TASK SPECIFIC SETTINGS
 global rewardtrials vissearchtrials voddballtimes outlist natlist blockblist;

 rewardtrials=3; %20 in final rewardblock
 vissearchtrials=3; %16 trials per block in final visualsearch
 voddballtimes=1; %4 target-distractor presentations in final voddball
 
 outlist = 0; %set to zero so it loads emoexpression list on first call
 natlist = 0; %set to zero so it loads naturalorienting stimuli list 
 blockblist = 0; %set to zero so it loads tests of testblockB
  
 end