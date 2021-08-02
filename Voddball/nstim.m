function [rN, outlist] = nstim(inlist)

    %selects a random stimuli by permutation from the list provided by
    %inlist

ridxN = randi(numel(inlist));
disp( ['random NOVELSTIM: ' inlist(ridxN).name] ); 
rN = inlist(ridxN).name;
rN = strtok(rN,'.');
rN = str2func(rN);
inlist(ridxN) = [];

outlist = inlist;

end