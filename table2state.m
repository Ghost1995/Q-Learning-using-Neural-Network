function state = table2state( Table )
% this function converts the table into state

    TablePowers = [3^0;3^1;3^2;3^3;3^4;3^5;3^6;3^7;3^8];
    Table(Table == -1) = 2;
    state = (reshape(Table,[1,9]) * TablePowers) + 1; 
end

