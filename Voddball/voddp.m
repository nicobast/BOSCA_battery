function voddp

     %voddp is a pause with 0.5 sec stimulus presentation and 2s ISI
     %for devmode = 1 stimulus is presented till key press
     %famtrial is used for familiarization to stimuli in voddball

global window bgd waitframes ifi famtrial;

devmode = 0;

if devmode == 0

    if famtrial == 1
    
    isi = 2;
    stimpres = 5;

    WaitSecs(stimpres);

    vbl = Screen('Flip', window);
    
    % Color the screen to background
    Screen('FillRect', window, bgd);
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    WaitSecs(isi);    
        
    else
        
    isi = 2;
    stimpres = 0.5;

    WaitSecs(stimpres);

    vbl = Screen('Flip', window);
    
    % Color the screen to background
    Screen('FillRect', window, bgd);
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    WaitSecs(isi);
    
    end
    
elseif devmode == 1
    
    % Wait for a key press
    KbStrokeWait;
    
    vbl = Screen('Flip', window);
    
    % Color the screen to background
    Screen('FillRect', window, bgd);
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

end

end