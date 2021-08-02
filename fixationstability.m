function fixationstability
    
global bgd

try

    colscreen(bgd,0.21);
    fixationcross(0.21, 0);
    colscreen(bgd,0.21);
    fixationcross(0.21, 0);
    colscreen(bgd,0.21);
    fixationcross(0.21, 0); 

    % % %white screen without stimuli for 7.5 seconds SHIRAMA, 2016
    colscreen(bgd,7.5);
    
    %paradigm according to diCrisco 2017 (24 trials, 12 black, 12 white)
    colscreen(0,5);
    colscreen(1,5);
    colscreen(0,5);
    colscreen(1,5);
    colscreen(0,5);
    colscreen(1,5);
    
catch
    
    Screen('CloseAll');
    psychrethrow(psychlasterror);
    sca;
 
end