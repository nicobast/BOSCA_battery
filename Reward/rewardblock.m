function rewardblock(condition)

%for testing
% initdummy
% condition=2;

global  woncount lostcount bgd;

% 20 trials as fitting trial size compared to Stavropoulos
%trials = 20;
global rewardtrials
woncount = 0;
lostcount = 0;

try 
 
%%  design 
% 2 * 20 trials + special interest condition 
% in random order, but not more than 3 in a row
% take social stimuli from EU-EMOTION battery, as many as possible

%%  instructions
% 
% Participants were told that the reward for each correct
% answer was a goldfish cracker, or if they preferred, fruit
% snacks. Participants were told there was no penalty for
% incorrect answers. Participants were told that if they
% guessed correctly, they would see a ring of intact goldfish
% crackers, and the goldfish would be crossed out for incorrect
% answers.

%% trial loop
for i = 1:rewardtrials

% fixation cross 500ms
fixationcross(0.5,0)

%two question marks 3000ms indicating most fixated question mark 2000ms
validtrial = questionmark;
ETevent(strcat('presreward_validtrial_',num2str(validtrial)))

% random response 1000ms for validtrial
if validtrial == 1
presreward(condition);
colscreen(bgd,2); %inter trial interval 2000ms
end

end

catch
    
Screen('CloseAll');
psychrethrow(psychlasterror);
end

%for testing
% enddummy

end