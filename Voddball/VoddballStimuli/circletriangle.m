function circletriangle(color)

global yCenter xCenter window bgd vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % Make a base Rect of 250 by 250 pixels
    baseRect = [0 0 500 500];
    maxDiameter = max(baseRect) * 1.01;

    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
    
    Screen('FillOval', window, color, centeredRect, maxDiameter);
    
    % Flip to the screen
    numSides = 3;
    
    % Angles at which our polygon vertices endpoints will be. We start at zero
    % and then equally space vertex endpoints around the edge of a circle. The
    % polygon is then defined by sequentially joining these end points.
    anglesDeg = linspace(0, 360, numSides + 1);
    anglesRad = anglesDeg * (pi / 180);
    radius = 200;

    % X and Y coordinates of the points defining out polygon, centred on the
    % centre of the screen
    yPosT1 = sin(anglesRad) .* radius + yCenter;
    xPosT1 = cos(anglesRad) .* radius + xCenter;
      
    % Set the color of the rect to bgd
    isConvex = 1;

    % Draw the rect to the screen
    Screen('FillPoly', window, bgd, [xPosT1; yPosT1]', isConvex);
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 