function [calibpoints] = ETcalib

    %performs calibration and saves calibration points to file

global pname Calib;

%for testing 
% ETinit

%sets parameters for calibration
SetCalibParams; 
calibpoints = [];

%perform calibration routine
 %is always performed on primary display
disp('Starting Calibration workflow');
% Perform calibration
[calibpoints] = HandleCalibWorkflowPTB(Calib);
disp('Calibration workflow stopped');

if ~isempty(calibpoints)
    cd data
    save(strcat(pname,'_','calibpoints.mat'),'calibpoints');
    cd ..
else
    disp('No calibration points saved ... continue without calibration');
end

%for testing
% enddummy

end