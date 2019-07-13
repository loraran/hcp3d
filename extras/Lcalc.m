clear;

lambda = 1.03293;
sepDist = 3.2094; clatt = 5.2108;

%%% PICO [1]: 25.33°
% hLoc = 0; kLoc = 0; tth = 24.444955; % gamma (beta') ?[1] 00L 62.1025°

%%% PICO [2]: 29.32°
% hLoc = 0; kLoc = 1; tth = 29.320944; % alpha ?[2] 01L 30.1622°
% hLoc = 0; kLoc = 1; tth = 29.58; % alpha ?[2] 01L 39.0257°
% hLoc = 0; kLoc = 0; tth = 29.631912; % beta ?[2] 00L 39.1618°

%%% PICO [3]: 41.95°
% hLoc = 0; kLoc = 1; tth = 42.043096; % alpha ?[3] 01L 40.7066°

%%% PICO [4]: 67.02°
% hLoc = 0; kLoc = 1; tth = 66.926672; % alpha ?[4] 01L 31.1785°
% hLoc = 1; kLoc = 0; tth = 66.849784; % beta ?[4] 10L 23.4475°
% hLoc = 0; kLoc = 0; tth = 66.990609; % beta ?[4] 00L 44.1264°
% hLoc = 1; kLoc = 0; tth = 66.772941; % beta ?[4] 10L 73.059°

%%% Reinjecting 2th
tthrad = tth*(pi/180);
lLoc = sqrt((4*(clatt^2))*(((sin(tthrad/2)^2)/(lambda^2))-((hLoc^2 + (hLoc*kLoc) + kLoc^2)/(sepDist^2))/3));
fprintf('for tth = %g° \n    lLoc = %g \n\n',tth,lLoc);
