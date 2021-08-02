 function [endtime] = attmovie(moviename,starttime, duration)
  
    %play specified movie for a specific duration return endtime for input
    %argument start time for next call of attmovie
 
 global window ifi waitframes path

    %capture if input arguments are not delivered
    if nargin < 1 || isempty(moviename)
        % No moviename given: Use our default movie:
        moviename =fullfile(path,'CartoonCars.mp4');
    end   

% Wait until user releases keys on keyboard:
KbReleaseWait;

%capture event
ETevent(strcat('voddball_attmovie_time:',num2str(starttime)))

try
    
    % Open movie file and retrieve information about movie
    [movie, ~ ,fps, ~, ~] = Screen('OpenMovie', window, moviename);
    
     %sync flip frequency to fps of video -which did not work
     vrefreshrate = 1/fps;
     waitframes = round(vrefreshrate/ifi);    
     
    % Start playback engine: loop = 0, soundvolume = 0
    Screen('PlayMovie', movie, 1, 0, 0);   
    
     %set piece of movie to be played
    Screen('SetMovieTimeIndex', movie, starttime);
    
    vbl = Screen('Flip', window);
    
    % Playback loop: Runs until end of movie or keypress:
    while ~KbCheck
        
        % Wait for next movie frame, retrieve texture handle to it
         tex = Screen('GetMovieImage', window, movie,0);
        
        
        % Valid texture returned? A negative value means end of movie reached:
        if Screen('GetMovieTimeIndex', movie) >= duration+starttime
            endtime = Screen('GetMovieTimeIndex', movie);
            break;
        elseif tex<0
            % We're done, break out of loop:
            break;
        end
        
        if tex == 0
            % No new frame in polling wait (tex=0). Just sleep a bit and then retry.
            vbl = WaitSecs('YieldSecs', 0.25*ifi);
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
    
catch %#ok<CTCH>
    sca;
    psychrethrow(psychlasterror);
end

return
