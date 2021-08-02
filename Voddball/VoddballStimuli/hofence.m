function hofence(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window);
 
 
        % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 500 40];
   
    % Screen X positions of cross rects
    squareXpos = [xCenter xCenter xCenter xCenter xCenter xCenter xCenter];
    squareYpos = [yCenter-210 yCenter-140 yCenter-70 yCenter yCenter+70 yCenter+140 yCenter+210];
    numSqaures = length(squareXpos);

    % Make our rectangle coordinates
    allRects = nan(4, 7);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    % Draw the rect to the screen
    Screen('FillRect', window, color, allRects);

 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 