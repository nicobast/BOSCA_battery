function biomotion
%original task Schaer: present 10 videos with screens split into faces/geometric shapes
%movies are presented in a fixed order and a turning wheel is presented as
%fixation cross - adaptions: present in random order - use our fixation
%cross

global path BMblock   
%determine presentation of blocks
if isempty(BMblock)
    BMblock=randi(2);
end

%find biomotion stimuli
switch BMblock
    case 1
        blockname='blockA';
        ETevent(strcat('biomotion_',blockname))
        f = dir(fullfile(path,'Biomotion','stimuli',blockname));
        f = f(3:length(f),:); %remove weird folder entries
        BMblock = 2;
    case 2
        blockname='blockB';
        ETevent(strcat('biomotion_',blockname))
        f = dir(fullfile(path,'Biomotion','stimuli',blockname));
        f = f(3:length(f),:); %remove weird folder entries
        BMblock = 1;
end     

for i = 1:length(f)
    randomstim = randi(numel(f)); %determine random stimulus
    disp(['random biomotion:' f(randomstim).name] ); 
    randomstimpath = fullfile(path,'Biomotion','stimuli',blockname,f(randomstim).name);

    cblinkcross(5,1); %cross blinking with 5 Hz for 1 second
    ETevent(strcat('biomotion_',f(randomstim).name))
    intromovie(randomstimpath)
    
    f(randomstim) = []; %delete entry to prevent double reselection in next trial
end

end