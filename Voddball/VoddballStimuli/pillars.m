function pillars(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 

    % Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 100 500];
    
    squareXpos = [xCenter-150 xCenter xCenter+150];
    squareYpos = [yCenter yCenter yCenter];
    numSqaures = length(squareXpos);

    allRects = nan(4, 5);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    Screen('FillRect', window, color, allRects);
    
    baseRect = [0 0 500 100];
    squareXpos = [xCenter xCenter];
    squareYpos = [yCenter-200 yCenter+200];
    numSqaures = length(squareXpos);

    allRects = nan(4, 2);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    Screen('FillRect', window, color, allRects);
    
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 