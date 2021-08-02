function ETend

%stops tracking, disconnects tracker, and cleans up the eye tracker IO

tetio_stopTracking; 
tetio_disconnectTracker; 
tetio_cleanUp;

end