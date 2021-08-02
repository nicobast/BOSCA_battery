function vcolor = validcolor

    %return a color that has sufficient contrast to a given bgd (bgd).
    %Sufficient contrast is specified in colorcontrast

global bgd

%bgd=1;
    
    color=[randi(255) randi(255) randi(255)];
    goodcontrast = colorcontrast(color,1);
    while goodcontrast==0
        color=[randi(255) randi(255) randi(255)];
        goodcontrast = colorcontrast(color,bgd);
        if goodcontrast==1
            break
        end 
    end
    
    %transpose row to a column
    vcolor=color';
    %turn into new color coding format
    vcolor=vcolor/255;
    
  end