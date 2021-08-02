function checkboard(color)

    %note: input argument of color is not used as always black&white
    %bwcolor

global yCenter xCenter window screenXpixels vbl ifi waitframes;

 vbl = Screen('Flip', window); 
 
  % Make a base Rect of 200 by 200 pixels
    dim = 100;
    baseRect = [0 0 dim dim];

    % Make the coordinates for our grid of squares
    [xPos, yPos] = meshgrid(-2:1:2, -2:1:2);

    % Calculate the number of squares and reshape the matrices of coordinates
    % into a vector
    [s1, s2] = size(xPos);
    numSquares = s1 * s2;
    xPos = reshape(xPos, 1, numSquares);
    yPos = reshape(yPos, 1, numSquares);

    % Scale the grid spacing to the size of our squares and centre
    %xPosLeft = xPos .* dim + screenXpixels * 0.25;
    %yPosLeft = yPos .* dim + yCenter;
    xPosRight = xPos .* dim + screenXpixels * 0.75;
    yPosRight = yPos .* dim + yCenter;
    
    xPos = xPos .* dim + xCenter;
    yPos = yPos .* dim + yCenter;
    

    % Set the colors of each of our squares
    %multiColors = rand(3, numSquares);
    bwColors = repmat(eye(2), 3, 3);
    bwColors = bwColors(1:end-1, 1:end-1);
    bwColors = reshape(bwColors, 1, numSquares);
    bwColors = repmat(bwColors, 3, 1);

    % Make our rectangle coordinates
    %allRectsLeft = nan(4, 3);
    %allRectsRight = nan(4, 3);
    allRects = nan(4, 3);
    for i = 1:numSquares
    %         allRectsLeft(:, i) = CenterRectOnPointd(baseRect,...
    %             xPosLeft(i), yPosLeft(i));
    %         allRectsRight(:, i) = CenterRectOnPointd(baseRect,...
    %             xPosRight(i), yPosRight(i));
        allRects(:, i) = CenterRectOnPointd(baseRect,...
            xPos(i), yPos(i));
    end

    % Draw the rect to the screen
    %     Screen('FillRect', window, [multiColors bwColors],...
    %         [allRectsLeft allRectsRight]);
        Screen('FillRect', window, [bwColors],...
        [allRects]);
 
% Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Wait for in voddp specified prestime and ISI
    voddp; 
end
 