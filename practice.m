function practice
global ptb_RootPath %#ok<NUSED>
global ptb_ConfigPath %#ok<NUSED>

%% prep params
rng('shuffle');
sid = 0;

srect = [0 0 1025 769];

% subj=input('subject?','s');
% session = input('session? (pre/post)','s');
% run=input('run?');

%% keys
kleft = KbName('Left');
kright = KbName('Right');
kup = KbName('Up');
kdown = KbName('Down');
kesc = KbName('Escape');
possiblekn = [kleft, kright, kup, kdown, kesc];

%% geometry
fixsi = 6;
fixring = 10;

gray = [128, 128, 128];
white = [255 255 255];
black = [0 0 0];
green = [0 255 0];
red = [255 0 0];
fixcolor = white;
fixcolor2 = black;
bgcolor = black;

%% room geometry
% there are 16 possible positions in the maze (1-16)
% 1 at Northwest corner, 5 at NE, 9 at SE, 13 at SW
positions = 1:16;
% there are 4 possible headings at each position
% 1 to north, 2 to east, 3 to south, 4 to west
headings = 1:4;

pic2maze = csvread('maze_code');

%% structure the run with randomized trials
ntrials = 24;
design = [ones(6,1),   (3:8)';
          ones(6,1)*2, ([1:2,5:8])';
          ones(6,1)*3, ([1:4,7:8])';
          ones(6,1)*4, (1:6)'];
rng('shuffle');
design = design(randperm(ntrials),:);

start_heading = 1:4; %init heading for the 4 corner rooms

%% open windows
[rect, mainwin] = Screen('OpenWindow', 0, [0 0 0], [0 0 1024 768]);

%% load images files
texs = NaN(8,1);
for i = 1:8
    img = imread(['./pics/',num2str(i),'.png']);
    texs(i) = Screen('MakeTexture', mainwin, img);
end

%% start exp
for itrial = 1:ntrials
    room = design(itrial,1);
    heading = start_heading(room);
    target = design(itrial,2);
    
    while ~(room == ceil(target/2))
        Screen('DrawTexture', mainwin, texs(pic2maze(room,heading)));
        Screen('Flip');
        
        keypressed = NaN;
        while 1
            [keyIsDown, ~, keyCode] = KbCheck;
            if keyIsDown
                if sum(keyCode) == 1
                    if any(keyCode(possiblekn))
                        keypressed=find(keyCode);
                        break;
                    end
                end
            end
        end
        
        % rotating view?
        if keypressed == kleft
            heading = heading - 1;
            if heading < 1
                heading = 4;
            end
        elseif keypressed == kright
            heading = heading + 1;
            if heading > 4
                heading = 1;
            end
        end
        
        if keypressed == kup
            room = move(room, heading);
        end
        
        if keypressed == kesc
            session_end;
        end
        
    end
    
    Screen('DrawTexture', mainwin, texs(pic2maze(room,heading)));
    DrawFormattedText(mainwin, 'Arrived!','center','center', green);
    Screen('Flip');
    
    
end

    function session_end
        sca;
        clear all;
        return
    end
end