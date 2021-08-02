function fixationcross_test

global window windowRect ifi waitframes;

%cut to INIT
%cut to INIT causes error below

prestime=1
fixcrosscolor=0

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
%ifi = Screen('GetFlipInterval', window);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Here we set the size of the arms of our fixation cross
% size 50 in version 0.3
fixCrossDimPix = 100;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 6;

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
%Screen('DrawLines', window, allCoords,...
%    lineWidthPix, white, [xCenter yCenter], 2);

% Flip to the screen
%Screen('Flip', window);

% Wait for a key press
%KbStrokeWait;

%present cross for a certain intervall

%flipSecs = prestime
%waitframes = round(flipSecs / ifi);

%timestamp
vbl=Screen('Flip',window);

%presentation for time without loop
Screen('DrawLines', window, allCoords,...
    lineWidthPix, fixcrosscolor, [xCenter yCenter], 2);

    %record eye tracking event
    ETevent(strcat('fixationcross_col:',num2str(fixcrosscolor),'_dur:',num2str(prestime)))

%flip to screen
%Screen('Flip', window);
Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

WaitSecs(prestime);

%change screen for every frame - processing intensive
%important to set: 
    % waitframes=1
    % numSecs = 5;
    % numFrames = round(numSecs / ifi);
    
 %for time accurate looping
    % topPriorityLevel = MaxPriority(window);
    % Priority(topPriorityLevel);

% for frame = 1:numFrames
%     
%     %count runs
%     count = [1:frame]
%     
%     %set anti-aliasing to zero to prevent flickering
%     Screen('DrawLines', window, allCoords,...
%     lineWidthPix, white, [xCenter yCenter], 0);
% 
%     vbl= Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
%     
% end
%Priority(0);
% Clear the screen
% sca;
end