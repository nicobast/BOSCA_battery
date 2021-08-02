function presreward(condition)

    %function that presents social (1) or non-social stimuli (2) depeding
    %on condition. Stimuli are framed by "fishly reward stimuli". function
    %makes use of alpha blending
    
global window woncount lostcount path;

%% TASK SPECIFIC

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

%% STIMULUS CREATION
%stimcase = 2;
stimcase = randi(2);
    %cases: 
        %1 = won + social
        %2 = won + scramble
        %3 = loss + social
        %4 = loss + scramble
        
 %prevent presentation more than three times in a row
        
 switch condition 
     case 1 %social condition
         switch stimcase %won or lost
             case 1
%                inlist = [path 'Reward\rewardstimuli\SOC\won'];
%                midpath = '\SOC\won\';
                inlist = fullfile(path,'Reward','rewardstimuli','SOC','won');   
                % prevent presentation more than three times in a row
                if woncount == 3
                   stimcase = 2; % change for saving 
                   inlist = fullfile(path,'Reward','rewardstimuli','SOC','lost');   
                   lostcount = lostcount+1;
                   woncount = 0;
                else
                woncount = woncount+1;
                lostcount = 0;
                end
             case 2
                inlist = fullfile(path,'Reward','rewardstimuli','SOC','lost');   
                % prevent presentation more than three times in a row
                if lostcount == 3
                    stimcase = 1;
                    inlist = fullfile(path,'Reward','rewardstimuli','SOC','won');   
                    woncount = woncount+1
                    lostcount = 0;
                else
                lostcount = lostcount+1;
                woncount = 0;
                end
         end 
     case 2 %non-social condition
         switch stimcase
             case 1
                inlist = fullfile(path,'Reward','rewardstimuli','NON','won');   
                % prevent presentation more than three times in a row
                if woncount == 3
                   stimcase = 2; % change for saving 
                   inlist = fullfile(path,'Reward','rewardstimuli','NON','lost');   
                   lostcount = lostcount+1;
                   woncount = 0;
                else
                woncount = woncount+1;
                lostcount = 0;
                end
             case 2             
                inlist = fullfile(path,'Reward','rewardstimuli','NON','lost');   
                 % prevent presentation more than three times in a row
                if lostcount == 3
                    stimcase = 1;
                    inlist = fullfile(path,'Reward','rewardstimuli','NON','won');   
                    woncount = woncount+1;
                    lostcount = 0;
                else
                lostcount = lostcount+1;
                woncount = 0;
                end
         end 
%      case 3 %special interest condition
%          switch stimcase
%              case 1
%                 inlist = [path 'Reward\rewardstimuli\SI\won'];
%                 midpath = '\SI\won\';
%              case 2
%                 inlist = [path 'Reward\rewardstimuli\SI\won'];
%                 midpath = '\SI\won\';
%          end
      
     end

% Here we load in a random image from file for specific stimcases
    %positive = surprised, (happy),
    %negative = sad, (disappointed)
f = dir(inlist);
f = f(3:length(f),:); %remove weird folder entries
ridxRE = randi(numel(f));
theImageLocation = fullfile(inlist,f(ridxRE).name);                                     
[theImage, ~, alpha] = imread(theImageLocation, 'png');
theImage(:,:,4) = alpha;

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen.
Screen('DrawTexture', window, imageTexture, [], [], 0);

%load a second image dependign on stimcase 
switch stimcase
    case 1 
        theImageLocation2 = fullfile(path,'Reward','rewardstimuli','fishlyYES.png');   
    case 2 
        theImageLocation2 = fullfile(path,'Reward','rewardstimuli','fishlyNO.png');   
end

%adding the ALPHA CHANNEL for transparency
[theImage2, ~, alpha2] = imread(theImageLocation2, 'png');
theImage2(:,:,4) = alpha2;
imageTexture2 = Screen('MakeTexture', window, theImage2);

Screen('DrawTexture', window, imageTexture2, [], [], 0);

%capture event and conditions
ETevent(strcat('presreward','_condition:',num2str(condition),'_stimcase:',num2str(stimcase)))

% Flip to the screen
Screen('Flip', window);

% Wait for one second - Stavropoulos 2014
WaitSecs(1);

end