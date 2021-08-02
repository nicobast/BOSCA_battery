function rectgrid(color)

dim = 1;

    %dim 1 = 3*3 grid, 2 = 5*5 grid

global yCenter xCenter window screenYpixels vbl ifi waitframes;

        %seed the random number generator
        %rng('shuffle');
    
    vbl = Screen('Flip', window);    
        
    % base dot coordinates
    dim = dim;
    [x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

    % Here we scale the grid so that it is in pixel coordinates. We just scale
    % it by the screen size so that it will fit. This is simply a
    % multiplication. Notive the "." before the multiplicaiton sign. This
    % allows us to multiply each number in the matrix by the scaling value.
    pixelScale = screenYpixels / (dim * 4 + 2);
    x = x .* pixelScale;
    y = y .* pixelScale;

    % Calculate the number of dots
    % For help see: help numel
    numDots = numel(x);

    % Make the matrix of positions for the dots. This need to be a two row
    % vector. The top row will be the X coordinate of the dot and the bottom
    % row the Y coordinate of the dot. Each column represents a single dot. For
    % help see: help reshape
    dotPositionMatrix = [reshape(x, 1, numDots); reshape(y, 1, numDots)];

    % We can define a center for the dot coordinates to be relaitive to. Here
    % we set the centre to be the centre of the screen
    dotCenter = [xCenter yCenter];

    % Set the size of the dots randomly between 10 and 30 pixels
    %dotSizes = rand(1, numDots) .* 20 + 10;
    dotSizes = 100;
    
    % Enable alpha blending for anti-aliasing
        %needs to be called right before drawing
    %Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
    % Draw all of our dots to the screen in a single line of code
    % For help see: Screen DrawDots
    Screen('DrawDots', window, dotPositionMatrix, dotSizes, color, dotCenter, 0);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    %
    voddp;
    
end
    
  