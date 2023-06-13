%% Simulate Boules games between one poorly and one moderately-skilled player.

function badVsStandardScore = playBadvStandard(nGame, nBalls, LawnSize)

% This function uses the previously defined throwStandardPlayer() and
% throwBadPlayer() functions to simulate an input number of Boules games
% between one poorly-skilled (bad) and one moderately-skilled (standard)
% player, outputting the final scores of all games in an array.

% Inputs:
%    nGame = number of games to be played.
%    nBalls = number of balls to be thrown, per game.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%    badVsStandardScore = 2D array containing final scores of each player
%    from all games.

% For the input number of games:
for iGames = 1:nGame
    % The jack is thrown.
    JackLoc = throwJack(LawnSize);
    % Players then take turns until input number of balls are thrown.
    for iBalls = 1:nBalls
        Player1Loc = throwBadPlayer(JackLoc, LawnSize);
        Player2Loc = throwStandardPlayer(JackLoc, LawnSize);
        % Once all balls are thrown, final game score is calculated.
        badVsStandardScore = calcMatLabScore(JackLoc, Player1Loc, Player2Loc);
    end
end

end
