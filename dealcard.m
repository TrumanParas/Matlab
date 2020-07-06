function [topCard, uncelledDeck] = dealcard(deck)
%this function defines the first card in the deck, eliminates it the deck, and creates a new object that holds the rest of the cards

if isfield(deck, 'Value') && isfield(deck, 'Suit') && isfield(deck, 'Score') %validate
    if numel(deck) >= 10
        
        %the top card is the first element in the deck
        topCard = deck(1,1);
        
        %make a cell array to temporarily hold the remianing values
        restOfDeck = cell(numel(deck) - 1,1);
        %recreate the original deck, but with the first card removed, shifting all the elements up by one
        for ii = 2:numel(deck)
            restOfDeck{ii - 1} = deck(ii);
        end
        
        %turn the cell into a structure
        uncelledDeck = repmat(struct('Suit', [], 'Value', [], 'Score', []), 1, numel(restOfDeck));
        for ii = 1:numel(restOfDeck)
            uncelledDeck(ii) = restOfDeck{ii}; %define the rest of the deck
        end
    else
        error('ERROR: Invalid input');
    end
end

end
