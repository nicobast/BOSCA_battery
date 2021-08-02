%% eye tracker initialization 
ETinit

%% eye tracker calibration
%     sets parameters for calibration
    SetCalibParams; 
    disp('Starting TrackStatus'); 
    % Display the track status window showing the participant's eyes (to position the participant).
    TrackStatus % Track status window will stay open until user key press.
    disp('TrackStatus stopped');
    
 %% eye tracker - end tracking 
%reports of clock synchronization of eye-tracker and SDK (1 = synch)
%synch seems to appear when data collection is started

ETend