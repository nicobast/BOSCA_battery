function polygoncircle(color)

global yCenter xCenter window bgd vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % default polygon size 7
    numSides = 8;
    
    % Angles at which our polygon vertices endpoints will be. We start at zero
    % and then equally space vertex endpoints around the edge of a circle. The
    % polygon is then defined by sequentially joining these end points.
    anglesDeg = linspace(0, 360, numSides + 1);
    anglesRad = anglesDeg * (pi / 180);
    radius = 250;

    % X and Y coordinates of the points defining out polygon, centred on the
    % centre of the screen
    yPosVector = sin(anglesRad) .* radius + yCenter;
    xPosVector = cos(anglesRad) .* radius + xCenter;

    isConvex = 1;

    % Draw the rect to the screen
    Screen('FillPoly', window, color, [xPosVector; yPosVector]', isConvex);

    % Insert circle 
    baseRect = [0 0 200 200];
    maxDiameter = max(baseRect) * 1.01;
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
    Screen('FillOval', window, bgd, centeredRect, maxDiameter);

 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 