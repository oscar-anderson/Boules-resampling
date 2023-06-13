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
