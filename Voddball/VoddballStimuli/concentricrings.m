function concentricrings(color)

global yCenter xCenter window vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
 % Make a base Rect and form bigger base rects around it
    xSz = 100;
    ySz = 100;
    baseRect = [0 0 xSz ySz];
    baseRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
    rects = nan(4,4);
    
    numRects = length(rects);
    
    % order these rect concentric around centered base rect
    scale = 0.5;
    for i = 1:numRects
        rects(:,i) = [baseRect(1)-(i*xSz*scale) baseRect(2)-(i*ySz*scale) baseRect(3)+(i*xSz*scale) baseRect(4)+(i*ySz*scale)] ;
    end
    
    % Make our rectangle coordinates
%     allRects = nan(4, 4);
%     for i = 1:numRects
%         allRects(:,i) = CenterRectOnPointd(rects(i,:), xCenter, yCenter);
%     end

    % Draw  to the screen
    Screen('FrameOval', window, color, rects, 30);
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % stimulusprestime and ISI
    voddp; 
end
 