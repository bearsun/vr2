function [room, heading] = move( room, heading )
%MOVE function move 1-step!

% a big decision tree!
if heading == 2 % heading east
    if room < 5
        room = room + 1;
    elseif room > 9 && room < 14
        room = room - 1;
    end
elseif heading == 4 % heading west
    if room > 1 && room < 6
        room = room - 1;
    elseif room > 8 && room < 13
        room = room + 1;
    end
elseif heading == 1 % heading north
    if room > 12 && room < 16
        room = room + 1;
    elseif room == 16
        room = 1;
    elseif room > 5 && room < 10
        room = room - 1;
    end
elseif heading == 3 % heading south
    if room == 1
        room = 16;
    elseif room > 13
        room = room - 1;
    elseif room > 4 && room < 9
        room = room + 1;
    end
end

end

