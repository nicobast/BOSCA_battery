function voddball   

    %visual oddball paradigm
    %voddp function controls stimulus presentation time and ISI
    %rstim function controls random selection of stimuli

% Clear the workspace and the screen
 sca;
 close all;
 clearvars;

global bgd windowRect window colran yCenter xCenter screenXpixels screenYpixels ifi waitframes vbl Ncol Dcol Tcol famtrial;

%specific to voddball settings

    %set random number generator based on machine timestamp
    rng('shuffle')
    
    %counterbalance condition
    cb = input('input counterbalance condition (1 or 2)', 's');
    disp(['counterbalance condition:' num2str(cb)]);
  
    %interlaced movie file
    movie = 'C:\Users\Nico\Documents\MATLAB\cartooncarsSNIP.mp4';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   INIT  --> PUT TO GLOBAL
  
% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);
% 
% % Get the screen numbers
screens = Screen('Screens');
% 
% % Draw to the external screen if avaliable
 screenNumber = max(screens);
% 
% % Define black and white
 white = WhiteIndex(screenNumber);
 black = BlackIndex(screenNumber);
%
%  Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, bgd);
 
 % Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);  

% %set background
% bgd = white;

%timing settings
vbl = Screen('Flip', window);
ifi = Screen('GetFlipInterval', window);
waitframes = 1;

%set processing priority
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      random color selection

%random basic color generator; excluded yellow included black
colran = [0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 0 0 0];

     %chose random color for random stimuli 
     cposD = randperm(length(colran),1);
     Dcol = colran(cposD,:)
     colran(cposD,:) = []; %prevent reselecting random color

     cposT = randperm(length(colran),1);
     Tcol = colran(cposT,:)
     colran(cposT,:) = [];

     cposN = randperm(length(colran),1);
     Ncol = colran(cposN,:)
     %colran(cposN,:) = [];
     
     %chose random color without Dcol Tcol for novel stimuli
     Nffcol = colran(randperm(length(colran),1),:);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      random simuli selection

%1global nlist

    [distractor, target, nlist] = rstim;    
    
    function nov 
    [novelstim, nlist] = nstim(nlist); %select a stimulus not chosen before
    novelstim(colran(randperm(length(colran),1),:)); %define random color but Tcol and Dcol, see above
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      define function to assign randomly selected colors to randomly selected stimuli
    
    function tar
    target(Tcol);
    end
    
    function dis
    distractor(Dcol);
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

  disp('start of familiarization trial');
  
       %four time 5s presentation of target and distractor 
       famtrial = 1;
       
       if cb == '1'
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
       elseif cb == '2'
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
       end
       
      famtrial = 0;
           
  disp('end of familiarization trial');
  disp('... WAITING FOR KEYPRESS');
  KbStrokeWait;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      preexperimental trial
 
disp('Continue with preexperimental trial...')
% manipulation check of reaction to target and distractor: presentation of stimuli similar to experimental trial
        if cb == '1'
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
       elseif cb == '2'
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
            dis;
            tar;
       end
  disp('end of prexperimental trial');
  disp('... WAITING FOR KEYPRESS');
  KbStrokeWait;
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      experimental trial

 disp('Continue with EXPERIMENTAL trial...');
 
%present 5 blocks intermingled with attention movie 
voddblock; %call randomly selected colored stimuli in permutated order
midx = attmovie(movie,0); %plays attentive movie   
colscreen(bgd,2); %filler colors screen
voddblock;
midx = attmovie(movie,midx); %plays attentive movie   
colscreen(bgd,2); %filler colors screen
voddblock;
midx = attmovie(movie,midx); %plays attentive movie   
colscreen(bgd,2); %filler colors screen
voddblock;
midx = attmovie(movie,midx); %plays attentive movie   
colscreen(bgd,2); %filler colors screen
voddblock;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      stimuli

    %% POLYGON with 3 - 8 sides
% %     polygon(Ncol);
%     
%     %%      RECTGRID
%     rectgrid(Tcol);
% %     
% %     %%      DIAG RECT LINE
%     diagrectline(Dcol);
%     
%     %% PHAT CROSS
%     phatcross;
%  
%     %% FOURCIRCLES
%     fourcircles;
%     
%     %% CONELINE
%     coneline;
%     
%     %% FRAME
%     frame;
%     
%     %%      OFFSETRINGS
%     offsetrings;    
%     
%     %%      CONCENTRICRINGS
%     concentricrings;
%     
%     %%      RHOMBICROSS
%     rhombicross; 
%     
%     %%     STAR8S
%     star;
% 
%     %%      FLOWER
%     flower;
%    
%     %%    TRIANGLES
%     triangles;
%     
%     %%      RECTCHAIN
%     rectchain;
%     
%     %%      CONEGRID
%     conegrid;
%     
%      %%     CIRCLETRIANGLE
%     circletriangle;
%     
%     %%      HOFENCE
%     hofence;
%     
%      %%     CONECROSSCIRCLE
%     conecrosscircle;
%     
%     %%      POLYGONCIRCLE
%     polygoncircle;
%     
%       %%    CHECKERBOARD
%     checkboard;
%     
%     %%      PILLARS
%     pillars;
    
Priority(0);    
sca;  

end   