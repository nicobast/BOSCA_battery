function [pass] = colorcontrast(color,bgd)

    %determines and returns in boolean whether a color has a sufficient RGB 
    %color contrast to background

%color = [255 0 0];
%color = [randi(255), randi(255), randi(255)]
%bgd = [255 255 255];

if bgd == 1
    bgd = [255 255 255];
elseif bgd == 0
    bgd = [0 0 0];
end

%color brightness formula (299R1 + 587G1 + 114B1)/1000.
brightcol=(299*color(1)+587*color(2)+114*color(3))/1000; 
brightbgd=(299*bgd(1)+587*bgd(2)+114*bgd(3))/1000; 
%calculate difference
brightdiff=abs(brightbgd-brightcol);

%color difference formula
huediff=abs(bgd(1)-color(1))+abs(bgd(2)-color(2))+abs(bgd(3)-color(3));


if huediff>500 && brightdiff>125
    pass = 1;
else pass = 0;
end 

end 