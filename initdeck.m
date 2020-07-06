function deck = initdeck(numDecks)
% This function will create a number of decks requested by the user

%{
Truman Paras
ITP 168 Spring 2020
Homework 7
tparas@usc.edu
%}

%validate
if isscalar(numDecks) && numDecks > 0 ...
        && isnumeric(numDecks) && floor(numDecks) == numDecks
    
    createDeck = repmat(struct('Suit', [], 'Value', [], 'Score', []), 13, 4);
    
    %% Scores
    for ii = 1:13 %Cycle through each row
        for jj = 1:4 %... and through each column to give out values 2-14
            createDeck(ii, jj).Score = ii + 1;
        end
    end
    
    %% Values
    
    for ii = 1:13
        for jj = 1:4
            if createDeck(ii, jj).Score >= 2 && createDeck(ii, jj).Score <= 10
                createDeck(ii, jj).Value = char(string(createDeck(ii, jj).Score)); % Make a char array that just holds the number of array
            elseif createDeck(ii, jj).Score == 11
                createDeck(ii, jj).Value = 'Jack';
            elseif createDeck(ii, jj).Score == 12
                createDeck(ii, jj).Value = 'Queen';
            elseif createDeck(ii, jj).Score == 13
                createDeck(ii, jj).Value = 'King';
            elseif createDeck(ii, jj).Score == 14
                createDeck(ii, jj).Value = 'Ace';
            end
        end
    end
    
    %% Suits
    for ii = 1:13
        for jj = 1:4
            if jj == 1
                suit = 'Hearts';
            elseif jj == 2
                suit = 'Diamonds';
            elseif jj == 3
                suit = 'Clubs';
            elseif jj == 4
                suit = 'Spades';
            end
            createDeck(ii, jj).Suit = suit;
        end
    end
    % Finally, give the output in the number of wanted decks
    for ii = 1:numDecks % As many times as we are asked...
        deck{ii} = createDeck;
    end
else
    error('ERROR: Incorrect input');
end
end

