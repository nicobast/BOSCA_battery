function conecrosscircle(color)

global yCenter xCenter window bgd vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % Make a base Rect of 250 by 250 pixels
    baseRect = [0 0 500 500];

    % For Ovals we set a maximum diameter up to which it is perfect for
    maxDiameter = max(baseRect) * 1.01;

    % Center the rectangle on the centre of the screen
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
   
    % Draw the rect to the screen
    Screen('FillOval', window, color, centeredRect, maxDiameter);

    %insert cross
    baseRect1 = [0 0 100 500];
    centeredRect = CenterRectOnPointd(baseRect1, xCenter, yCenter);
    Screen('FillOval', window, bgd, centeredRect, maxDiameter);
    baseRect2 = [0 0 500 100];
    centeredRect = CenterRectOnPointd(baseRect2, xCenter, yCenter);
    Screen('FillOval', window, bgd, centeredRect, maxDiameter);
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 