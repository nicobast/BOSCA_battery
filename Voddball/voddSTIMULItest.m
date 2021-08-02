function voddSTIMULItest 

% check stimuli of voddball will be presented in col
% IMPORTANT: open voddp and set devmode that stimuli are triggered on
% keypress

% Clear the workspace and the screen
 sca;
 close all;
 clearvars;
 
 col = 0;

global bgd windowRect window colran yCenter xCenter screenXpixels screenYpixels ifi waitframes vbl Ncol Dcol Tcol famtrial;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   INIT  --> PUT TO GLOBAL
  
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% 
% % Get the screen numbers
screens = Screen('Screens');
% 
% % Draw to the external screen if avaliable
 screenNumber = 1;
% 
% % Define black and white
 white = WhiteIndex(screenNumber);
 black = BlackIndex(screenNumber);
%
%  Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
 
 % Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);  

% %set background
% bgd = white;

%timing settings
vbl = Screen('Flip', window);
ifi = Screen('GetFlipInterval', window);
waitframes = 1;

%set processing priority
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      random simuli selection

    [distractor, target, nlist] = rstim;    
    
    function nov 
    [novelstim, nlist] = nstim(nlist); %select a stimulus not chosen before
    novelstim(col); %define random color but Tcol and Dcol, see above
    end
    
    function tar
    target(col);
    end
    
    function dis
    distractor(col);
    end
    
    
   dis;
   tar;
   
   f = dir('C:\Users\Nico\Documents\MATLAB\Voddball\VoddballStimuli');
   f = f(3:length(f),:); %remove weird folder entries
   
   for n = 1:length(f)-2 %exclude runs for dis and tar
       nov;
   end
   
   Priority(0);    
   sca;
   
end