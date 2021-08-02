function ETsave

global pname ETl ETr ETt ETevT ETevN

%data is stored in subfolder DATA
%all files Beginn with PNAME
%ETt is saved separately due to required precision
%ETevN ETevT as event data need fprintf as data array as they are different
%classes

disp('<strong>save data...</strong>');
cd data
    
if ~exist(strcat(pname,'_','gazedata.csv'), 'file')
    
    % Save gaze data vectors to file here using e.g:
    % csvwrite(strcat(pname,'_','gazedata.csv'), [ETl ETr]);
    dlmwrite(strcat(pname,'_','gazedata.csv'), [ETl ETr],'delimiter',',');
    
    %timestamp need different dlmwrite as they require higher precision
    % cbind later in R statistics
    % 16 digits equals a microsecond precision and format
    % dlmwrite(strcat(pname,'_','timestamps.csv'), ETt/1000,'precision',13,'delimiter',',');
    dlmwrite(strcat(pname,'_','timestamps.csv'), ETt,'precision','%i','delimiter',',');
   
    % opens/creates a file for writing (w+) and writes string + numerics
    % formatting is specified in fprintf: \r\n to get new row after a row
    % ETevT is divided by 1000 to come from micro to millisecond format
    eventdata = [ETevN, num2cell(ETevT)];
    [nrows,~] = size(eventdata);
    fid = fopen(strcat(pname,'_','event.csv'),'w+');
       for row = 1:nrows
        fprintf(fid, '%s,%i\r\n', eventdata{row,:});
       end 
    fclose(fid);
    
    %clear data arrays for next call of ETsave
    ETl = []; ETr = []; ETt = []; ETevN = []; ETevT = [];
    
else
    
    %if files already exist append to them
    dlmwrite(strcat(pname,'_','gazedata.csv'), [ETl ETr],'delimiter',',','-append');
    dlmwrite(strcat(pname,'_','timestamps.csv'), ETt,'precision','%i','delimiter',',','-append');
    eventdata = [ETevN, num2cell(ETevT)];
    [nrows,~] = size(eventdata);
    fid = fopen(strcat(pname,'_','event.csv'),'a+');
       for row = 1:nrows
        fprintf(fid, '%s,%i\r\n', eventdata{row,:});
       end 
    fclose(fid);
    
    %clear data arrays for next call of ETsave
    ETl = []; ETr = []; ETt = []; ETevN = []; ETevT = [];
    
end    
    
cd ..   
disp('<strong>...done</strong>');
    
end