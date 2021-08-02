function ETrescue(lefteye,righteye,timestamp) 

global ETl ETr ETt 

%%function required if tetio_readGazeData is called outside ETrec
%%to save the data to the variables

%%is ETrec without call of tetio_readGazeData

    numGazeData = size(lefteye, 2);
    ETl = vertcat(ETl, lefteye(:, 1:numGazeData));
    ETr= vertcat(ETr, righteye(:, 1:numGazeData));
    ETt = vertcat(ETt, timestamp(:,1));
    
end