%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %             OUTSORTED STIMULI
    
    % Cross
    
        % Here we set the size of the arms of our fixation cross
    fixCrossDimPix = 250;
    fixcrosscolor = colran(randperm(6,1),:)

    % Now we set the coordinates (these are all relative to zero we will let
    % the drawing routine center the cross in the center of our monitor for us)
    xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
    yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
    allCoords = [xCoords; yCoords];

    % Set the line width for our fixation cross
    lineWidthPix = 6;
    %timestamp
    vbl=Screen('Flip',window);

    %presentation for time without loop
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    Screen('DrawLines', window, allCoords,...
        lineWidthPix, fixcrosscolor, [xCenter yCenter], 2);

    Screen('Flip', window);

    KbStrokeWait;
   
    % CIRCLE
    
    % Make a base Rect of 250 by 250 pixels
    baseRect = [0 0 500 500];

    % For Ovals we set a maximum diameter up to which it is perfect for
    maxDiameter = max(baseRect) * 1.01;

    % Center the rectangle on the centre of the screen
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

    % Set the color of the rect to red
    rectColor = colran(randperm(6,1),:);

    % Draw the rect to the screen
    Screen('FillOval', window, rectColor, centeredRect, maxDiameter);

    % Flip to the screen
    Screen('Flip', window);

    % Wait for a key press
    KbStrokeWait;
   

 %      FRAMEDCIRCLE
    
    % Make a base Rect of 250 by 250 pixels
    baseRect = [0 0 500 500];

    % For Ovals we set a maximum diameter up to which it is perfect for
    maxDiameter = max(baseRect) * 1.01;

    % Center the rectangle on the centre of the screen
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

    % Set the color of the rect to red
    rectColor = colran(randperm(6,1),:);

    % Draw the rect to the screen
    Screen('FillOval', window, rectColor, centeredRect, maxDiameter);
    Screen('FrameRect', window, rectColor, centeredRect, 20);
    
    % Flip to the screen
    Screen('Flip', window);

    % Wait for a key press
    KbStrokeWait;
   