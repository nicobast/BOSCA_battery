function triangles(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
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
    xPosT1 = cos(anglesRad) .* radius + xCenter -150;
    
    yPosT2 = sin(anglesRad) .* radius + yCenter;
    xPosT2 = cos(anglesRad) .* radius + xCenter;
    
    yPosT3 = sin(anglesRad) .* radius + yCenter;
    xPosT3 = cos(anglesRad) .* radius + xCenter +150;
    
    % Cue to tell PTB that the polygon is convex (concave polygons require much
    % more processing)
    isConvex = 1;

    % Draw the rect to the screen
    Screen('FillPoly', window, color, [xPosT1; yPosT1]', isConvex);
    Screen('FillPoly', window, color, [xPosT2; yPosT2]', isConvex);
    Screen('FillPoly', window, color, [xPosT3; yPosT3]', isConvex);

 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 