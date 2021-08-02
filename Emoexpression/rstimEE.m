function [rEEpath] = rstimEE

global outlist path
%function to select a random emotion expression movie and return path to it

% for first call change dir to struct list, inlist is global = 0
if isstruct(outlist)
    f = outlist;
else 
    %f = dir([path 'Emoexpression\emostimuli']);
    f = dir(fullfile(path,'Emoexpression','emostimuli'));
    f = f(3:length(f),:); %remove weird folder entries
end 

ridxEE = randi(numel(f));
disp(['random emotion expression is:' f(ridxEE).name] ); 
rEEpath = fullfile(path,'Emoexpression','emostimuli',f(ridxEE).name);
f(ridxEE) = []; %delete entry to prevent double reselection in next trial
 
outlist = f;

%end