function emoexpression(moviename)
  
 global window ifi waitframes
 
%% Wait until user releases keys on keyboard:
KbReleaseWait;

try
     
    % Open movie file and retrieve information about movie
    [movie, ~ ,fps, ~, ~] = Screen('OpenMovie', window, moviename);
%    [movie movieduration fps imgw imgh] = Screen('OpenMovie', window, moviename);

     %sync flip frequency to fps of video -which did not work
         vrefreshrate = 1/fps;
         waitframes = round(vrefreshrate/ifi);
      
    %capture event
    [~,fname,~] = fileparts(moviename);
    ETevent(strcat('emoexp_',fname))
   
    % Start playback engine: loop = 0, soundvolume = 0
    Screen('PlayMovie', movie, 1, 0, 0);   
    
    %get an absolute timestamp
    vbl = Screen('Flip', window);
         
    % Playback loop: Runs until end of movie or keypress:
    while ~KbCheck
        
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', window, movie, 0);
       
        % Valid texture returned? A negative value means end of movie reached:
        if tex<0
            % We're done, break out of loop:
            break;
        end
        
        if tex == 0
            % No new frame in polling wait (tex=0). Just sleep a bit and then retry.
            vbl = WaitSecs('YieldSecs', ifi);
            continue;
        end
       
        
        % Draw the new texture immediately to screen:
        Screen('DrawTexture', window, tex);
        
        % Update display:
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        
        % Release texture:
        Screen('Close', tex);
    end
    
    % Stop playback:
    Screen('PlayMovie', movie, 0);
    % Close movie:
    Screen('CloseMovie', movie);
    
catch
    
    sca;
    psychrethrow(psychlasterror);
       
end

end