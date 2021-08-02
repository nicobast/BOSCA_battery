function colscreen(color, prestime)

global window waitframes ifi;

  if ~exist('prestime','var')
        prestime=0;
  end  

vbl = Screen('Flip', window);
% Color the screen to background color
Screen('FillRect', window, color);
Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

% if prestime > 0
% 
% % %% start mouse tracker as emulation of eye tracker    
% %     % Set Mouse/Tracker position
% %     [a,b] = RectCenter(windowRect);
% %     %SetMouse(a,b,screenNumber); %mouse pointer to middle of press screen
% % 
% %     %setup variables
% %     duration = 0;
% %     start = GetSecs;
% %     ETfreq = 0.1;
% %     runs=prestime/ETfreq;
% % 
% %     for i = 1:runs
% %         %  "pseudo-eyetracker")
% %         [mx, my]=GetMouse;
% %         ETvec(i,1)=GetSecs;
% %         ETvec(i,2)= mx;
% %         ETvec(i,3)= my;
% % 
% %         %emulate frequency of eyetracker
% %         WaitSecs('YieldSecs', ETfreq);
% %     end 
% % 
% %     ETcall = ETcall + 1;
% %     duration = GetSecs - start;
% %     save([path 'data\' int2str(ETcall) '.txt'],'ETvec','-ASCII');
% 
% eye-tracking specific settings
% currentFrameRate = 300;
% ETfreq = 1/currentFrameRate;
% runs = prestime/ETfreq;
% 
% for i = 1:runs
%     
%     WaitSecs('YieldSecs', ETfreq);

% Save event time
ETevent(strcat('colscreen','_col:',num2str(color),'_dur:',num2str(prestime)));

WaitSecs(prestime);

end 

% end

% end