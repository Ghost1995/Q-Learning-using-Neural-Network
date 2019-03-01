function [ N ] = trainTicTacToe( Q )
% To learn the weights of RBF for the tic tac toe
% Agent learns to play the game twice. Once when the human plays first and
% other when the robot plays first.
% X is the robot agent, O is the human player (for simulation it is another agent)
% s - states - Total number of possible states = 3^9 (0 - vacant, 1 - X, -1 - O)
% A - action - Add a X to one of the empty states to reach another state

    N = cell(2,1);
    for player=1:2
        actionMatrix = findActions(player);
        trueActions = any(actionMatrix,2);
        Table = zeros(3^9,9);
        maxQ = zeros(3^9,1);
        for state = 1:3^9
            if trueActions(state)
                Table(state,:) = state2table(state);
                maxQ(state) = epsilonGreedyPolicy(Q(state,:,player),actionMatrix(state,:),0.1);
            end
        end
        net = newrbe([Table(trueActions,:)';actionMatrix(trueActions,:)'],maxQ(trueActions)');
        N{player} = net;
    end
end