function testblockA

global bgd session
% random display of the testblocks of array below
    
%array is of type/class cell    
f ={'emotionexpblock';'visualsearch';'natorientmov'};
%random order of array
f = f(randperm(3));

%go through array f and 
for i = 1:length(f)
   %translate each element from cell-->string-->function
   task = strjoin(f(i));
   rtest = str2func(task);
   %display and capture event = task
   disp(strjoin(f(i)));
   ETevent(strcat(task,session))
   %call this function as function handle:
   rtest();
   %blank screen after rtest display for 2 seconds
   colscreen(bgd,2);
end

end