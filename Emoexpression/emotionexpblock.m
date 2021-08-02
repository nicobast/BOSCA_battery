function emotionexpblock

global bgd;

    %displays three random emotion expressions from outlist
    % and returns remaining emo exp in list to global

cblinkcross(5,1);
[out1] = rstimEE;
emoexpression(out1);
colscreen(bgd,2);
[out1] = rstimEE;
emoexpression(out1);
colscreen(bgd,2);
[out1] = rstimEE;
emoexpression(out1);
colscreen(bgd,2);

end