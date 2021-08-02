function conegrid(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 
        % Make a base Rect of 100 by 100 pixels
    baseRect1 = [0 0 100 500];
    baseRect2 = [0 0 500 100];
    
    % Screen X positions of cross rects
    squareXpos1 = [xCenter-100 xCenter+100]; 
    squareYpos1 = [yCenter yCenter];
    squareXpos2 = [xCenter xCenter];
    squareYpos2 = [yCenter-100 yCenter+100];
    numSqaures = length(squareXpos1);

    % make vertical ovals
    allRects = nan(4, 2);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect1, squareXpos1(i), squareYpos1(i));
    end
        
    Screen('FillOval', window, color, allRects);

    % make horizontal ovals
    allRects = nan(4, 2);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect2, squareXpos2(i), squareYpos2(i));
    end
        
    Screen('FillOval', window, color, allRects);
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 