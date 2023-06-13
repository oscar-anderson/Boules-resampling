%% Simulate the games of Boules and run the resampling test.
function [pValue, testStats, dist] = boulesResampling()

% This function uses the functions defined above to simulate five games of
% Boules between the two players, throwing 10 balls per game, then run the
% resampling test to examine whether the bad player indeed performs
% significantly worse than the standard player. The sampling distribution
% is visualised as a histogram and is output alongside the test statistic
% and significance of the observed bad vs. standard player score
% difference.

% Outputs:
%     pValue = the significance of the observed score difference.
%     testStats = the observed bad vs. standard score difference.
%     dist = a histogram depicting the standard vs. standard sampling distribution.

% Specify number of games to be played between bad and standard player.
nGame = 5;

% Specify number of balls to be thrown by players, per game.
nBalls = 10;

% Define lawn area within which the jack and players' balls land.
LawnSize.xUpperRight = 20;
LawnSize.yUpperRight = 15;
LawnSize.xLowerLeft = 10;
LawnSize.yLowerLeft = 5;

% Shuffle seed to be used by TruncatedGaussian function's random number generator.
rng('shuffle');

% Call testBadPlayer function to run the games and resampling test.
[pValue, testStats, dist] = testBadPlayer(nGame, nBalls, LawnSize);

% Visualise distribution as histogram.
dist = histogram(dist);
xlabel("Score difference")
ylabel("Frequency")

end
