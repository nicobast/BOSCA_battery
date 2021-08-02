function ynkey = yesnopress

%wait for a keypress of "y" or "n" without need of command window input
%does nothing until y or n is pressed
%requires Psychtoolbox

%doen by @nbast

ynkey=0;

while(ynkey==0)

%wait for keypress
KbWait();

%check which key is pressed, ouput is vector of size 256
[~, ~, keycodes] = KbCheck();
%find the keycode that is pressed
pressedkeycode = find(keycodes,1);

if (pressedkeycode==89) %89 is keycode of key y
    ynkey='y';
end 

if (pressedkeycode==78) %89 is keycode of key y
    ynkey='n';
end 

WaitSecs(0.1);
end

end