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
