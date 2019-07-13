clear;

lambda = 1.03293;

%%% PICO [1]: 25.33°
% tthsim = 24.444955; % gamma (beta') ?[1] 00L 62.1025°

%%% PICO [2]: 29.32°
% tthsim = 29.320944; % alpha ?[2] 01L 30.1622°

% tthsim = 29.631912; % beta ?[2] 00L 39.1618°

%%% PICO [3]: 41.95°
% tthsim = 42.043096; % alpha ?[3] 01L 40.7066°

%%% PICO [4]: 67.02°
% tthsim = 66.926672; % alpha ?[4] 01L 31.1785°
% tthsim = 66.849784; % beta ?[4] 10L 23.4475°
% tthsim = 66.990609; % beta ?[4] 00L 44.1264°
% tthsim = 66.772941; % beta ?[4] 10L 73.059°
% tthsim = 64.959499; % beta ?[4] 00L 68.3623°

tthsim = 66.957925; % Personalizado

tthexp1 = 25.33; tthexp2 = 29.32; tthexp3 = 41.95; tthexp4 = 67.02;
tthexp = tthexp4;

distexp = lambda/(2*sin((tthexp*(pi/180))/2));
distsim = lambda/(2*sin((tthsim*(pi/180))/2));
str = ((distexp-distsim)/distsim)*100;

fprintf('- Strain - \nfor tthsim = %g° \n    str = %g \n\n',tthsim,str);
