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