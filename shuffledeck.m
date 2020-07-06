function shuffle = shuffledeck (deck)
%this function takes in a deck and randomizes the order of cards in it

%{
Truman Paras
ITP 168 Spring 2020
Homework 7
tparas@usc.edu
%}

if isfield(deck, 'Value') && isfield(deck, 'Suit') && isfield(deck, 'Score')
    if numel(deck) >= 10
        for ii = 1:numel(deck)
            % create two random locations in the deck
            randomRow1 = randi([1, size(deck,1)]);
            randomRow2 = randi([1, size(deck,1)]);
            randomColumn1 = randi([1, size(deck,2)]);
            randomColumn2 = randi([1, size(deck,2)]);
            % use a place holder to set the two random locations' stored values equal to eachother
            cardPlaceHolder = deck(randomRow1, randomColumn1);
            deck(randomRow1,randomColumn1) = deck(randomRow2, randomColumn2);
            deck(randomRow2,randomColumn2) = cardPlaceHolder;
        end
        shuffle = deck;
    else
        error('ERROR: Not enough cards');
    end
else
    error('ERROR: Invalid input');
end
end
