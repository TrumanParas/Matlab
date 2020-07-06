function rank = calchand (hand)
%this function calculates the value of a givenhand

%{
Truman Paras
ITP 168 Spring 2020
Homework 7
tparas@usc.edu
%}

if isfield(hand,'Suit') && isfield(hand,'Value') && isfield(hand,'Score') && numel(hand) == 5
    %set starting rank to be zero
    rank = 0;
    %set up a placeholder array that will determine how many of the same card there is in the deck
    pairs = zeros(1,5);
    
    %% Create a placeholder array for the hand we're given
    
    for ii = 1:5
        for jj = 1:5
            if hand(jj).Score == hand(ii).Score %compare it to the score of each other card in the deck
                pairs(ii) = pairs(ii) + 1; %if there is a match, store the value in the placeholder array
            end
        end
    end
    
    %% Analyse the placeholder array to determine pairs
    
    for ii = 1:5
        if pairs(ii) == 2
            pairsStored2(ii) = 1; %create a new matix to hold pair values
        else
            pairsStored2(ii) = 0;
        end
        if pairs(ii) == 3
            pairsStored3(ii) = 1; %create a new matrix to hold three of a kind vaules
        else
            pairsStored3(ii) = 0;
        end
    end
    
    if sum(pairsStored2) == 2 %if the sum of the new matrix for two pairs equals 2
        if sum(pairsStored3) == 3 %and the sum of the new matrix for three of a kind values equals 3
            rank = 6; %fullhouse
        else
            for ii = 1:5
                if pairsStored2(ii) == 1
                    sumScore(ii) = hand(ii).Score;
                else 
                    sumScore(ii) = 0;
                end
            end
            if sum(sumScore) >= 22 %if the sum of the score values for the pair is greater than 22, then the card is a jack or higher
                rank = 1; %pair
            end
            
        end
    end
    
    if sum(pairs == 2) == 4
        rank = 2; %two pairs
    elseif sum(pairs == 3) == 3
        rank = 3; %three of a kind
    elseif sum(pairs == 4) == 4
        rank = 7; %four of a kind
    elseif sum(pairs == 5) == 5
        rank = 10; %five of a kind
    end
    
    %% Flush
    
    %the suits must all have to have the same string, so compare each one to thenext. If they all are the same, then it is a flush
    if strcmp(hand(1).Suit,hand(2).Suit) && strcmp(hand(2).Suit,hand(3).Suit) && strcmp(hand(3).Suit,hand(4).Suit) && strcmp(hand(4).Suit,hand(5).Suit)
        rank = 5;
    end
    
    %% Straight
    
    for ii = 1:5
        storeScore(ii) = hand(ii).Score; % set up an array that holds each score
    end
    
    %sort the array in ascending order and check if the difference between the cards is one. If it is, it is a straight
    storeScore = sort(storeScore);
    differenceArray = diff(storeScore);
    
    isStraight = true;
    
    for ii = 1:4
        if differenceArray(ii) ~= 1 %if the difference is only one
            isStraight = false;
        end
    end
    
    if isStraight == true && rank == 5 %and if already a flush
        rank = 8; %straight flush
        for jj = 1:4
            %and if all the cards are a 10 or greater
            if  min([hand(jj).Score]) == 10
                rank = 9; %royal flush
            end
        end
    elseif isStraight == true
        rank = 4; %otherwise, it is just a straight
    end
    
    
    
    
else
    error('improper input!');
end
end
