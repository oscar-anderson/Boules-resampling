%% Simulate the games of Boules and run the resampling test.
function [pValue, testStats, dist] = boulesResampling()

% Description:
%     boulesResampling runs all of the functions to simulate the games of
%     Boules and then test for a statistically significant difference
%     between the scores of the 'poorly-skilled' (bad) player and
%     'moderately-skilled' (standard) player.

% Outputs:
%     pValue = the significance of the observed performance difference.
%     testStats = the level of difference between scores observed and
%     those expected under the null hypothesis.
%     dist = histogram presenting the sampling distribution.

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

% Call testBadPlayer function to run the games.
[pValue, testStats, dist] = testBadPlayer(nGame, nBalls, LawnSize);

% Visualise distribution as histogram.
dist = histogram(dist);
xlabel("Score difference")
ylabel("Frequency")

end