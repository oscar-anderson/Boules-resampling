%% Generate a sampling distribution of player score differences.
function dist = genSamplingDist(nGame, nBalls, LawnSize)

% This function simulates 1000 sessions of Boules games between two
% standard players to generate a sampling distribution of the final scores
% from each session.

% Inputs:
%    nGame = number of games to be played.
%    nBalls = number of balls to be thrown, per game.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%    dist = sampling distribution of resampled final scores.

% Initialise array to store final scores from all sessions of games.
scoreFromAllGames = zeros(1, nGame);

% For 1000 sessions of games:
for iSession = 1:1000
    % Simulate games and retrieve player scores from all games.
    finalScore = playStandardGames(nGame, nBalls, LawnSize);
    % Store across-game player score difference in array of final session scores.
    scoreFromAllGames(iSession) = finalScore(1) - finalScore(2);
end

% Define sampling distribution as array of final scores from all sessions.
dist = scoreFromAllGames;

end