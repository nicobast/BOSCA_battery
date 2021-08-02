function visualsearch

%initdummy
%Screen('Preference', 'TextRenderer', 1)

%visual search settings

    %accordings to Gliga 2014: 64 trials, maybe split to 4 blocks?
    %trials = 16;
    global vissearchtrials

global bgd windowRect window targetrect ifi waitframes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%        COORDINATES OF STIMULI

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect); 
% % Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 200];

% define coordinates of stimuli
NC = [125 375]; %non center parameter - second value as 3 times the first value to keep equi-center distances
squareXpos = [xCenter-NC(2) xCenter-NC(2) xCenter-NC(1) xCenter-NC(1) xCenter+NC(1) xCenter+NC(1) xCenter+NC(2) xCenter+NC(2)];
squareYpos = [yCenter-NC(1) yCenter+NC(1) yCenter-NC(2) yCenter+NC(2) yCenter-NC(2) yCenter+NC(2) yCenter-NC(1) yCenter+NC(1)];

posoffset = 100;
squareXpos = squareXpos - posoffset;
squareYpos = squareYpos - posoffset;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%              STRING PRESENTATION

%set screen text properties
txtsz = 220;
Screen('TextFont',window, 'Arial');
Screen('TextSize',window, txtsz);

try 

  for n = 1:vissearchtrials 
    
  break_loop = 0;  
    
  % blinking fix cross
   cblinkcross(5,1);
   
  %select stimuli
  %stimuli = ['X' 'V' 'H' 'O' 'U' 'Z' 'T' 'N' 'E'];
  stimuli = ['V' 'O' 'S' 'H'];
  msize = numel(stimuli);
  distractor = ['X']; 
  %random def of target
  target = stimuli(randperm(msize, 1));

  %new random color generator with colors of sufficient contrast     
  cointoss = randi(3);
  switch cointoss
      case 1
          rancol = [0 0 0];
      case 2
          rancol = [1 0 0];
      case 3
          rancol = [0 0 1];
  end 
           
      %draw distractors
      numSqaures = length(squareXpos);
      for i = 1:numSqaures
      Screen('DrawText', window, distractor, squareXpos(i), squareYpos(i) , rancol);
      end

      %select one random X and Y position
      msize = numel(squareXpos);
      randelement = randperm(msize, 1);
      randX = squareXpos(randelement);
      randY = squareYpos(randelement);

      %mask one random distractor
      rectsz = txtsz-55;
      targetrect = [randX randY randX+rectsz randY+rectsz];
      Screen('FillRect', window, bgd, targetrect);  
      
      %draw TARGET on that random position
      Screen('DrawText', window, target, randX, randY, rancol);

  %capture event with target, distractor and position of target
  ETevent(strcat('target:',target,'_',num2str(targetrect(1)),'_',num2str(targetrect(2)),'_',num2str(targetrect(3)),'_',num2str(targetrect(4))))
    
  Screen('Flip', window); 
             
    %Wait for seconds or keypress
    %WaitSecs(1.5); %wait time according to Gliga 2014
    tEnd=GetSecs+1.5;
    while GetSecs<tEnd
      WaitSecs(0.001);
      if KbCheck
        break_loop = 1;
      end
    end  
    
    %break for loop of trials, when key was presses 
    if break_loop == 1
      break; 
    end
    
   end

catch
    
  sca;
  psychrethrow(psychlasterror);
    
end

%enddummy

end   