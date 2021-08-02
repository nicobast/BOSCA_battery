function testblockC

        % testblock of Schaer tasks, each task has two blocks. on every
        % call of testblock C one random block is shown
        % already shown blocks are deleted

        
global bgd blockclist

%define testblock list on first call
if isempty(blockclist)
blockclist ={'jointattention';'jointattention';'biomotion';'biomotion'};
end

%select a random test
i = randi(length(blockclist));
%translate each element from cell-->string-->function
rtest = str2func(strjoin(blockclist(i)));

%display a random block of a random test (events are saved within tests)
rtest();

%delete selected test
blockclist(i) = [];
%blank screen after rtest display for 2 seconds
colscreen(bgd,2);

end