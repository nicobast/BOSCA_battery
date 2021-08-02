function ETrec

global ETl ETr ETt 

%% takes eye tracking data array as input and adds eye tracking data to it
% tetio_readGazeData has a buffer capacity of 180.000 samples
% --> buffers 10 minutes of data at 300Hz

[lefteye, righteye, timestamp, ~] = tetio_readGazeData;
    
%         if isempty(lefteye)
%             continue;
%         end

        % concatenate eye tracking data to array
        numGazeData = size(lefteye, 2);
        ETl = vertcat(ETl, lefteye(:, 1:numGazeData));
        ETr= vertcat(ETr, righteye(:, 1:numGazeData));
        ETt = vertcat(ETt, timestamp(:,1));
        
        %calculate hits on targetrect, if targetrect is not zero
%         if any(targetrect)    
%             eyexpos = lefteye(:,7)*windowRect(3);
%             eyeypos = lefteye(:,8)*windowRect(4);
%             
%             hits = inpolygon(eyexpos,eyeypos,windowRect([1 3]),windowRect([2 4]));
%             fprintf(1,'Hits found:')
%             numel(eyexpos(hits))
%             
%             targetrecthits = vertcat(targetrecthits,hits);
%             %targetrecthits = horzcat(targetrecthits,timestamp(:,1)
%         end 
%         
end