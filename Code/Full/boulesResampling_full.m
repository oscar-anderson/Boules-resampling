%% Boules games simulation and resampling test.

% This series of functions simulates a number of games of Boules between
% two players of different skill levels, then applies a resampling test to
% examine the statistical significance of the observed difference between
% the players' final scores.

%% Simulate throw of jack.
function JackLoc = throwJack(LawnSize)

% This function simulates the throw of a jack, aiming for the centre of the
% lawn (as in a real game of Boules), by randomly generating x and y
% coordinate values from a truncated Gaussian distribution. The
% TruncatedGaussian() function centres the distribution around zero, so the
% midpoint of the lawn is adjusted before and after the function call.

% Input:
%   LawnSize = a struct containing four fields, each corresponding to the
%   coordinates of the lower left, upper left, lower right and upper right
%   corners of the space within which the jack and balls will be thrown.

% Output:
%   JackLoc = a struct containing two fields, representing the x and y
%   coordinates of the jack's location on the lawn, after being thrown.

% Find centre of input lawn.
xLawnMid = (LawnSize.xUpperRight + LawnSize.xLowerLeft)/2;
yLawnMid = (LawnSize.yUpperRight + LawnSize.yLowerLeft)/2;

% Orient lawn around zero, prior to TruncatedGaussian call.
xRange = [(LawnSize.xUpperRight - xLawnMid), (LawnSize.xLowerLeft - xLawnMid)];
yRange = [(LawnSize.yUpperRight - yLawnMid), (LawnSize.yLowerLeft - yLawnMid)];

% Simulate throw of jack, aiming for centre of lawn, then reorient to
% original coordinates.
JackLoc.x = TruncatedGaussian(1, xRange) + xLawnMid;
JackLoc.y = TruncatedGaussian(1, yRange) + yLawnMid;

end

%% Simulate throw of ball.
function ballLoc = throwBall(sigma, LawnSize)

% This function simulates the throw of a player's ball, aiming for the
% centre of the lawn (where the jack is aimed to land), by randomly
% generating x and y coordinate values from a truncated Gaussian
% distribution. The TruncatedGaussian() function centres the distribution
% around zero, so the midpoint of the lawn is adjusted before and after
% function call.

% Inputs:
%   Sigma = the variance in a player's throw, around where they are aiming.
%   LawnSize = a struct of four coordinates, defining the throwing space.

% Define player's target as centre of lawn.
AimLoc.x = (LawnSize.xUpperRight + LawnSize.xLowerLeft)/2;
AimLoc.y = (LawnSize.yUpperRight + LawnSize.yLowerLeft)/2;

% Orient lawn around zero, prior to TruncatedGaussian call.
xRange = [(LawnSize.xUpperRight - AimLoc.x), (LawnSize.xLowerLeft - AimLoc.x)];
yRange = [(LawnSize.yUpperRight - AimLoc.y), (LawnSize.yLowerLeft - AimLoc.y)];

% Simulate throw of ball towards centre of lawn, then reorient to original coordinates.
ballLoc.x = TruncatedGaussian(sigma, xRange) + AimLoc.x;
ballLoc.y = TruncatedGaussian(sigma, yRange) + AimLoc.y;

end

%% Calculate distance between jack and player's ball.
function [distance] = calcDistance(JackLoc, PlayerLoc)

% This function calculates the distance between the simulated player's
% thrown ball and the virtually-thrown jack, using the Euclidean distance
% formula.

% Inputs:
%     JackLoc: location of the jack.
%     PlayerLoc:  locations of player's ball.

% Output:
%     distance = distance between player's ball and jack, on lawn.

% Calculate distance between player's ball and jack.
distance = sqrt((JackLoc.x - [PlayerLoc(:).x]).^2 + (JackLoc.y - [PlayerLoc(:).y]).^2);

end

%% Calculate game score.
function score = calcMatLabScore(JackLoc, Player1Loc, Player2Loc)

% This function calculates the final score from one game of Boules by first
% calculating the distances between the jack and each player's ball using
% the calcDistance function. Points awarded to the winning player are 
% calculated as the difference between the worst and best player's scores,
% and stored in the score array.

% Inputs:
%     JackLoc: location of the jack (determined by throwJack() function).
%     Player1Loc, Player2Loc: locations of all balls of the two players
%     (determined by throwBall() function calls).

% Output:
%   score = 2D vector containing the players' scores for each game.

% Calculate distances between jack and each player's balls.
dist1 = calcDistance(JackLoc, Player1Loc);
dist2 = calcDistance(JackLoc, Player2Loc);

% Find smallest distance for each player.
minDist1 = min(dist1);
minDist2 = min(dist2);

% Identify player with closest ball to the jack.
[~, bestPlayer] = min([minDist1, minDist2]);

% Initialise score array.
score = zeros(1,2);

% Determine winning player and store players' ball distances.
if bestPlayer == 1
    bestPlayerDis = dist1;
    worstPlayerMinDist = minDist2;
else
    bestPlayerDis = dist2;
    worstPlayerMinDist = minDist1; 
end

% Award points to winning player within score array.
score(bestPlayer) = sum(worstPlayerMinDist - bestPlayerDis);
end

%% Simulate ball throw of moderately-skilled player.
function Loc = throwStandardPlayer(JackLoc, LawnSize)

% This function utilises the previously-defined throwBall() function to
% simulate the throw of a moderately-skilled (standard) Boules player.
% The player's skill level is operationalised by the sigma input to the 
% truncated Gaussian, used by throwBall() to simulate the aim of the throw.
% In this case, the sigma/standard aim is defined as a standard deviation
% of 1.

% Inputs:
%    JackLoc = location coordinates of the jack, within the lawn.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%     Loc = location of standard player's ball.

% Call throwBall with sigma of 1 to simulate throw with standard aiming ability.
Loc = throwBall(JackLoc, 1, LawnSize);

end

%% Simulate ball throw of poorly-skilled player.
function Loc = throwBadPlayer(JackLoc, LawnSize)

% This function utilises the previously-defined throwBall() function to
% simulate the throw of a poorly-skilled (bad) Boules player.
% The player's skill level is operationalised by the sigma input to the 
% truncated Gaussian, used by throwBall() to simulate the aim of the throw.
% In this case, the sigma/standard aim is defined as a standard deviation
% of 1.5.

% Inputs:
%    JackLoc = location coordinates of the jack, within the lawn.
%    LawnSize = area within which the jack and players' balls are thrown.

% Output:
%     Loc = location of bad player's ball.

% Call throwBall with sigma of 1.5 to simulate throw with bad aiming ability.
Loc = throwBall(JackLoc, 1.5, LawnSize);

end

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

% Generate sampling distribution of games between standard players.
dist = genSamplingDist(nGame, nBalls, LawnSize);

% Compare observed bad vs standard score difference with sampling
% distribution to determine significance of observed difference.

% Calculate proportion of score differences in standard vs. standard 
% sampling distribution greater than observed difference, to determine
% significance of observed standard vs. bad score difference.
pValue = (sum(dist > testStats)/1000);

end

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
