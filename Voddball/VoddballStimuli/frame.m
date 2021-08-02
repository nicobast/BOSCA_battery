function frame(color)

global yCenter xCenter window vbl ifi waitframes;

vbl = Screen('Flip', window); 
 
% Make a base Rect of 100 by 100 pixels
    baseRectS = 100;
    baseRect = [0 0 baseRectS baseRectS];
    
     % set rects to form frame
    dim = 2;
    [x y] = meshgrid(-dim:1:dim, -dim:1:dim);

    % Screen X positions of cross rects
    squareXpos = xCenter + x * baseRectS;
    squareYpos = yCenter + y * baseRectS;
     
    numSqaures = length(squareXpos);
    
%     lxsq = squareXpos(:,1);
%     uxsq = squareXpos(1,:);
%     dxsq = squareXpos(numSqaures,:);
%     rxsq = squareXpos(:,numSqaures);

    % Make our left rectangles
    lRects = nan(4, 5);
    for i = 1:numSqaures
        lRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i,1), squareYpos(i,1));
    end
    Screen('FillRect', window, color, lRects);
    
    % Make our upper rectangles
    uRects = nan(4, 5);
    for i = 1:numSqaures
        uRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(1,i), squareYpos(1,i));
    end

    Screen('FillRect', window, color, uRects);
    
    %make lower rectangles
    dRects = nan(4, 5);
    for i = 1:numSqaures
        dRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(numSqaures,i), squareYpos(numSqaures,i));
    end

    Screen('FillRect', window, color, dRects);
    
    %make right rectangles
    rRects = nan(4, 5);
    for i = 1:numSqaures
        rRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i,numSqaures), squareYpos(i,numSqaures));
    end

    Screen('FillRect', window, color, rRects);
      
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for a key press
    voddp; 
end
 