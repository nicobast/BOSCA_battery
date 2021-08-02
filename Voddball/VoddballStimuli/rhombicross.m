function rhombicross(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
   % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 180 180];
   
    % Screen X positions of cross rects
    squareXpos = [xCenter-100 xCenter-100 xCenter+100 xCenter+100];
    squareYpos = [yCenter+100 yCenter-100 yCenter+100 yCenter-100];
    numSqaures = length(squareXpos);

    % Make our rectangle coordinates
    allRects = nan(4, 10);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end
    
     for i = 1:numSqaures

        % Get the current squares position ans rotation angle
        posX = squareXpos(i);
        posY = squareYpos(i);

    
         % Translate, rotate, re-tranlate and then draw our square
        Screen('glPushMatrix', window)
        Screen('glTranslate', window, posX, posY)
        Screen('glRotate', window, 45, 0, 0);
        Screen('glTranslate', window, -posX, -posY)
        Screen('FillRect', window, color,...
            CenterRectOnPoint(baseRect, posX, posY));
        Screen('glPopMatrix', window)

     end
      
    %Add this line to create CROSS WITH SPIKES
    %Screen('FillRect', window, allColors, allRects);

 
    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for a key press
    voddp; 
end
 