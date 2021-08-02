function testblockB

        % random display of the testblocks of array below

global bgd blockblist

%define testblock list on first call
if ~iscell(blockblist)  
  blockblist ={'voddball2';'smoothpursuit';'voddball2';'voddball2'};
end


i = randi(length(blockblist));
%translate each element from cell-->string-->function
rtest = str2func(strjoin(blockblist(i)));

%display a random block of a random test (events are saved within tests)
rtest();

%delete selected test
blockblist(i) = [];
%blank screen after rtest display for 2 seconds
colscreen(bgd,2);

end