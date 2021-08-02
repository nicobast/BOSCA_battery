function flower(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
      % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 100 500];
    newRect = CenterRectOnPoint(baseRect, xCenter, yCenter);
    
    Screen('FillOval', window, color, newRect); 
    
    angle = [(30:30:150)];
     for i = 1:length(angle)
         
         % Translate, rotate, re-tranlate and then draw our square
        Screen('glPushMatrix', window)
        Screen('glTranslate', window, xCenter, yCenter)
        Screen('glRotate', window, angle(i), 0, 0);
        Screen('glTranslate', window, -xCenter, -yCenter)
        Screen('FillOval', window, color, newRect);
        Screen('glPopMatrix', window)
        
     end
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 