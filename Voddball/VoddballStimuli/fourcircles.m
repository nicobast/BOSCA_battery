function fourcircles(color)

rsize = 250;

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window);    

    % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 rsize rsize];
   
    % Screen X positions of cross rects
    squareXpos = [xCenter-125 xCenter-125 xCenter+125 xCenter+125];
    squareYpos = [yCenter+125 yCenter-125 yCenter+125 yCenter-125];
    numSqaures = length(squareXpos);

    % Make our rectangle coordinates
    allRects = nan(4, 4);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    % Draw the rect to the screen
    Screen('FillOval', window, color, allRects);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for a key press
    voddp;
    
end