function screenshot(name)

global window

    % GetImage call. Alter the rect argument to change the location of the screen shot
    imageArray = Screen('GetImage', window, [0 0 600 600]);

    % imwrite is a Matlab function, not a PTB-3 function
    imwrite(imageArray, name)

end