function ETbattery08

% DESIGN Description: experiment consists of four sessions
% session = blockA + blockB + blockC + mot movie clip
% blockA: (tests are all presented in each block in random order) 
    %emo expression SOCIAL REWARD /SOCIAL ORIENTING
    %visual search ORIENTING 
    %natural orienting SOCIAL ORIENTING
%blockB: (each block presents one test)
    %visual oddball ALERTING
    %smooth pursuit ORIENTING
    %reward guessing game NONSOCIAL/SOCIAL REWARD  
%blockC: Scaer tasks
    %biological motion
    %joint attention
    % --> tasks are split to fit into 4 sessions
% tests within blocks are presented in pseudorandom order

%current version: Version 0.7
    %version 0.1: all tasks implemented and randomized
    %version 0.2: implementation of eye-tracking
    %version 0.3: implementation of gaze contingency in vsearch & reward
    %version 0.4: changes after testing typically developed adults
        %ETevent in voddball for experimental trials
        %ETevent in emoexp with better naming
        %presreward: questionmark --> treasure
        %visual search: more coherent to Gliga2015
    %version 0.5: conversion to Linux(Ubuntu16.04LTS)/Octave compatability
    %version 0.6: looping & inclusion of testblock C
    %version 0.65: bug hunting & optimization
    %version 0.7 (February 2020): deleting reward task and visual oddball task
        %altered: testblockB_ver07
        %added: fixationcross_test
        %shuffled random number generation algorithm
    %version 08 (July 2021): 
        % testing with Octave 6.2 + 3.0.17
        % reduced visualsearch trials (16 --> 8) and made them skippable
        % added "KbReleaseWait;" to natorient to prevent skipping
        % exchanged videos: intro_train, motivation video: minions_mermaids
        % added voddball2 to testblockB
        % TODO: reset paths, uncomment rng shuffle (not available in Octave)
          %changed and added tasks
            % - visualsearch, testblockB, ETbattery08, initdummy, voddball2
            
%WINDOWS Troubleshooting :
    %CHECK: is second display set as primary display in windows?
    %set primary display back and forth - when matlab is open
    %restart matlab
    %restart windows
%PREPARE in WINDOWS setting:
    %1 open grey background --> Ctrl + H = Fullscreen
    %2 set taskbar to vanish
    %dual monitor setup - external screen with same resolution must be set
    %"above" internal screen - see SetCalibrationParams
    %battery is optimized for a screen resolution of: 1920 * 1080

try
        
disp('EYE-TRACKING TESTBATTERY 0.8')

%% DEVMODE - changes eye-tracking functions to dummy
devmode = 1; %set 1 to deactivate eye-tracking + data rec, DEFAULT = 0 !!!

%GLOBAL PATH definition - and add path and subfolders
    if devmode==0
    global path
    path = fullfile('C:','Users','bastadmin','Documents','ETbat');
   % path = fullfile('S:','KJP_Studien','DFG_A-FFIP','6_Projekte','EyeTracking_Studie_Polzer','2_Design','ETBat','ETbat');
   % path = fullfile('C:','Users','Leonie_Polzer','Documents','ETBat','ETbat')
    path = strcat(path,filesep);
    addpath(genpath(path));
    end

% DEV MODE 
    if devmode==1
    disp('DEV MODE IS ACTIVATED: NO EYE-TRACKING - NO DATA SAVE')
    global path
    path = fullfile('C:','Users','Nico','Documents','ETbat');
    % path = fullfile('C:','Users','bastadmin','Documents','ETbat');
    
    path = strcat(path,filesep);
    addpath(genpath(path));
    %remove ET functions and add dummy func prevent eye and data recording
    rmpath(strcat(path,'ET_functions'));
    locdummyET = 'C:\Users\Nico\Documents\ETfunction_dummys';
    %locdummyET = 'C:\Users\Nico\PowerFolders\ETfunction_dummys';
    %locdummyET = 'C:\Users\bastadmin\Documents\ETfunction_dummys';
    addpath(locdummyET);
    
    %add psychtoolbox path (in MAtlab this is predefined in PATHS)
    path_psychtoolbox = 'C:\toolbox\Psychtoolbox';
    addpath(path_psychtoolbox)
    
    end
    
%% initialize eye tracker
    %add global eye tracking data variables
    %these global variables are defined and handled within Et functions:
    % ETl ETr ETt ETevT ETevN
    global pname;
    pname = input('Enter ID:','s'); %enter participant ID
    cd(path); %switch to main directory
    %cd(fullfile('C:','Users','Nico','PowerFolders','ETbat')); %switch to main directory
    %cd(fullfile('C:','Users','bastadmin','Documents','ETbat')); %switch to main directory
    ETinit;
    
%% calibrate eye tracker
    %check position with .NET programm 'Basic Eyetracking Sample'
      fprintf(1,'Position %s for CALIBRATION. KEY PRESS to continue\n',pname);
      KbWait;
      ETcalib; %calibration procedure   
      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%            INIT PSYCHTOOLBOX 

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
        %screenNumber = 2;
           
        % Define black and white (white will be 1 and black 0). This is because
        % in general luminace values are defined between 0 and 1 with 255 steps in
        % between. All values in Psychtoolbox are defined between 0 and 1
        white = WhiteIndex(screenNumber);
        black = BlackIndex(screenNumber);
        
        %set global variables
        global window windowRect bgd ifi waitframes session;
          
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
           Screen('Preference', 'SkipSyncTests', 0) %skips synchronization testing
        else 
           [window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
        end 
        
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
            
        %initialize high quality TextRenderer once at start
        %this prevents lags on first stimuli in visual search
        Screen('DrawText', window, 'test')

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% TASK SPECIFIC SETTINGS
 global vissearchtrials outlist natlist blockblist;

 %rewardtrials=10; #commented out as task is excluded
 %voddballtimes=10; #commented out as task is excluded
 vissearchtrials=8; %reduced from 16 to 8 #Nico 260721
 
 outlist = 0; %set to zero so it loads emoexpression list on first call
 natlist = 0; %set to zero so it loads naturalorienting stimuli list 
 blockblist = 0; %set to zero so it loads tests of testblockB
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              START SCREEN

colscreen(bgd,0)
disp('...all is set. KEY PRESS to start experiment');

%% start eye tracker (start to already record data of start screen
   ETstart;
   ETevent('start') 
   ETevent('start_ETbattery08') 

%% wait for keypress after start screen   
KbWait; %maybe put a sound file here to get attention
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             INTRO
session = '_intro';  

%%      2.5Hz flickering fixcross fixationcross for 1.25 seconds (Shirama, 2016)
 task = 'fixationstability';
 fprintf(1,'INTRO: %s',task);
%  ETevent(strcat(task,session)); %records event of task
 eval(task); %executes script that is written as string in task
 
%%      - intro movie
task = 'motmovie';
fprintf(1,'task: INTRO MOVIE %s\n',task);
ETevent(strcat(task,session));
intromovie(strcat(path,'intro_train_clip.mp4')) % does not work for [path task] input?
%intromovie(strcat(path,'NightgardenIntro.mp4')) % does not work for [path task] input?
colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave

%% Shuffle the random number generation algorithms (in order to use randi and randperm) %Leonie%

rng shuffle %commented as not supported in octave %Nico 260721

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             SESSIONS

sessions ={'_1';'_2';'_3';'_4'};
motmovie ={'minions1.mp4';'minions_mermaids.mp4';'minions2.mp4';'NONE'};
%motmovie ={'minions1.mp4';'trains.mp4';'minions2.mp4';'NONE'};
for i = 1:numel(sessions)
  session = strjoin(sessions(i));
  ETevent(strcat('session',session))
  
  rng shuffle %commented as not supported in octave %Nico 260721
  
  %% TESTBLOCK A - blocks of: visual search, emotion expression, natural orienting
   task = 'testblockA';
   fprintf(1,'Press button to continue with...task: %s:\n',task);
   ETevent('waitbpress');
   KbWait;
   ETevent(strcat(task,session));
   eval(task); % random permutation of these blocks
  
      %% save ET data
      ETrec
      ETsave
      
  %% TESTBLOCK B - blocks of: reward, smoothpursuit, voddball, (only smoothpursuit remains in version 0.7
  task = 'testblockB';
  fprintf(1,'Press button to continue with...task: %s:\n',task);
  ETevent('waitbpress');
  KbWait;
  ETevent(strcat(task,session));
  eval(task);

      %% save ET data
      ETrec
      ETsave
      
  %% TESTBLOCK C - Schaer tasks: jointattention, biomotion
  task = 'testblockC';
  fprintf(1,'Press button to continue with...task: %s:\n',task);
  ETevent('waitbpress');
  KbWait;
  ETevent(strcat(task,session));
  eval(task);

      %% save ET data
      ETrec
      ETsave
      
   %% MOTIVATIONAL MOVIE
  task = 'motmovie';
  disp(strcat(task,':',strjoin(motmovie(i))));
        if i==4
        break
        end
  %ETevent(strcat(task,session));
  intromovie(fullfile(path,'Motmovie',strjoin(motmovie(i))));
  colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave
 
    %testing - activate to end after one session
    %enddummy    
    
end   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             OUTRO 
session = '_outro';

%%      2.5Hz flickering fixcross fixationcross for 1.25 seconds (Shirama, 2016)
task = 'fixationstability';
fprintf(1,'OUTRO: %s\n',task);
ETevent(strcat(task,session)); %records event of task
eval(task); %executes script that is written as string in task

ETevent('end') %needs to be before last ETrec
    
    %% save ET data
    ETrec
    ETsave
    
%% Eye tracking functions
ETend
enddummy 
 
%catch loop to prevent failing of closing window - sca
catch  
    % Recover - capture recorded eye tracking data when script fails
    global ETevT ETevN ETl ETr ETt;
    cd data
    csvwrite(strcat('RECOVER',pname,'_','gazedata.csv'), [ETl ETr]);
    dlmwrite(strcat('RECOVER',pname,'_','timestamps.csv'), ETt,'precision','%i','delimiter',',');
        eventdata = [ETevN, num2cell(ETevT/1000)];
        [nrows,~] = size(eventdata);
    fid = fopen(strcat('RECOVER',pname,'_','event.csv'),'w+');
       for row = 1:nrows
        fprintf(fid, '%s,%i\r\n', eventdata{row,:});
       end 
    fclose(fid);
    cd ..
   
    % disp('Error')
    Priority(0); 
    Screen('CloseAll');
    psychrethrow(psychlasterror);
    sca;
end

end
