function ETevent(eventname)

%captures eventname and corresponding timestamp converted to eye tracker
%time

    global ETevT ETevN

    eventtime = tetio_localToRemoteTime(int64(GetSecs*1000000));

    ETevT = vertcat(ETevT, eventtime);
    ETevN = vertcat(ETevN, cellstr(eventname));
    %ETevN = char(ETevN, eventname);
    
end