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
