function smoothpursuit

        %display a horizontally and vertically running circle as smooth
        %pursuit target
       
WaitSecs(1); %waitsecs to prevent that previous keypress has effect on loops below

%task specific settings        
duration = 30;
%speed of the circle in visual angle per second in degrees
degreepersecond = 10;
incrementperrun = 2;

% g = 2*r*tan(alpha/2) 
% g = 51cm (width of screen on 23 inch)
% r = 60cm (normal view distance)
% --> alpha = 46,0509 degree visual angle for a 23 inch screen horizontally
% --> 41,6929 pixel per degree !!
% --> max for pixelpersecond for smooth pursuit = 1029 pixelpersecond

% g = 29cm (height of screen on 23 inch)
% --> alpha = 27.1719 degree visual angle for a 23 inch screen vertically
% --> 39,7469 pixel per degree ??

pixelpersecondX = degreepersecond*41.6929;
pixelpersecondY = degreepersecond*39.7469;

incrementperrunX = incrementperrun*41.6929;
incrementperrunY = incrementperrun*39.7469;

%runduration = 3.5;
%pixelpersecond=screenXpixels/runduration;
%degreepersecond=pixelpersecond/34.3

%% init 

global window windowRect ifi

% % Here we call some default settings for setting up Psychtoolbox
% PsychDefaultSetup(2);
% 
% % Get the screen numbers
% screens = Screen('Screens');
% 
% % Draw to the external screen if avaliable
% screenNumber = max(screens);
% 
% % Define black and white
% white = WhiteIndex(screenNumber);
% black = BlackIndex(screenNumber);
% 
% % Open an on screen window
% [window, windowRect] = PsychImaging('OpenWindow', 1, white);
% 
% % Query the frame duration
% ifi = Screen('GetFlipInterval', window);

%% task specific INIT
try
% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%% stimuli

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 100 100];

% Set the color of the rect to red
rectColor = [0 0 1];

% Our square will oscilate with a sine wave function to the left and right
% of the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
% amplitude = screenXpixels * 0.4 ;
% frequency = 0.08 ;
% angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;
runs = 0;
timecounter = 0;

if degreepersecond>=30
    fprintf(1,'<strong>ERROR: circle velocity higher than 30degree</strong>\n')
    return
end 


% Sync us and get a time stamp 
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% smooth pursuit animation switch between 
trigger = 1;

for i = 1:20
    
switch trigger
    case 1
        %capture event
        ETevent(strcat('smooth_hori',num2str(pixelpersecondX)))
        while ~KbCheck

            % Position of the square on this frame
            %xpos = amplitude * sin(angFreq * time + startPhase);
            %xpos = rail(i);

            % Add this position to the screen center coordinate. This is the point
            % we want our square to oscillate around
            %squareXpos = xCenter + xpos;
            squareXpos = pixelpersecondX*time;

            % Center the rectangle on the centre of the screen
            centeredRect = CenterRectOnPointd(baseRect, squareXpos, yCenter);

            % Draw the rect to the screen
            Screen('FillOval', window, rectColor, centeredRect);

            % Flip to the screen
            vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

            % Increment the time
            time = time + ifi;

            if squareXpos>screenXpixels
                timecounter=timecounter+time;
                time=0;
                squareXpos=0;
                pixelpersecondX=pixelpersecondX+incrementperrunX;
                trigger = 2;
                break
            end 

        end
    case 2
        %capture event
        ETevent(strcat('smooth_vert',num2str(pixelpersecondY)))
        
            while ~KbCheck

            % Position of the square on this frame
            %xpos = amplitude * sin(angFreq * time + startPhase);
            %xpos = rail(i);

            % Add this position to the screen center coordinate. This is the point
            % we want our square to oscillate around
            %squareXpos = xCenter + xpos;
            squareYpos = pixelpersecondY*time;

            % Center the rectangle on the centre of the screen
            centeredRect = CenterRectOnPointd(baseRect, xCenter, squareYpos);

            % Draw the rect to the screen
            Screen('FillOval', window, rectColor, centeredRect);

            % Flip to the screen
            vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

            % Increment the time
            time = time + ifi;

            if squareYpos>screenYpixels
                timecounter=timecounter+time;
                time=0;
                squareYpos=0;
                pixelpersecondY=pixelpersecondY+incrementperrunY;
                trigger = 1;
                break
            end 

            end
end 

            %exit loop if more runs than duration
            if timecounter>=duration
                timecounter;
                break
            end

end

catch
    Priority(0); 
    Screen('CloseAll');
    psychrethrow(psychlasterror);
    sca;
end 

end