%this script models conrad's game of life

clear; clc;


numWorlds = input('How many generations do you want to play? ');
rowNum = input('How many rows? ');
columnNum = input('How many columns? ');
start = input('Start Game (Y/N) ', 's');

if strcmpi(start, 'N')
    error('You gay')
end

figure()
world = round(rand(rowNum,columnNum));

for n = 1:numWorlds
    
    newWorld = zeros(rowNum,columnNum);
    %top and bottom edges
    for row = [1,rowNum]
        for column = 2:columnNum-1
            if world(row,column) == 1 %live cell
                if row == 1
                    neighborhood = sum(sum(world(row:row+1,column-1:column+1)))-1;
                end
                if row == rowNum
                    neighborhood = sum(sum(world(row-1:row,column-1:column+1)))-1;
                end
                if neighborhood < 2 % death by underpopulation
                    newWorld(row,column)=0;
                elseif neighborhood >= 2 && neighborhood <= 3
                    newWorld(row,column)=1;
                elseif neighborhood > 3
                    newWorld(row,column)=0;
                end
            else %not live cell
                if row == 1
                    neighborhood = sum(sum(world(row:row+1,column-1:column+1)));
                end
                if row == rowNum
                    neighborhood = sum(sum(world(row-1:row,column-1:column+1)));
                end
                if neighborhood == 3
                    newWorld(row,column)=1;
                end
            end
        end
    end
    %side edges
    for row = 2:rowNum-1
        for column = [1,columnNum]
            if world(row,column) == 1 %live cell
                if column == 1
                    neighborhood = sum(sum(world(row-1:row+1,column:column+1)))-1;
                end
                if column == columnNum
                    neighborhood = sum(sum(world(row-1:row+1,column-1:column)))-1;
                end
                if neighborhood < 2 % death by underpopulation
                    newWorld(row,column)=0;
                elseif neighborhood >= 2 && neighborhood <= 3
                    newWorld(row,column)=1;
                elseif neighborhood > 3
                    newWorld(row,column)=0;
                end
            else %not live cell
                if column == 1
                    neighborhood = sum(sum(world(row-1:row+1,column:column+1)));
                end
                if column == columnNum
                    neighborhood = sum(sum(world(row-1:row+1,column-1:column)));
                end
                if neighborhood == 3
                    newWorld(row,column)=1;
                end
            end
        end
    end
    
    %corners
    if world(1,1) == 1
        neighborhood = sum(sum(world(1:2,1:2)))-1;
        if neighborhood < 2 % death by underpopulation
            newWorld(1,1)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(1,1)=1;
        end
    else
        neighborhood = sum(sum(world(1:2,1:2)));
        if neighborhood < 2 % death by underpopulation
            newWorld(1,1)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(1,1)=1;
        end
    end
    
    if world(1,columnNum) == 1
        neighborhood = sum(sum(world(1:2,columnNum-1:columnNum)))-1;
        if neighborhood < 2 % death by underpopulation
            newWorld(1,columnNum)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(1,columnNum)=1;
        end
    else
        neighborhood = sum(sum(world(1:2,columnNum-1:columnNum)));
        if neighborhood < 2 % death by underpopulation
            newWorld(1,columnNum)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(1,columnNum)=1;
        end
    end
    
    if world(rowNum,columnNum) == 1
        neighborhood = sum(sum(world(rowNum-1:rowNum,columnNum-1:columnNum)))-1;
        if neighborhood < 2 % death by underpopulation
            newWorld(rowNum,columnNum)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(rowNum,columnNum)=1;
        end
    else
        neighborhood = sum(sum(world(rowNum-1:rowNum,columnNum-1:columnNum)));
        if neighborhood < 2 % death by underpopulation
            newWorld(rowNum,columnNum)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(rowNum,columnNum)=1;
        end
    end
    
    if world(rowNum,1) == 1
        neigborhood = sum(sum(world(rowNum-1:rowNum,1:2)))-1;
        if neighborhood < 2 % death by underpopulation
            newWorld(rowNum,1)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(rowNum,1)=1;
        end
    else
        neigborhood = sum(sum(world(rowNum-1:rowNum,1:2)));
        if neighborhood < 2 % death by underpopulation
            newWorld(rowNum,1)=0;
        elseif neighborhood >= 2 && neighborhood <= 3
            newWorld(rowNum,1)=1;
        end
    end
    
    %rest of board
    for row=2:rowNum-1
        for column=2:columnNum-1
            if world(row,column)==1 % LIVE CELL
                %neighborhood status
                neighborhood = sum(sum(world(row-1:row+1,column-1:column+1)))-1;
                if neighborhood < 2 % death by underpopulation
                    newWorld(row,column)=0;
                elseif neighborhood >= 2 && neighborhood <= 3
                    newWorld(row,column)=1;
                elseif neighborhood > 3
                    newWorld(row,column)=0;
                end
            else
                neighborhood = sum(sum(world(row-1:row+1,column-1:column+1)));
                if neighborhood == 3
                    newWorld(row,column)=1;
                end
            end
        end
    end
    
    life = sum(sum(newWorld));
    dead = rowNum*columnNum - life;
    title(['Living: ', num2str(life), ' || Dead: ', num2str(dead)])
    world = newWorld;
    pause(.01)
    pcolor(world);
    axis ([0, columnNum, 0, rowNum])
    grid off
    drawnow
    
    
end

disp('Done')