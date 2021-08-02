ETinit;        
%InitializePsychSound(1);  %so put in dummyinit?
KbWait;
%ETcalib;
SetCalibParams;
mOrder = randperm(Calib.points.n);
calibplot = CalibratePreschoolPTB(Calib, mOrder, 0, []);
pts = PlotCalibrationPointsPTB(calibplot, Calib, mOrder)
save('boguscalib3.mat','pts')
enddummy;        
        


