function rectchain(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 
    % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 300 300];
   
    % Screen X positions of cross rects
    squareXpos = [xCenter-80 xCenter+80];
    squareYpos = [yCenter yCenter];
    numSqaures = length(squareXpos);
    
     for i = 1:numSqaures

        % Get the current squares position ans rotation angle
        posX = squareXpos(i);
        posY = squareYpos(i);

    
         % Translate, rotate, re-tranlate and then draw our square
        Screen('glPushMatrix', window)
        Screen('glTranslate', window, posX, posY)
        Screen('glRotate', window, 45, 0, 0);
        Screen('glTranslate', window, -posX, -posY)
        Screen('FrameRect', window, color,...
            CenterRectOnPoint(baseRect, posX, posY),30);
        Screen('glPopMatrix', window)

     end
 
 
    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 