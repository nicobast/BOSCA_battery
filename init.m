% % Clear the workspace and the screen
% sca;
% close all;
% clearvars;
% 
% % Here we call some default settings for setting up Psychtoolbox
% PsychDefaultSetup(2);
% 
% % Get the screen numbers. This gives us a number for each of the screens
% % attached to our computer.
% screens = Screen('Screens');
% 
% % To draw we select the maximum of these numbers. So in a situation where we
% % have two screens attached to our monitor we will draw to the external
% % screen.
% screenNumber = max(screens);
% 
% % Define black and white (white will be 1 and black 0). This is because
% % in general luminace values are defined between 0 and 1 with 255 steps in
% % between. All values in Psychtoolbox are defined between 0 and 1
% white = WhiteIndex(screenNumber);
% black = BlackIndex(screenNumber);
% 
% % Open an on screen window using PsychImaging and color it grey.
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);