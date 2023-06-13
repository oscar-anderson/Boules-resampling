%% Simulate Boules games between two moderately-skilled players.

function standardVsStandardScore = playStandardGames(nGame, nBalls, LawnSize)

% This function uses the previously defined throwStandardPlayer() function
% to simulate an input number of Boules games between two moderately-skilled
% (standard) players, outputting the final scores of all games in an array.

% Inputs:
%    nGame = number of games to be played.
%    nBalls = number of balls to be thrown, per game.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%    standardVsStandardScore = 2D array containing final scores of each
%    player from all games.

% For the input number of games:
for iGames = 1:nGame
    % The jack is thrown.
    JackLoc = throwJack(LawnSize);
    % Players then take turns until input number of balls are thrown.
    for iBalls = 1:nBalls
        Player1Loc = throwStandardPlayer(JackLoc, LawnSize);
        Player2Loc = throwStandardPlayer(JackLoc, LawnSize);
        % Once all balls are thrown, final game score is calculated.
        standardVsStandardScore = calcMatLabScore(JackLoc, Player1Loc, Player2Loc);
    end
end

end
