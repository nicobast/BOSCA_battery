function fixspiral(duration)

initdummy

global window windowRect bgd path ifi waitframes;
  
duration = 10;

%% specific init

% % Get the size of the on screen window
 [screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%% stimulus creation

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Dimension of our texure (it will be this value +1 pixel
dim = 100;

% Make a second dimension value which is increased by a factor of the
% squareroot of 2. We need to do this because in this demo we will be using
% internal texture rotation. We round this to the nearest pixel.
dim2 = ceil(dim * sqrt(2));

% Contrast for our contrast modulation mask: 0 = mask has no effect, 1 = mask
% will at its strongest part be completely opaque i.e. 0 and 100% contrast
% respectively
contrast = 1;

% Define a simple spiral texture by defining X and Y coordinates with the
% meshgrid command, converting these to polar coordinates and finally
% defining the spiral. This time we create a two layer texture fill
% the first layer with the background color and then place the spiral
% texure in the second 'alpha' layer. Note that we make the mask texture
% larger for internal texture rotation.
[x, y] = meshgrid(-dim2:1:dim2, -dim2:1:dim2);
[th, r] = cart2pol(x, y);
spiral = (1 .* (1 - cos(r / 5 + th * 5))) ./ 2;
[s1, s2] = size(x);

mask = ones(s1, s2, 2) .* bgd;
mask(:, :, 2)= spiral .* contrast;

% Make our sprial  into a screen texture for drawing
maskTexture = Screen('MakeTexture', window, mask);

% Make ablack and white noise texture, we make this 1/3 the size of the
% destination rectangle we are putting it in so that it is scaled up,
% giving us a more chunky noise pattern. This will be viewed through the
% spiral mask
noiseDim = round(s1 / 3);
noise = round(rand(noiseDim, noiseDim));
noiseTexture = Screen('MakeTexture', window, noise);

% We are going to draw three textures to show how a black and white texture
% can be color modulated upon drawing.
yPos = yCenter;
xPos = xCenter;
%  xPos = linspace(screenXpixels * 0.2, screenXpixels * 0.8, 3);

% Define the destination rectangles for our spiral textures. For this demo
% these will be the same size as out actualy texture, but this doesn't have
% to be the case. See: ScaleSpiralTextureDemo and CheckerboardTextureDemo.
ndim = dim * 2 + 1;
baseRect = [0 0 ndim ndim];
dstRects = CenterRectOnPointd(baseRect, xPos, yPos);

%create second baseRect for masking circle - FrameOval
baseRect2 = [0 0 ndim+150 ndim+150];
dstRects2 = CenterRectOnPointd(baseRect2, xPos, yPos);

% dstRects = nan(4,1);
% dstRects = nan(4, 3);
% for i = 1:3
%     dstRects(:, i) = CenterRectOnPointd(baseRect, xPos(i), yPos);
% end

% Now we create a window through which we will view our texture. This is
% the same size as our destination rectangles. But we shift it in X and Y
% by a value of dim2 - dim. This makes sure our window is centered on the
% middle of the enlarged texture we made for internal texture rotation.
srcRect = baseRect + (dim2 - dim);

%define a round masking texture
color = bgd;

% Color Modulation
% colorMod = validcolor;
colorMod = [1 0 0]';
% colorMod = [1 0 0; 0 1 0; 0 0 1]';

% Set the initial angle to zero and the angular increment per farme to 2
% degrees
angle = 0;
angleInc = 2;

% get timestamp
vbl = Screen('Flip', window);
start = GetSecs;
runtime = 0;

while runtime<duration
    
    % Batch Draw all of the texures to screen
    Screen('DrawTextures', window, noiseTexture, [], dstRects, [], [], [], colorMod);
    Screen('DrawTextures', window, maskTexture, srcRect, dstRects, angle,...
        [], [], [],[], kPsychUseTextureMatrixForRotation);
    Screen('FrameOval', window, color, dstRects2, 100);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Increment the angle
    angle = angle + angleInc;
    
    runtime = GetSecs - start;

end

% Clear the screen
enddummy;

end