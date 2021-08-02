function offsetrings(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % Make a base Rect of 250 by 250 pixels
    baseRect = [0 0 300 300];

    % Center the rectangle on the centre of the screen
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
    
       % Screen X positions of cross rects
    squareXpos = [xCenter-100 xCenter-100 xCenter+100 xCenter+100];
    squareYpos = [yCenter+100 yCenter-100 yCenter+100 yCenter-100];
    numSqaures = length(squareXpos);

    
    % Make our rectangle coordinates
    allRects = nan(4, 4);
    for i = 1:numSqaures
        allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
    end

    % Draw  to the screen
    Screen('FrameOval', window, color, allRects, 30);

 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for a key press
    voddp; 
end
 