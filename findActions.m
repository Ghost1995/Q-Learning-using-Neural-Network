function actionMatrix = findActions( player )
% It is a matrix of order 3^9 x 9 as for each state there are atmost 9
% actions possible. i.e 1 each for each empty state(depending on whether the
% next action for that state is X or O) with maximum of 9 empty states

% For each state in the actionMatrix we store the row of possible actions.
% If the action = 0 means that that state is unattainable

    actionMatrix = zeros(3^9,9);
    for state = 1:3^9
        % get the table from state
        Table = state2table(state);
        % determine the number of zeros and cross in the game
        num_zeros = length(find(Table == -1));
        num_cross = length(find(Table == 1));
        % playable moves per state
        if player == 1
            % assuming robot is always X and goes second
            if num_cross == num_zeros
                actionMatrix(state,Table == 0) = -1;
            elseif  num_zeros - num_cross == 1
                actionMatrix(state,Table == 0) = 1;
            end
        elseif player == 2
            % assuming robot is always X and goes first
            if num_cross == num_zeros
                actionMatrix(state,Table == 0) = 1;
            elseif  num_cross - num_zeros == 1
                actionMatrix(state,Table == 0) = -1;
            end
        end
    end
end