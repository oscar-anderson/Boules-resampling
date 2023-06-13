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
