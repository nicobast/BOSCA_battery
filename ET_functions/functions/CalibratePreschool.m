function calibPlotData = CalibratePreschool(Calib,morder,iter,donts)
%CALIBRATE calibrate the eye tracker
%   This function is used to set and view the calibration results for the tobii eye tracker. 
%
%   Input: 
%         Calib: The calib structure (see CalibParams)
%         morder: Order of the calibration point 
%         iter: 0/1 (0 = A new calibation call, esnure that calibration is not already started)
%                   (1 = just fixing a few Calibration points)
%         donts: Points (with one in the index) that are to be
%         recalibrated, 0 else where
%   Output: 
%         calibPlotData: The calibration plot data, specifying the input and output calibration data

    clc
    assert(Calib.points.n >= 2 && length(Calib.points.x)==Calib.points.n, ...
      'Err: Invalid Calibration params, Verify...');

    figH = figure('menuBar','none','name','Calibrate','Color', Calib.bkcolor,'Renderer', 'Painters','keypressfcn','close;');
    axes('Visible', 'off', 'Units', 'normalize','Position', [0 0 1 1],'DrawMode','fast','NextPlot','replacechildren');
    Calib.mondims = Calib.mondims1;
    %present on secondary screen
    %set(figH,'position',[Calib.mondims.x 1081 Calib.mondims.width Calib.mondims.height]);
    set(figH,'position',[Calib.mondims.x Calib.mondims.y Calib.mondims.width Calib.mondims.height]);
    xlim([1,Calib.mondims.width]); 
    ylim([1,Calib.mondims.height]);
    axis ij;
    set(gca,'xtick',[]);
    set(gca,'ytick',[]);
    if (iter==0)
        tetio_startCalib;    
    end
    idx = 0;
    validmat = ones(1,Calib.points.n);
    %generate validity matrix 
    if ~isempty(donts)
        validmat = zeros(1,Calib.points.n);
        for i = 1:length(donts)
           validmat(morder==donts(i))=1;
        end
    end
    %disp(num2str(validmat)):
    pause(1);
    %step= 10; %(increase for powerful pcs) changed to Calib.step
    Calib.step 
    for  i =1:Calib.points.n
        %show the big marker on a random (morder) position
        if (validmat(i)==0)
            continue;
        end
        ms = Calib.BigMark;    
        idx = idx+1;
        %if it is not first show of big marker, move to next position
        %before shrinking
        if (idx ~= 1)
            linecord = Drawline([Calib.mondims.width*Calib.points.x(morder(idx-1)) Calib.mondims.height*Calib.points.y(morder(idx-1))],...
                [Calib.mondims.width*Calib.points.x(morder(i)) Calib.mondims.height*Calib.points.y(morder(i))]);
            for k = 1:Calib.delta:length(linecord)
                h1 = plot(linecord(k,2),linecord(k,1),...
                    'o','MarkerEdgeColor',Calib.fgcolor, 'MarkerFaceColor',Calib.fgcolor,'MarkerSize',ms);
                drawnow;
                delete(h1);
            end
        end
        
        %play sound
        %output latency is far too high on windows
        %sound(1,'C:\Users\Nico\Documents\ETbat\DEV\beep.wav');
        
        %now shrink
        for j = 1:Calib.step
            if (j==1)
                randcolor = Calib.fgcolor;
            end 
            h1 = plot(Calib.mondims.width*Calib.points.x(morder(i)),...
                Calib.mondims.height*Calib.points.y(morder(i)),...
            'o','MarkerEdgeColor',randcolor,'MarkerFaceColor',randcolor,'MarkerSize',ms);  
            %'o','MarkerEdgeColor',Calib.fgcolor,'MarkerFaceColor',Calib.fgcolor ,'MarkerSize',ms);
            randcolor = [rand(1) rand(1) rand(1)];
              hold on         
             h2 = plot(Calib.mondims.width*Calib.points.x(morder(i)),...
                 Calib.mondims.height*Calib.points.y(morder(i)),...
                 'o','MarkerEdgeColor',Calib.fgcolor2,'MarkerFaceColor',Calib.fgcolor2,'MarkerSize',Calib.SmallMark);
             drawnow;
            if (j==1)
                pause(0.5);
            end
            if (j==Calib.step) 
                if ~isempty(donts)
                    tetio_removeCalibPoint(Calib.points.x(morder(i)), Calib.points.y(morder(i)));
                    disp(['deleted point ' num2str(morder(i)) ' and now adding it, where i = ' num2str(i)])
                end
                tetio_addCalibPoint(Calib.points.x(morder(i)),Calib.points.y(morder(i)));
                pause(0.2);
            end
            ms = ms-ceil((Calib.BigMark - Calib.SmallMark)/Calib.step);
            pause(0.1)
            delete(h1);
            delete(h2)
        end
    end
    pause(0.5);
    close 
    tetio_computeCalib;  
    
    calibPlotData = tetio_getCalibPlotData;
end



