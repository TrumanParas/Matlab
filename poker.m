
clc; 
clear;

%% Set up

%create two arrays to easily call scores and the money for getting the hand
printScore = ["Pair", "Two Pair", "Three of a kind", "Straight", "Flush", "Full House", "Four of a kind", "Straight Flush", "Royal Flush", "Five of a kind"];
winnings = [1, 2, 3, 5, 7, 8, 10, 15, 20, 35];

play = false;

%ask for a number of decks to play with, and validate it
while play == false
    numDecks = input('Enter number of decks to play with: ');
    
    %validate
    if floor(numDecks) == numDecks && isscalar(numDecks) && isnumeric(numDecks) && numDecks > 0
        play = true;
    else
        fprintf('%s\n', 'Incorrect input! Enter a positive integer value!')
    end
end

cash = 100; %starting cash
    
%% Start playing
while play == true
    %ask for bet
    fprintf('%s%.0f\n', 'You have $', cash);
    bet = false;
    while  bet == false
        betInput = input('Make your bet: $');
        if isnumeric(betInput) && isscalar(betInput) && floor(betInput) == betInput && betInput > 0 && betInput <= cash % validate the bet
            bet = true;
        else
            fprintf('%s\n', 'Invalid bet! Must be positive integer! Cannot exceed current cash!')
        end
    end
    
    %% Organize and shuffle deck
    
    %call the initdeck function to get the cards
    cards = initdeck(numDecks);
    
    %put the cards from a matrix into a row array
    %since cards is a cell, make a cell to insert in values obtained from cards
    %the size of the cell is one row by 52 times the number of decks columns
    rowOfCards = cell(1,52*numDecks);
    
    for ii = 1:numDecks
        currentDeck = cards{ii};
        for jj = 1:52
            rowOfCards(52*(ii - 1)+jj) = {currentDeck(jj)};
        end
    end
    
    %change the cell into a structure
    deck = repmat(struct('Suit',[],'Value',[],'Score',[]),1,numel(rowOfCards));
    
    for ii = 1:numel(rowOfCards)
        deck(ii) = rowOfCards{ii};
    end
    
    %call the shuffle function
    shuffle = shuffledeck(deck);
    
    %% Deal the cards
    newShuffledDeck = shuffle;
    for ii = 1:5
        %call the dealcard function to get a hand of five cards
        [hand(ii), newShuffledDeck] = dealcard(newShuffledDeck);
        fprintf('%.0f%s', ii, ': ')
        printcard(hand(ii));
    end
    
    %call the calchand function to get the rank of the hand
    rank = calchand(hand);
    if rank == 0
        fprintf('%s\n', 'You currently have nothing! Jack or higher to win!')
    else
        fprintf('%s%s%s%f\n', 'You have a: ', printScore(rank), '! Your multiplier is ', winnings(rank)); %print the rank and multiplier
    end
    
    
    %% Swap time
    
    %test for duplicates by setting a conditional, as well as another conditional to enter the while loop
    enterLoop = false;
    duplicates = false;
    
    while enterLoop == false
        swap = input('Swap cards using index values and [], or 0 to keep all your cards: ');
        for ii = 1:numel(swap)
            for jj = 1:numel(swap)
                if swap(ii) == swap(jj) && jj ~= ii
                    duplicates = true;
                    fprintf('%s\n', 'Duplicate values! Try again!')
                end
            end
        end
        
        if numel(swap) <= 5 && isnumeric(swap) && sum(floor(swap) == swap) == numel(swap) && sum(swap > 0) == numel(swap) && sum(swap <= 5) == numel(swap) && duplicates == false 
            enterLoop = true;
        elseif swap == 0 %no swap requested
            enterLoop = true;
        elseif duplicates == false %invalid input of some other sort
            fprintf('%s\n', 'Index values invalid! Try again!')
        end
    end
    
    if  swap ~= 0
        for jj = 1:numel(swap)
            %take the card requested to be swapped and call the dealcard function to replace it with the next card in the deck
            [hand(swap(jj)),newShuffledDeck] = dealcard(newShuffledDeck);
        end
    end
    
    %% Print new hand and calculate the rank again
    
      for ii = 1:5
        fprintf('%.0f%s', ii, ': ')
        printcard(hand(ii));
      end
    
    %call the calchand function to get the rank of the hand
    rank = calchand(hand);
    if rank == 0
        fprintf('%s\n', 'You have nothing! You lose!');
    else
        fprintf('%s%s%s%.0f%s\n', 'You have a: ', printScore(rank), '! Your win ', winnings(rank), 'x your bet!'); %print the rank's string
    end
    
    
    %% Money calculations
    
    play = false; % the round is over
    
    if rank > 0
        win = betInput*winnings(rank);
    else
        win = 0;
    end
    
    cash = cash + win - betInput;
    
    %ask to play again
    userInput = input ('Play again? (Y/N): ','s');
    if strcmpi(userInput,'Y')
        play = true; %user wants to go another round
        if cash == 0
            fprintf('%s\n', 'You are out of money!');
            play = false; %can't play without money
        end
    else
        fprintf('%s\n', 'Thanks for playing!')
    end
end













