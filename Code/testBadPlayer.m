%% Perform resampling test of difference between player scores.

function [pValue, testStats, dist] = testBadPlayer(nGame, nBalls, LawnSize)

% [pValue, testStats, dist] = testBadPlayer(nGame, nBalls, LawnSize)
% Simulates specified number of games between bad and standard player.

% Inputs:
%    nGame = number of games to be played.
%    nBalls = number of balls to be thrown, per game.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%     pValue = significance level of the observed score differences.
%     testStats = observed across-games player score difference. 
%     dist = histogram presenting sampling distribution of 1000 simulated score differences.

% Get final score from games between bad and standard player.
badVsStandardScore = playBadvStandard(nGame, nBalls, LawnSize);

% Calculate observed score difference between players from games played.
testStats = badVsStandardScore(1) - badVsStandardScore(2);

% Generate sampling distribution from 1000 sessions of simulated games.
dist = genSamplingDist(nGame, nBalls, LawnSize);

% Calculate proportion of across-game score differences greater than
% observed score difference, to give significance of observed difference.
pValue = (sum(dist > testStats)/1000);

end