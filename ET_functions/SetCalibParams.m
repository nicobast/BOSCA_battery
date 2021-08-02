global Calib

%command takes only the screen size of the main screen:
%screensize = get(0,'Screensize')

%screensize of extended screen/secondary screen:
%if no secondary screen is attachted, calibrate on internal screen
screens=Screen('screens');
%win 10: alter (-1) to intscreen depending on which is max screen 
%Calib.extscreen=max(screens)-1;
%Calib.intscreen=max(screens);

%win 7:  
Calib.extscreen=max(screens);
Calib.intscreen=max(screens)-1;

screensize=get(0,'MonitorPositions');

screensizeext=screensize(Calib.extscreen,:);
Calib.mondims1.x = screensizeext(1);
Calib.mondims1.y = screensizeext(2);
Calib.mondims1.width = screensizeext(3);
Calib.mondims1.height = screensizeext(4);

screensizeint=screensize(Calib.intscreen,:);
Calib.mondims2.x = screensizeint(1);
Calib.mondims2.y = screensizeint(2);
Calib.mondims2.width = screensizeint(3);
Calib.mondims2.height = screensizeint(4);

%Calib.MainMonid = 1; 
%Calib.TestMonid = 1;

Calib.points.x = [0.1 0.9 0.5 0.9 0.1];  % X coordinates in [0,1] coordinate system 
Calib.points.y = [0.1 0.1 0.5 0.9 0.9];  % Y coordinates in [0,1] coordinate system 
Calib.points.n = size(Calib.points.x, 2); % Number of calibration points
Calib.bkcolor = [0.85 0.85 0.85]; % background color used in calibration process
Calib.fgcolor = [0 0 1]; % (Foreground) color used in calibration process
Calib.fgcolor2 = [1 0 0]; % Color used in calibratino process when a second foreground color is used (Calibration dot)
%Calib.BigMark = 25; % the big marker 
Calib.BigMark = 50; % the big marker 
Calib.TrackStat = 25; % 
Calib.SmallMark = 15; % the small marker
Calib.delta = 100; % steps when dot moves between targets
%Calib.resize = 1; % To show a smaller window
Calib.resize = 0; % To show a smaller window
%Calib.NewLocation = get(gcf,'position');
Calib.step = 50; %steps in shrinking the big marker 

