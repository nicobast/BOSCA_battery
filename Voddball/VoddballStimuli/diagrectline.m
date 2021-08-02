function diagrectline(color)

rsize = 100;

%creates diagonal line of 5 rectangles with size rsize

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window);    

% Make a base Rect of 100 by 100 pixels
    baseRect = [0 0 rsize rsize];
    
    % Screen X positions of cross rects
    squareXpos = [xCenter-100 xCenter-100 xCenter+100 xCenter+100];
    squareYpos = [yCenter-200 yCenter+000 yCenter+000 yCenter+200];
    numSqaures = length(squareXpos);

    % Make our rectangle coordinates
    allRects = nan(4, 4);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    % Draw the rect to the screen
    Screen('FillRect', window, color, allRects);
    
    
            % Screen X positions of cross rects
            squareXpos = [xCenter+000 xCenter-100 xCenter xCenter+100 xCenter+000];
            squareYpos = [yCenter-200 yCenter-100 yCenter yCenter+100 yCenter+200];
            numSqaures = length(squareXpos);

            % Make our rectangle coordinates
            allRects = nan(4, 5);
            for i = 1:numSqaures
                allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
            end

            % Draw the rect to the screen
            Screen('FrameRect', window, color, allRects, 30);


    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for a key press
    voddp;
    
end