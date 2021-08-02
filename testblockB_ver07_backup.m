function testblockB_ver07

        % random display of the testblocks of array below

global bgd rcondition blockblist

%define testblock list on first call
if ~iscell(blockblist)
    % Leonie: auskommentiert
    % blockblist ={'voddball';'smoothpursuit';'rewardblock';'rewardblock'};
blockblist ={'fixationcross_test';'smoothpursuit';'fixationcross_test';'fixationcross_test'};
end


%%

% !!! Leonie: ab hier code aus testblockC übernommen und dafür alten Code
% auskommentiert
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

%select a random test
% i = randi(length(blockblist));
% %translate each element from cell-->string-->function
% if ~strcmp(strjoin(blockblist(i)),'voddball')
% rstring = strjoin(blockblist(i));
% rtest = str2func(rstring);
%     else
%     %OCTAVE workaround: voddball is nested function that is not suported by function handle
%     fprintf(1,'voddball');
%     ETevent('voddball')    
%     voddball;
%     blockblist(1) = [];
%     colscreen(bgd,2);
%     return



%call this function, if this function is rewardblock, set the condition
% if strcmp(rstring,'rewardblock')
%     
%     %%%stop script to give instructions for rewardblock
%     fprintf(1,'INSTRUCTION FOR %s:\n ...press key after instructions\n',rstring);
%     ETevent('waitbpress');
%     WaitSecs('YieldSecs', 0.5);
%     KbWait;
%     
%     if rcondition==2
%         ETevent('rewardblock_1')
%         rtest(1);
%         rcondition=1;
%     elseif rcondition==1
%         ETevent('rewardblock_2')
%         rtest(2);
%         rcondition=2;
%     else rcondition = randi(2);
%         ETevent(strcat(rstring,'_',num2str(rcondition)))
%         rtest(rcondition); 
%     end 
% 
% else
%     
%     %save timestamp of event & execute selected task
%     ETevent(rstring)
%     smoothpursuit
%         
% end 
% 
% %delete selected test
% blockblist(i) = [];
% %blank screen after rtest display for 2 seconds
% colscreen(bgd,2);
% 
% end