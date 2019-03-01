function Table = state2table( state )
% Find tic tac toe table for a particular state
% Table is a column matrix instead of a 3x3 matrix

    Table = zeros(1,9);
    TablePowers = [3^0,3^1,3^2,3^3,3^4,3^5,3^6,3^7,3^8];
    state = state - 1;
    for i=9:-1:1
        if state >= TablePowers(i)
            Table(i) = floor(state/TablePowers(i));
            if Table(i) == 2
                Table(i) = -1;
            end
            state = mod(state,TablePowers(i));
        end
    end
end