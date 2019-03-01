function whoWon = findWinner( state )
% Here we determine if the state is terminal or not
% 0 -> Game in Progress
% 1 -> X Won
% -1 -> O Won
% 3 -> Draw

    table = reshape(state2table(state),[3,3]);
    % Horizontal
    if (table(1,1) == table(1,2) && table(1,2) == table(1,3) && table(1,3) ~= 0)
        whoWon = table(1,1);
    elseif (table(2,1) == table(2,2) && table(2,2) == table(2,3) && table(2,3) ~= 0)
        whoWon = table(2,1);
    elseif (table(3,1) == table(3,2) && table(3,2) == table(3,3) && table(3,3) ~= 0)
        whoWon = table(3,1);
    % Vertical
    elseif (table(1,1) == table(2,1) && table(2,1) == table(3,1) && table(3,1) ~= 0) 
        whoWon = table(1,1);
    elseif (table(1,2) == table(2,2) && table(2,2) == table(3,2) && table(3,2)~= 0) 
        whoWon = table(1,2);
    elseif (table(1,3) == table(2,3) && table(2,3) == table(3,3) && table(3,3) ~= 0) 
        whoWon = table(1,3);
    % Diagonal
    elseif (table(1,1) == table(2,2) && table(2,2) == table(3,3) && table(3,3) ~= 0)
        whoWon = table(1,1);
    elseif (table(1,3) == table(2,2) && table(2,2) == table(3,1) && table(3,1) ~= 0)
        whoWon = table(1,3);
    % If it's a tie
    elseif isempty(find(table == 0,1))
        whoWon = 3;
    else
        whoWon = 0;
    end
end