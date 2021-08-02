function star(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 350 350];
    newRect = CenterRectOnPoint(baseRect, xCenter, yCenter);
    
    Screen('FillRect', window, color,newRect);
     
         % Translate, rotate, re-tranlate and then draw our square
        Screen('glPushMatrix', window)
        Screen('glTranslate', window, xCenter, yCenter)
        Screen('glRotate', window, 45, 0, 0);
        Screen('glTranslate', window, -xCenter, -yCenter)
        Screen('FillRect', window, color,newRect);
        Screen('glPopMatrix', window)
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 