function ETstart

global ETl ETr ETt ETevT ETevN 
%global targetrect targetrecthits;

%start data stream of eye tracker - infrared light turn on
tetio_startTracking;

%set data array as empty files
ETl = []; ETr = []; ETt = []; ETevN = []; ETevT = [];

%define an empty targetrect that is compared in ETrec
%targetrect is defined by subsequent tasks
% targetrect = [0 0 0 0];
% targetrecthits = [];

end