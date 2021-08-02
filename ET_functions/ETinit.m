%init eye tracker
disp('Initializing eye-tracker');

global currentFrameRate

% *************************************************************************
% Initialization and connection to the Tobii Eye-tracker
% *************************************************************************
 
tetio_init();

% Set to tracker ID to the product ID of the tracker you want to connect to.
trackerId = 'TX300-010107706752.local.';

fprintf('Connecting to tracker "%s"...\n', trackerId);
tetio_connectTracker(trackerId);
	
currentFrameRate = tetio_getFrameRate;
fprintf('Frame rate: %d Hz.\n', currentFrameRate);
