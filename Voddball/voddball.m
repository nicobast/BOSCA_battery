function voddball   

fprintf(1,'task:VISUAL ODDBALL\n');

    %visual oddball paradigm
    %voddp function controls stimulus presentation time and ISI
    %rstim function controls random selection of stimuli

global bgd windowRect window colran yCenter xCenter screenXpixels screenYpixels ifi waitframes vbl Ncol Dcol Tcol famtrial path;

%specific to voddball settings

    %set random number generator based on machine timestamp
    %not implemented in OCTAVE thus commented 
    %rng('shuffle')
    
%define counterbalance condition --> see familiarization   
cb = randi(2);
ETevent(strcat('voddball_cb_',num2str(cb)));

    %interlaced movie file
    movie =fullfile(path,'CartoonCars.mp4');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SPECIFIC INIT

     % Get the size of the on screen window
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    % Get the centre coordinate of the window
    [xCenter, yCenter] = RectCenter(windowRect);  

    %timing settings
    vbl = Screen('Flip', window);
    ifi = Screen('GetFlipInterval', window);
    waitframes = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      random color selection

%random basic color generator; excluded yellow included black
%in version 0.3 excluded all color that fail colorcontrast
%colran = [0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 0 0 0];
colran = [0 0 1; 1 0 0; 0 0 0];

     %chose random color for random stimuli 
     %cposD = randperm(length(colran),1)
     cposD = randi(size(colran,1));
     Dcol = colran(cposD,:);
     colran(cposD,:) = []; %prevent reselecting random color

     cposT = randi(size(colran,1));
     Tcol = colran(cposT,:);
     colran(cposT,:) = [];

     cposN = randi(size(colran,1));
     Ncol = colran(cposN,:);
     
     %chose random color without Dcol Tcol for novel stimuli
     %Nffcol = colran(randperm(length(colran),1),:);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      random simuli selection

    [distractor, target, nlist] = rstim;    
    
    function nov 
    [novelstim, nlist] = nstim(nlist); %select a stimulus not chosen before
    ncol = colran(randi(size(colran,1)),:); %define random color but Tcol and Dcol, see above
    novelstim(ncol); %execute function handle
    ETevent(strcat('nov_',func2str(novelstim),'_',num2str(ncol))) %capture event and chose color
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      define function to assign randomly selected colors to randomly selected stimuli
     
    function tar
    target(Tcol);
    ETevent(strcat('tar_',func2str(target),'_',num2str(Tcol)))
    end
    
    function dis
    distractor(Dcol);
    ETevent(strcat('dis_',func2str(distractor),'_',num2str(Dcol)))
    end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      display of random stimuli with probability of 60%/20%/20%

    %assign stimuli to idx values
    function rndstim(id) 
        if id == 1
            dis;
        elseif id == 2
            tar;
        elseif id == 3
            nov;
        end
    end

    %generate random display order block
    function voddblock
        idx = [1 1 1 2 3];
        for i = 1:5
            k = randi(numel(idx));
            disp(idx(k)); %checks display of stimuli
            rndstim(idx(k));
            idx(k) = [];
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      familiarization trial

    midx = attmovie(movie,0, 15);
    colscreen(bgd,2);
    cblinkcross(5,1);
   
  disp('start of familiarization trial');
  
       %four times 5s presentation of target and distractor 
       global voddballtimes
       
       famtrial = 1;
       if cb == 1
        for i = 1:voddballtimes
            tar;
            dis;
        end 
       elseif cb == 2
        for i = 1:voddballtimes
            dis;
            tar;
        end 
       end
       
      famtrial = 0;
           
   disp('end of familiarization trial');
   %  disp('... WAITING FOR KEYPRESS');
   %  KbStrokeWait;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      preexperimental trial
 
   midx = attmovie(movie,midx, 15);
   colscreen(bgd,2);
   cblinkcross(5,1);

disp('Continue with preexperimental trial...')
% manipulation check of reaction to target and distractor: presentation of stimuli similar to experimental trial
% five times presentation
voddballtimes=voddballtimes+1;
        if cb == 1
          for i = 1:voddballtimes
              tar;
              dis;
          end 
        elseif cb == 2
          for i = 1:voddballtimes
              dis;
              tar;
          end 
        end
  disp('end of prexperimental trial');
  %disp('... WAITING FOR KEYPRESS');
  %KbStrokeWait;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      experimental trial

 disp('Continue with EXPERIMENTAL trial...');

ETevent('voddball_exptrials_start'); 
%present 5 blocks intermingled with attention movie
for i = 1:voddballtimes
      %on fifth trial no attention movie
      if i==5
      cblinkcross(5,1);
      voddblock;
      ETevent('voddball_exptrials_end'); 
      break
      end
      
  cblinkcross(5,1); %attention grabbing cross
  voddblock; %call randomly selected colored stimuli in permutated order
  midx = attmovie(movie,midx,5); %plays attentive movie   
  colscreen(bgd,2); %filler colors screen

end
end   