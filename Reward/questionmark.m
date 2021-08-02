function [validtrial] = questionmark

       %presents a quesitonmark (changed to treasure box in latest version) 
       %on left and right side and presents longest fixated question mark by framed rect
      
global window windowRect bgd path;
%global ETl ETr ETt 

try

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        COORDINATES OF STIMULI

% Get the size of the on screen window
% [screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect); 
% % Make a base Rect of 200 by 200 pixels
 
% define coordinates of stimuli
%    squareXpos = [screenXpixels * 0.25 screenXpixels * 0.75];
%    squareYpos = [screenYpixels * 0.5 screenYpixels * 0.5];

squareXpos = [xCenter-500 xCenter+500];
squareYpos = [yCenter yCenter];
     
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%              AOI DEFINITION
 
% Make our rectangle coordinates
% baseRect = [0 0 600 800];
baseRect = [0 0 550 550];
allRects = nan(4, 2);
for i = 1:2
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
end

% % Draw the rect to the screen
Screen('FillRect', window, bgd, allRects);    
 
leftRect=allRects(:,1);
rightRect=allRects(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              STRING PRESENTATION
%%select basic random color (R,G,B,Y,C,M) for every trial but black or white
%  ranRGB = [0 1];
% rancol = [0 0 0]; %fixed to black
% 
% %      while (rancol == [0 0 0])
% %          rancol = [ranRGB(randperm(2,1)) ranRGB(randperm(2,1)) ranRGB(randperm(2,1))];
% %      end 
% %      
% %      while (rancol == [1 1 1])
% %          rancol = [ranRGB(randperm(2,1)) ranRGB(randperm(2,1)) ranRGB(randperm(2,1))];
% %      end 
% 
%     %offset to correct for noncentered coordinates for string, no CenterRectOnPointd function 
%     posoffset = 160;
%     squareXpos = squareXpos - posoffset;
%     squareYpos = squareYpos - 1.5*posoffset;
%        
% %select stimuli
% stimuli = ['?'];     
% %set text properties
% txtsz = 600;
% Screen('TextFont',window, 'Arial');
% Screen('TextSize',window, txtsz);
% %Screen('TextStyle', window, 1+2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          IMAGE PRESENTATION
% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

imagelocation = fullfile(path,'Reward','rewardstimuli','treasurebox.jpg');
   
ima=imread(imagelocation, 'jpg');
%[ima, ~, alpha]=imread(imagelocation, 'png');
%ima(:,:,4) = alpha;
imt=Screen('MakeTexture', window, ima);

imasize=size(ima);
imarect=[0,0,imasize(1),imasize(2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          present stimuli
%draw Stimuli
numSqaures = length(squareXpos);
for i = 1:numSqaures
%tex1(i) = Screen('DrawText', window, stimuli, squareXpos(i), squareYpos(i) , rancol);
dstRect=CenterRectOnPointd(imarect, squareXpos(i), squareYpos(i)); 
Screen('DrawTexture', window, imt, [], dstRect);
end
% Flip to the screen
Screen('Flip', window);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      GAZE CONTINGENCY


% Set Mouse/Tracker position
 [a,b] = RectCenter(windowRect);
 screenNumberorWindow=window;
 SetMouse(a,b,screenNumberorWindow);

counterall = 0;
counterL = 0;
counterR = 0;
duration = 0;
start = GetSecs;

while duration<=3
    
     %  eye-tracker data
    [lefteye, righteye, timestamp, ~] = tetio_readGazeData;
    mx = mean(lefteye(:,7),'omitnan')*windowRect(3); %column 7 is 2d x gaze in ADCS
    my = mean(lefteye(:,8),'omitnan')*windowRect(4); %column 8 is 2d y gaze in ADCS
  
    % concatenate eye tracking data to array - as tetio_readGazeData clear
    % buffer on every call
    ETrescue(lefteye,righteye,timestamp)

     %  "pseudo-eyetracker"
     %  [mx, my]=GetMouse;
     
     
    insideL = IsInRect(mx,my,leftRect);
    insideR = IsInRect(mx,my,rightRect);
    counterL = counterL + insideL;
    counterR = counterR + insideR;

    WaitSecs('YieldSecs', 0.05);
    counterall=counterall+1;
    duration = GetSecs - start;
   
end 

%define the winner and draw rect around it
if counterL>counterR
    %fprintf(1,'gaze on left');
    Screen('FrameRect', window, 0, leftRect, 10);
    validtrial = 1;
elseif counterL<counterR
    %fprintf(1,'gaze on right');
    Screen('FrameRect', window, 0, rightRect, 10);
    validtrial = 1;
elseif counterL == 0 && counterR == 0
    fprintf(1,'<strong>invalid trial</strong>\n');
    validtrial = 0;
else counterL==counterR
    cointoss=rand(1);
    validtrial = 1;
    if cointoss>=0.5
        Screen('FrameRect', window, 0, rightRect, 10);
    else 
        Screen('FrameRect', window, 0, leftRect, 10);
    end
end

%redraw stimuli
for i = 1:numSqaures
%tex1(i) = Screen('DrawText', window, stimuli, squareXpos(i), squareYpos(i) , rancol);
%Screen('DrawTexture', window, imt, [], [], 0);
dstRect=CenterRectOnPointd(imarect, squareXpos(i), squareYpos(i)); 
Screen('DrawTexture', window, imt, [], dstRect);
end

%flip and wait for 3 seconds
Screen('Flip', window);
WaitSecs(3);
         
catch
    Screen('CloseAll');
    psychrethrow(psychlasterror);
end

end