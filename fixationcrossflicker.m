function fixationcross
% Clear the workspace and the screen
sca;
close all;
%clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable - max screen always external
screenNumber = max(screens);

% Define black and white - related to 8bit and 16bit color presentation
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Setup the text type for the window
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 36);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Here we set the size of the arms of our fixation cross
fixCrossDimPix = 40;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 4;

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
%Screen('DrawLines', window, allCoords,...
%    lineWidthPix, white, [xCenter yCenter], 2);

% Flip to the screen
%Screen('Flip', window);

% Wait for a key press
%KbStrokeWait;

%present cross for a certain intervall
waitframes = 25;

%timestamp
vbl=Screen('Flip',window);

%presentation for time without loop

Screen('DrawLines', window, allCoords,...
    lineWidthPix, white, [xCenter yCenter], 2);

Screen('Flip', window, vbl + 0.5 * ifi);

Screen('FillRect', window, [0 0 0]);

Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

Screen('DrawLines', window, allCoords,...
    lineWidthPix, white, [xCenter yCenter], 2);

Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

Screen('FillRect', window, [0 0 0]);

Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

% Clear the screen
sca;
end