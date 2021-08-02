% Clear the workspace and the screen
sca;
close all;
clearvars;

%% CHECK WITH OTHER INIT

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
%screenNumber = max(screens);
screenNumber = 1;

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, 1);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%% TASK SPECIFIC

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% STIMULUS CREATION

stimcase = randi(4)
    %cases: 
        %1 = won + social
        %2 = won + scramble
        %3 = loss + social
        %4 = loss + scramble

 switch stimcase 
     case 1
         inlist = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\SOC\won';
         midpath = '\SOC\won\';
     case 2
         inlist = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\NON\won';
         midpath = '\NON\won\';
     case 3
         inlist = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\SOC\lost';
         midpath = '\SOC\lost\';
     case 4
         inlist = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\NON\lost';
         midpath = '\NON\lost\';
 end     

% Here we load in a random image from file for specific stimcases
    %positive = surprised, (happy),
    %negative = sad, (disappointed)
f = dir(inlist);
f = f(3:length(f),:); %remove weird folder entries
ridxRE = randi(numel(f));
theImageLocation = ['C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli',midpath,f(ridxRE).name];
[theImage, map, alpha] = imread(theImageLocation, 'png');
theImage(:,:,4) = alpha;


% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen.
Screen('DrawTexture', window, imageTexture, [], [], 0);

%load a second image dependign on stimcase 
switch stimcase
    case 1 
        theImageLocation2 = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\fishlyYES.png';
    case 2 
        theImageLocation2 = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\fishlyYES.png';
    case 3 
        theImageLocation2 = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\fishlyNO.png';
    case 4
        theImageLocation2 = 'C:\Users\Nico\Documents\MATLAB\Reward\rewardstimuli\fishlyNO.png';
end

%adding the ALPHA CHANNEL for transparency
[theImage2, map2, alpha2] = imread(theImageLocation2, 'png');
theImage2(:,:,4) = alpha2;
imageTexture2 = Screen('MakeTexture', window, theImage2);

Screen('DrawTexture', window, imageTexture2, [], [], 0);

% Flip to the screen
Screen('Flip', window);

% Wait for two seconds
WaitSecs(1);

% Clear the screen
sca;