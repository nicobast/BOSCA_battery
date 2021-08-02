function pts = PlotCalibrationPointsPTB(calibPlot, Calib, mOrder)
%PLOTCALIBRATIONPOINTS plots the calibration data for a calibration session
%   Input: 
%         calibPlot: The calibration plot data, specifying the input and output calibration data   
%         Calib: The calib config structure (see SetCalibParams)         
%         mOrder: Vector containing indices indicating the order in which to show the calibration points, [1 2 3 4 5] to show five calibration points in order or [1 3 5 2 4] to show them in different order.
%     
%   Output: 
%         pts: The list of points used for calibration. These could be
%         further used for the analysis such as the variance, mean etc.

    %close all
    
    %% for testing 
%     load('boguscalib.mat');
%     calibPlot=calibplot; %object that is loaded
%     SetCalibParams;
%     PsychDefaultSetup(2);
%     
    %% calibration plot code
    NumCalibPoints = length(calibPlot)/8;
    
    if (NumCalibPoints == 0 )
        pts = [];
        disp('no calib point found');
        return;
    end
    
    clear OrignalPoints
    clear pts
    
    j = 1;
    for i = 1:NumCalibPoints
        OrignalPoints(i,:) = [calibPlot(j) calibPlot(j+1)];
        j = j+8;
    end
    lp = unique(OrignalPoints,'rows');
    for i = 1:length(lp)
        pts(i).origs = lp(i,:);
        pts(i).point =[];
    end
    j = 1;
    for i = 1:NumCalibPoints
        for k = 1:length(lp)
            if ((calibPlot(j)==pts(k).origs(1)) && (calibPlot(j+1)==pts(k).origs(2)))
                n = size(pts(k).point,2);
                pts(k).point(n+1).validity = [calibPlot(j+4) calibPlot(j+7)];
                pts(k).point(n+1).left= [calibPlot(j+2) calibPlot(j+3)];
                pts(k).point(n+1).right= [calibPlot(j+5) calibPlot(j+6)];
            end
        end
        j = j+8;
    end
     
    %show calibrationplot on upper right quarter of observer screen
    % Get screen dimensions from SetCalibParams
    windowx = Calib.mondims2.width/2;
    windowy = Calib.mondims1.height + 1;
    windowwidth = Calib.mondims2.width;
    windowheight = Calib.mondims1.height + Calib.mondims2.height/2; 
    
    %open window on upper right quarter of observer screen
        %skip sync tests and give no output about errors
        Screen('Preference', 'SkipSyncTests', 1);
        Screen('Preference', 'Verbosity', 0);
    [windowc, windowRect] = PsychImaging('OpenWindow', Calib.intscreen, 1, [windowx windowy windowwidth windowheight]);
    
        %plot all calibration points
        for i = 1:length(lp)
            calibRef(:,i)=[windowRect(3)*pts(i).origs(1);windowRect(4)*pts(i).origs(2)];
            for j = 1:size(pts(i).point,2)
                %if calibration point is valid save for drawing below
                if (pts(i).point(j).validity(1)==1) 
                calibPointsLeft(:,j)=[windowRect(3)*pts(i).point(j).left(1);windowRect(4)*pts(i).point(j).left(2)];
                end
                if (pts(i).point(j).validity(2)==1)
                calibPointsRight(:,j)=[windowRect(3)*pts(i).point(j).right(1);windowRect(4)*pts(i).point(j).right(2)];
                end
            end
            
            %draw reference calibration point 
            % - code inside loop to draw lines below
            Screen('DrawDots', windowc,calibRef,Calib.SmallMark/4,Calib.fgcolor,[],1);
            
            %draw orienting Ocal around reference calib points
            newRect = CenterRectOnPointd([0 0 Calib.BigMark Calib.BigMark], calibRef(1,i),calibRef(2,i));
            Screen('FrameOval', windowc,Calib.fgcolor, newRect);
            
            
            %draw valid recorded calibration points (left = r, right = g) 
            Screen('DrawDots', windowc,calibPointsLeft,Calib.SmallMark/4,[1 0 0],[],1);
            Screen('DrawDots', windowc,calibPointsRight,Calib.SmallMark/4,[0 1 0],[],1);
 
                %define line points - from reference points to cal points
                %x coordinates of line points
                fromCalibRef.W=repelem(calibRef(1,i),size(calibPointsLeft,2));
                startendW=[fromCalibRef.W;calibPointsLeft(1,:)];
                startendW=startendW(:)'; %bring into right format for below
                startendW(startendW==0) = []; %remove zero values
                
                %y coordinates of line points
                fromCalibRef.H=repelem(calibRef(2,i),size(calibPointsLeft,2)); 
                startendH=[fromCalibRef.H;calibPointsLeft(2,:)];
                startendH=startendH(:)';
                startendH(startendH==0) = [];
                
            %draw lines from reference point to calibration points
            Screen('DrawLines', windowc, [startendW; startendH],[],[1 0 0]);
            
                %define line points - from reference points to cal points
                %x coordinates of line points
                fromCalibRef.W=repelem(calibRef(1,i),size(calibPointsRight,2));
                startendW=[fromCalibRef.W;calibPointsRight(1,:)];
                startendW=startendW(:)'; %bring into right format for below
                startendW(startendW==0) = []; 
                
                %y coordinates of line points
                fromCalibRef.H=repelem(calibRef(2,i),size(calibPointsRight,2)); 
                startendH=[fromCalibRef.H;calibPointsRight(2,:)];
                startendH=startendH(:)';
                startendH(startendH==0) = [];

            %draw lines from reference point to calibration points
            Screen('DrawLines', windowc, [startendW; startendH],[],[0 1 0]);
                   
            %erase for next call
            calibPointsLeft = [];
            calibPointsRight = [];
            
        end 
        
            %flip all drawn points and lines to screen
            Screen('Flip', windowc);
            
end
