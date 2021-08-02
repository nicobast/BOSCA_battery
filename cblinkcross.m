function cblinkcross(Hertz,duration)

        %central fixation cross blinking with a frequency defined by Hertz in
        %random colors for a certain duration in seconds

%Hertz=1
%duration=10

global bgd

frq=1/Hertz;
times=round(duration/frq);

%orientation sound
% sound(1,'beep.wav');

for (n = 1:times)
%color=rand(3,1);
%color=validcolor; %only show colors with sufficient contrast
colscreen(bgd,frq);
%fixationcross(frq, color);
fixationcross(frq, 0); %fixed color to black
end

end

