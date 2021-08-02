function ETbattery

try
%troubleshooting:
    %CHECK: is second display set as primary display in windows?
    %set primary display back and forth
    %restart matlab
    %restart windows

%PREPARE
%1 open grey background --> Ctrl + H = Fullscreen
%2 open basic eye tracking sample on first screen
%3 set task bmar to vanish
%record screen win+alt+r - on startup
    
%start
%current version: Version 0.4
    %version 0.1: all tasks implemented
    %version 0.2: added randomizaiton of presentation
    %version 0.3: implementation of eye-tracking
    %version 0.4: implementation of gaze contingency in vsearch & reward
    %version 0.5: changes after testing typically developed adults
        %potential changes:
        %audio in videos?
        
        %DONE CHANGES
        %ETevent in voddball for experimental trials
        %ETevent in emoexp with better naming
        %presreward: questionmark --> treasure
        %visual search: more coherent to Gliga2015
    
%parameters within paradigms
    %visual search: trials per block: 16 (Gliga, 2014)
    %visual oddball: pretrial familiarization: n = 5 for each stimulus
    %reward number of trials: n = 20 (Stavropolous,)
    
fprintf(1,'<strong>EYE-TRACKING TESTBATTERY 0.5</strong>\n')

%% initialize eye tracker
    %add global eye tracking data variables
    %these global variables are defined and handled within Et functions:
    % ETl ETr ETt ETevT ETevN
    global pname;
    pname = input('<strong>Enter ID: </strong>\n','s'); %enter participant ID
    cd 'C:\Users\Nico\Documents\MATLAB\'; %switch to main directory
    ETinit;
    
    
%% calibrate eye tracker
    %check position with .NET programm 'Basic Eyetracking Sample'
      fprintf(1,'<strong>Position %s for CALIBRATION. KEY PRESS to continue</strong>\n',pname);
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
        screens = Screen('Screens');
        
        % To draw we select the maximum of these numbers. So in a situation where we
        % have two screens attached to our monitor we will draw to the external
        % screen.
            screenNumber = max(screens);
            %screenNumber = 2;


        % Define black and white (white will be 1 and black 0). This is because
        % in general luminace values are defined between 0 and 1 with 255 steps in
        % between. All values in Psychtoolbox are defined between 0 and 1
        white = WhiteIndex(screenNumber);
        black = BlackIndex(screenNumber);
        
        %set global variables
        global window windowRect bgd path ifi waitframes session;
                
        %global path definition
        path = 'C:\Users\Nico\Documents\MATLAB\';
        
        % Open an on screen window using PsychImaging and color it according to bgd.
        bgd = 1;
        [window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
        
        %timing settings
        % vbl = Screen('Flip', window);
        ifi = Screen('GetFlipInterval', window);
        %waitframes = 1 ensures seamless presentation but high timing
        %demands, timing can be improved by increasing waitframes to 2
        waitframes = 2;

        %set processing priority
        topPriorityLevel = MaxPriority(window);
        Priority(topPriorityLevel);
        
        %EyeTracking setting - for mouse as emulated ET
        %global ETcall
        % ETcall=0;
        
        %hide mouse cursor on presentation screen
        HideCursor(screenNumber);
            
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %% TASK SPECIFIC SETTINGS
 global outlist natlist blockblist;
 
 % emoexpression
 outlist = 0; %set outlist to zero so it loads list on first call
 natlist = 0; %natural orienting stimuli list 
 blockblist = 0; %set variable for testblock b
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              START SCREEN

colscreen(bgd,0)
fprintf(1,'<strong>...all is set. KEY PRESS to start experiment</strong>\n');

%% start eye tracker (start to already record data of start screen
   ETstart;
   ETevent('start') 

%% wait for keypress after start screen   
KbWait; %maybe put a sound file here to get attention

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%             DESIGN Description

% info: blocking in pseudorandom order
% blockA: (tests are all presented in each block in random order) 
    %emo expression SOCIAL REWARD /SOCIAL ORIENTING
    %visual search ORIENTING 
    %natural orienting SOCIAL ORIENTING
%blockB: (each block presents one test)
    %visual oddball ALERTING
    %smooth pursuit ORIENTING
    %reward guessing game NONSOCIAL/SOCIAL REWARD
% what about ToM?
%gaze orienting?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             INTRO
session = '_intro';

%%      2.5Hz flickering fixcross fixationcross for 1.25 seconds (Shirama, 2016)
 task = 'fixationstability';
 fprintf(1,'<strong>INTRO: %s</strong>\n',task);
 ETevent(strcat(task,session)); %records event of task
 eval(task); %executes script that is written as string in task

%%      - intro movie
task = 'motmovie';
fprintf(1,'<strong>task: INTRO MOVIE %s</strong>\n',task);
ETevent(strcat(task,session));
%intromovie([path task]); %starts an intromovie named after task 
intromovie('C:\Users\Nico\Documents\MATLAB\NightgardenIntro.mp4') % does not work for [path task] input?
colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             SESSION 1
session = '_1';
ETevent(strcat('session',session))

%% TESTBLOCK A1 - blocks of: visual search, emotion expression, natural orienting
task = 'testblockA';
fprintf(1,'Press button to continue with...<strong>task: %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task); % random permutation of these blocks

    %% save ET data
    ETrec
    ETsave

%% TESTBLOCK B1
task = 'testblockB';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task);

    %% save ET data
    ETrec
    ETsave

%%      - motivational movie 1
task = 'motmovie';
% fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
% ETevent('waitbpress');
% KbWait;
ETevent(strcat(task,session));
intromovie([path 'Motmovie\minions1.mp4']);
colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             SESSION 2
session = '_2';
ETevent(strcat('session',session))

%% TESTBLOCK A2 - blocks of: visual search, emotion expression, natural orienting
task = 'testblockA';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task); % random permutation of these blocks

    %% save ET data
    ETrec
    ETsave

%% TESTBLOCK B2
task = 'testblockB';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task);

    %% save ET data
    ETrec
    ETsave

%% motivational movie 2
task = 'motmovie';
% fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
% ETevent('waitbpress');
% KbWait;
ETevent(strcat(task,session));
intromovie([path 'Motmovie\trains.mp4']);
colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             SESSION 3
session = '_3';
ETevent(strcat('session',session))

%% TESTBLOCK A3 - blocks of: visual search, emotion expression, natural orienting
task = 'testblockA';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task); % random permutation of these blocks

    %% save ET data
    ETrec
    ETsave

%% TESTBLOCK B3
task = 'testblockB';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task);

    %% save ET data
    ETrec
    ETsave

 %% motivational movie 3
task = 'motmovie';
% fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
% ETevent('waitbpress');
% KbWait;
ETevent(strcat(task,session));
intromovie([path 'Motmovie\minions2.mp4']);
colscreen(bgd,2);

    %% save ET data
    ETrec
    ETsave

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             SESSION 4
session = '_4';
ETevent(strcat('session',session))

%% TESTBLOCK A4 - blocks of: visual search, emotion expression, natural orienting
task = 'testblockA';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task); % random permutation of these blocks

    %% save ET data
    ETrec
    ETsave

%% TESTBLOCK B4
task = 'testblockB';
fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
ETevent('waitbpress');
KbWait;
ETevent(strcat(task,session));
eval(task);

    %% save ET data
    ETrec
    ETsave

%  %% motivational movie 4
% task = 'motmovie';
% fprintf(1,'Press button to continue with...<strong> %s:</strong>\n',task);
% ETevent('waitbpress');
% KbWait;
% ETevent(strcat(task,session));
% intromovie([path 'Motmovie\nightgardenSocialTwo2.mp4']);
% colscreen(bgd,2);
% 
%     %% save ET data
%     ETrec
%     ETsave
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             OUTRO 
session = '_outro';

%%      2.5Hz flickering fixcross fixationcross for 1.25 seconds (Shirama, 2016)
task = 'fixationstability';
fprintf(1,'<strong>OUTRO: %s</strong>\n',task);
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
