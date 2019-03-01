function tictactoe( N )
    % Setup the figure/windows for the game
    figure('Name','Tic Tac Toe');
    score = zeros(1,3);
    % run the game till user wants to play
    endGame = false;
    while ~endGame
        % Setup the game
        plot(-1. -1)
        axis([0 3 0 3])
        set(gca,'xTick',0:3)
        set(gca,'yTick',0:3)
        set(gca,'xTickLabel','')
        set(gca,'yTickLabel','')
        grid on
        shg
        % display score
        title(['Player 1 --> ' num2str(score(1)) '                   Draws --> ' num2str(score(2)) '                   Player 2 --> ' num2str(score(3))])
        is_x = randi(2); % Choose the player who goes first (1 - X, 2 - O)
        player = 4 - mod(is_x+1,4);
        if is_x == 1
            xlabel('Player: X (Robot)')
        else
            xlabel('Player: O (Human)')
        end
        
        % define the possible actions for each state (robot player)
        actionMatrix = findActions(player);
        Table = zeros(3,3); % the state of the game (0 none, 1 = X, -1 = O)
        net = N{player};
        whoWon = 0; % is there a winner? is it a tie?
        
        % Game starts here
        while whoWon == 0
            if is_x == 1
                state = table2state(Table);
                positionOfAction = net([reshape(Table,[9,1]);actionMatrix(state,:)']);
                Table(uint64(positionOfAction)) = 1;
                row = floor(positionOfAction/3);
                col = mod(positionOfAction,3);                
                if col < 1
                    col = 3;
                else
                    row = row + 1;
                end
                % Plot X
                hold on
                x = 0:1;
                pos = 0:1;
                neg = 1-x;
                plot(x+col-1, pos+3-row)
                plot(x+col-1, neg+3-row)
                hold off
                % Change Player
                is_x = 2;
                xlabel('Player: O');
            else
                [x, y] = ginput(1); % get the mouse position with respect to the plot
                col = floor(x);
                row = 2 - floor(y);
                if Table(col+1, row+1) % if the player tries to click on a filled spot
                   h = warndlg('Invalid move, please try again');
                   uiwait(h)
                   continue;
                else
                    Table(col+1, row+1) = -1;
                    % Plot O
                    hold on
                    t = 0:0.1:2*pi;
                    x = cos(t)/2+0.5;
                    y = sin(t)/2+0.5;
                    plot(x+col, y+2-row)
                    hold off
                    % Change Player
                    is_x = 1;
                    xlabel('Player: X');
                end
            end
            state = table2state(Table);
            whoWon = findWinner(state);
        end        
        if whoWon == -1 % O won
            h = warndlg('O wins');
            score(3) = score(3) + 1;
            title(['Player 1 --> ' num2str(score(1)) '                   Draws --> ' num2str(score(2)) '                   Player 2 --> ' num2str(score(3))])
            xlabel('');
            uiwait(h)
        elseif whoWon == 1 % X won
            h = warndlg('X wins');
            score(1) = score(1) + 1;
            title(['Player 1 --> ' num2str(score(1)) '                   Draws --> ' num2str(score(2)) '                   Player 2 --> ' num2str(score(3))])
            xlabel('');
            uiwait(h)
        else % else it's a tie
            h = warndlg('Tie');
            score(2) = score(2) + 1;
            title(['Player 1 --> ' num2str(score(1)) '                   Draws --> ' num2str(score(2)) '                   Player 2 --> ' num2str(score(3))])
            xlabel('');
            uiwait(h)
        end
        button = questdlg('Do you want to play another game?','Tic - Tac - Toe','Yes','No','Yes');
        switch button
            case 'No'
                endGame = true;
                close
                disp(['Robot won ' num2str(score(1)) ' matches.']);
                disp(['User won ' num2str(score(3)) ' matches.']);
                disp([num2str(score(2)) ' matches were a Tie.']);
        end
    end
end