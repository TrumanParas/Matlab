function [] = printcard (card)
%this funtion displays a card

%{
Truman Paras
ITP 168 Spring 2020
Homework 7
tparas@usc.edu
%}

%validate
if isfield(card, 'Value') && isfield(card, 'Suit') && isfield(card, 'Score')
    if numel(card) == 1
        
        fprintf('%s ',card.Value); % print value
        fprintf('%s ','of'); % print 'of'
        fprintf('%s\n',card.Suit); % print suit
        
    end
end