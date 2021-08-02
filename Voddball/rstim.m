function [rD,rT,f] = rstim

global path

f = dir(fullfile(path,'Voddball','VoddballStimuli'));
f = f(3:length(f),:); %remove weird folder entries

ridxD = randi(numel(f)); %randomly chose a folder position
disp( ['random DISTRACTOR is: ' f(ridxD).name] );
rD = f(ridxD).name;
rD = strtok(rD,'.'); %remove the file extension ".m" from name
rD = str2func(rD);
f(ridxD) = []; %remove chosen item from list to prevent repetition

ridxT = randi(numel(f));
disp( ['random TARGET is: ' f(ridxT).name] );
rT = f(ridxT).name;
rT = strtok(rT,'.');
rT = str2func(rT);
f(ridxT) = []; %remove chosen item

% ridxN = randi(numel(f));
% disp( ['The randomly chosen NOVELSTIM is: ' f(ridxN).name] ); 
% rN = f(ridxN).name;
% rN = strtok(rN,'.');
% rN = str2func(rN);
% f(ridxN) = [];

end
