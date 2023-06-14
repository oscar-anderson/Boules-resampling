%% Perform resampling test of difference between player scores.
function [pValue, testStats, dist] = testBadPlayer(nGame, nBalls, LawnSize)

% This function runs a game of Boules between a bad and a standard player,
% generates a sampling distribution of score differences from 1000 sessions
% of games between two standard players, then determines whether the
% observed score difference is significantly different to those established
% from standard vs. standard games, to establish whether the bad player's
% ability is indeed significantly worse than a standard player's.

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

% Generate sampling distribution of games between standard players.
dist = genSamplingDist(nGame, nBalls, LawnSize);

% Compare observed bad vs standard score difference with sampling
% distribution to determine significance of observed difference.

% Calculate proportion of score differences in standard vs. standard 
% sampling distribution greater than observed difference, to determine
% significance of observed standard vs. bad score difference.
pValue = (sum(dist > testStats)/1000);

end
