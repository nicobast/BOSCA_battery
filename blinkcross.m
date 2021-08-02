function blinkcross(Hertz,duration)

frq=1/Hertz;
times=round(duration/frq);

for (n = 1:times)
color=1;
colscreen([0 0 0],frq);
fixationcross(frq, color);
end

end

