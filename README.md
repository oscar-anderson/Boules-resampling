# Boules games simulation and resampling test

This series of functions simulates a number of games of Boules between
two players of different skill levels, then applies a resampling test to
examine the statistical significance of the observed difference between
the players' final scores.

## Requirements
- MATLAB 2019a or later.
- TruncatedGaussian() function by Bruno Luong (2023).
  Truncated Gaussian (https://www.mathworks.com/matlabcentral/fileexchange/23832-truncated-gaussian), MATLAB Central File Exchange. Retrieved June 13, 2023.

## Usage
This code consists of 11 functions:
- throwJack() simulates the throw of a jack, aiming for the centre of the
lawn (as in a real game of Boules), by randomly generating x and y
coordinate values from a truncated Gaussian distribution. The
TruncatedGaussian() function centres the distribution around zero, so the
midpoint of the lawn is adjusted before and after the function call.
- throwBall() simulates the throw of a player's ball, aiming for the
centre of the lawn (where the jack is aimed to land), by randomly
generating x and y coordinate values from a truncated Gaussian
distribution. The TruncatedGaussian() function centres the distribution
around zero, so the midpoint of the lawn is adjusted before and after
function call.
- calcDistance() calculates the distance between the simulated player's
thrown ball and the virtually-thrown jack, using the Euclidean distance
formula.
- calcMatLabScore() calculates the final score from one game of Boules by first
calculating the distances between the jack and each player's ball using
the calcDistance function. Points awarded to the winning player are 
calculated as the difference between the worst and best player's scores,
and stored in the score array.
- throwStandardPlayer() utilises the previously-defined throwBall() function to
simulate the throw of a moderately-skilled (standard) Boules player.
The player's skill level is operationalised by the sigma input to the 
truncated Gaussian, used by throwBall() to simulate the aim of the throw.
In this case, the sigma/standard aim is defined as a standard deviation
of 1.
- throwBadPlayer() utilises the previously-defined throwBall() function to
simulate the throw of a poorly-skilled (bad) Boules player.
The player's skill level is operationalised by the sigma input to the 
truncated Gaussian, used by throwBall() to simulate the aim of the throw.
In this case, the sigma/standard aim is defined as a standard deviation
of 1.5.
- standardVsStandardScore() uses the previously defined throwStandardPlayer() function
to simulate an input number of Boules games between two moderately-skilled
(standard) players, outputting the final scores of all games in an array.
- badVsStandardScore() uses the previously defined throwStandardPlayer() and
throwBadPlayer() functions to simulate an input number of Boules games
between one poorly-skilled (bad) and one moderately-skilled (standard)
player, outputting the final scores of all games in an array.
- genSamplingDist() simulates 1000 sessions of Boules games between two
standard players to generate a sampling distribution of the final scores
from each session.
- testBadPlayer() runs a game of Boules between a bad and a standard player,
generates a sampling distribution of score differences from 1000 sessions
of games between two standard players, then determines whether the
observed score difference is significantly different to those established
from standard vs. standard games, to establish whether the bad player's
ability is indeed significantly worse than a standard player's.
- boulesResampling() uses the functions defined above to simulate five games of
Boules between the two players, throwing 10 balls per game, then run the
resampling test to examine whether the bad player indeed performs
significantly worse than the standard player. The sampling distribution
is visualised as a histogram and is output alongside the test statistic
and significance of the observed bad vs. standard player score
difference.

To run the simulation of games and resampling test, simply download
boulesResampling_full.m and run the command:
```
[pValue, testStats, dist] = boulesResampling()
```
This will output the significance of the observed score difference, the observed
bad vs. standard score difference, and a histogram depicting the sampling
distribution of score differences between standard vs. standard player games.
