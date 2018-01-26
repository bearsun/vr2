% test the move function with a little game!

map = [1:5;
       16,0,0,0,6;
       15,0,0,0,7;
       14,0,0,0,8;
       13,12,11,10,9];

room = input('room?');
heading = input('heading?');
figure;
while heading %0 to quit
    room = move(room, heading);
    imagesc(map == room);
    heading = input('heading?');
end
close all;