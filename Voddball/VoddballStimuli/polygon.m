function polygon(color)

sides = 9;

global yCenter xCenter window waitframes ifi vbl bgd

%% POLYGON
    
    vbl = Screen('Flip', window);
    
    % Angles at which our polygon vertices endpoints will be. We start at zero
    % and then equally space vertex endpoints around the edge of a circle. The
    % polygon is then defined by sequentially joining these end points.
    anglesDeg = linspace(0, 360, sides + 1);
    anglesRad = anglesDeg * (pi / 180);
    radius = 250;

    % X and Y coordinates of the points defining out polygon, centred on the
    % centre of the screen
    yPosVector = sin(anglesRad) .* radius + yCenter;
    xPosVector = cos(anglesRad) .* radius + xCenter;

    % Cue to tell PTB that the polygon is convex (concave polygons require much
    % more processing)
    isConvex = 1;

    % Draw the rect to the screen
    Screen('FillPoly', window, color, [xPosVector; yPosVector]', isConvex);
    
            %create a hexagon of same size within
            anglesDeg = linspace(0, 360, sides +1 -3);
            anglesRad = anglesDeg * (pi / 180);
            radius = 230;

            % X and Y coordinates of the points defining out polygon, centred on the
            % centre of the screen
            yPosVector = sin(anglesRad) .* radius + yCenter;
            xPosVector = cos(anglesRad) .* radius + xCenter;

            % Cue to tell PTB that the polygon is convex (concave polygons require much
            % more processing)
            isConvex = 1;

            % Draw the rect to the screen
            Screen('FillPoly', window, bgd, [xPosVector; yPosVector]', isConvex);
            
            
            %create a triangle of same size within
            anglesDeg = linspace(0, 360, sides +1 -6);
            anglesRad = anglesDeg * (pi / 180);
            radius = 200;

            % X and Y coordinates of the points defining out polygon, centred on the
            % centre of the screen
            yPosVector = sin(anglesRad) .* radius + yCenter;
            xPosVector = cos(anglesRad) .* radius + xCenter;

            % Cue to tell PTB that the polygon is convex (concave polygons require much
            % more processing)
            isConvex = 1;

            % Draw the rect to the screen
            Screen('FillPoly', window, color, [xPosVector; yPosVector]', isConvex);



    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
    
end
    
  