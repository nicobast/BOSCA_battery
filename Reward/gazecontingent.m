%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        INIT --> put to global
    
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
bgd=1;
[window, windowRect] = PsychImaging('OpenWindow', 1, bgd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      SPECIFIC INIT
try

    %initial settings
    mxold=0;
    myold=0;
    ms=200;
    myimgfile='C:\Users\Nico\Documents\MATLAB\Reward\GFhappyface.png';
    
    % We create a two layers Luminance + Alpha matrix for use as transparency
    % (or mixing weights) mask: Layer 1 (Luminance) is filled with luminance
    % value 1.0 aka white - the ones() function does this nicely for us, by
        % first filling both layers with 1.0:
        [x,y] = meshgrid(-ms:ms, -ms:ms);
        maskblob = ones(2*ms+1, 2*ms+1, 2);
        % Layer 2 (Transparency aka Alpha) is now filled/overwritten with a gaussian
        % transparency/mixing mask.
        xsd = ms / 2.2;
        ysd = ms / 2.2;
        maskblob(:,:,2) = 1 - exp(-((x / xsd).^2) - ((y / ysd).^2));

    % Build a single transparency mask texture:
    masktex = Screen('MakeTexture', window, maskblob);
    % mRect = Screen('Rect', masktex);

    
    % Build texture for foveated region:
    imdata=imread(myimgfile);
    foveaimdata = imdata;
    foveatex=Screen('MakeTexture', window, foveaimdata);
    tRect=Screen('Rect', foveatex);

    [ctRect, dx, dy]=CenterRect(tRect, windowRect);
    
    % The mouse-cursor position will define gaze-position (center of
    % fixation) to simulate (x,y) input from an eyetracker. Set cursor
    % initially to center of screen, but do hide it from view:
    [a,b] = RectCenter(windowRect);
    SetMouse(a,b,screenNumber);
    HideCursor;
    buttons = 0;

%creates a loop hat is only quit by a brak command    
while 1
        %  "pseudo-eyetracker")
        [mx, my, buttons]=GetMouse;

        %switch between modes
        %         if any(buttons)
        %             while any(buttons)
        %                 [mx, my, buttons]=GetMouse; %(w);
        %             end
        % 
        %             mode = mode + 1;
        %             mxold = -1;
        % 
        %             if mode == 4
        %                 break;
        %             end
        %         end

        % We only redraw if gazepos. has changed:
        if (mx~=mxold || my~=myold)
            % Compute position and size of source- and destinationrect and clip them:
            myrect=[mx-ms my-ms mx+ms+1 my+ms+1];
            dRect = ClipRect(myrect,ctRect);
            sRect=OffsetRect(dRect, -dx, -dy);

            % Valid destination rectangle?
            if ~IsEmptyRect(dRect)
                % Yes! Draw image for current frame:

                % Step 1: Draw the alpha-mask into the backbuffer. It
                % defines the aperture for foveation: The center of gaze
                % has zero alpha value. Alpha values increase with distance from
                % center of gaze according to a gaussian function and
                % approach 1.0 at the border of the aperture...
%                 if mode > 0
%                     % Actual use of masktex to define transitions/mix:
% 
%                     % First clear framebuffer to backgroundcolor, not using
%                     % alpha blending (== GL_ONE, GL_ZERO), enable all channels
%                     % for writing [1 1 1 1], so everything gets cleared to good
%                     % starting values:
%                     Screen('BlendFunction', w, GL_ONE, GL_ZERO, [1 1 1 1]);
%                     Screen('FillRect', w, backgroundcolor);
% 
%                     % Then keep alpha blending disabled and draw the mask
%                     % texture, but *only* into the alpha channel. Don't touch
%                     % the RGB color channels but use the channel mask
%                     % [R G B A] = [0 0 0 1] to only enable the alpha-channel
%                     % for drawing into it:
%                     Screen('BlendFunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
%                     Screen('DrawTexture', w, masktex, [], myrect);
%                 else
%                     % Visualize the alpha/mask channel of the
                    % framebuffer and the new masktex itself to explain
                    % the concept - alpha values of 1 will show as white,
                    % values of zero as black, intermediates as gray levels:
                    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ZERO);
                    Screen('FillRect', window, 1);
                    Screen('DrawTexture', window, masktex, [], myrect);
%                 end

                % Step 2: Draw peripheral image. It is only/increasingly drawn where
                % the alpha-value in the backbuffer is 1.0 or close, leaving
                % the foveated area (low or zero alpha values) alone:
                % This is done by weighting each color value of each pixel
                % with the corresponding alpha-value in the backbuffer
                % (GL_DST_ALPHA). Disable alpha channel writes via [1 1 1 0], so
                % alpha mask stays untouched and only RGB color channels are
                % affected:
%                 if mode == 1 || mode == 3
%                     Screen('BlendFunction', w, GL_DST_ALPHA, GL_ZERO, [1 1 1 0]);
%                     Screen('DrawTexture', w, nonfoveatex, [], ctRect);
%                 end
% 
%                 % Step 3: Draw foveated image, but only/increasingly where the
%                 % alpha-value in the backbuffer is zero or low: This is
%                 % done by weighting each color value with one minus the
%                 % corresponding alpha-value in the backbuffer
%                 % (GL_ONE_MINUS_DST_ALPHA).
%                 if mode == 2 || mode == 3
%                     Screen('BlendFunction', w, GL_ONE_MINUS_DST_ALPHA, GL_ONE, [1 1 1 0]);
%                     Screen('DrawTexture', w, foveatex, sRect, dRect);
%                 end

                % Draw some text with explanation of the different steps:
%                 switch(mode)
%                     case 0,
%                         txt = 'Draw gaussian aperture mask texture around center of fixation (aka mouse position):\nThis shows the alpha mask channel of the framebuffer used for mixing of the images (white = 1.0 alpha weight, black = 0.0 alpha weight)';
%                     case 1,
%                         txt = 'Draw periphery texture, but weight each incoming source color pixel by the alpha value stored in the framebuffers alpha channel';
%                     case 2,
%                         txt = 'Draw fovea texture, but weight each incoming source color pixel by 1 minus the alpha value stored in the framebuffers alpha channel';
%                     case 3,
%                         txt = 'Perform alpha weighted compositing (all previous steps together):\n1. Draw alpha weight mask according to mouse position,\n2. Overdraw with alpha-weighted periphery texture,\n3. Overdraw with 1-alpha weighted fovea texture.';
%                 end
%                 txt = [txt '\nMouse click for next step.'];
%                 DrawFormattedText(window, txt, 0, 0, [1 0 0], 60);

                % Show final result on screen. The 'Flip' also clears the drawing
                % surface back to black background color and a zero alpha value:
                Screen('Flip' , window);
            end
        end

        % Keep track of last gaze position:
        mxold=mx;
        myold=my;

        % We wait 1 ms each loop-iteration so that we
        % don't overload the system in realtime-priority:
        WaitSecs('YieldSecs', 0.001);
        
        % Abort demo on keypress our mouse-click:
        if  KbCheck 
            break;
        end
        
end

sca;
        
catch
  Screen('CloseAll');
  psychrethrow(psychlasterror);
  
 end