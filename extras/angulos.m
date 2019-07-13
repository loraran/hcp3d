z = -0.07124

%     P = [ -0.8002 -6.171e-16 0 ; -0.2667 -0.308 z ; 0.8002 -0.308 z ]; % verde (alpha) REDE ANTIGA SEP/2018
    P = [ 0.8002 1.73e-016 0 ; -0.2667 -0.616 z ; 0.2667 -0.924 z ]; % vermelho (beta)
% % %     P = [ -0.308 0.8002 16 ; -0.308 0.8002 15 ; z -0.2667 16 ]; % azul (gamma-X)
%     P = [ -0.308 0.8002 0 ;  0.308 -0.2667 0 ; 0.308 0 z ]; % roxo (gamma-Z)

    % Find plane equation : ax + by + cz + d = 0
    D = det(P);
    A = P; A(:,1) = 1; dA = det(A);
    B = P; B(:,2) = 1; dB = det(B);
    C = P; C(:,3) = 1; dC = det(C);
    d = 1;
    a = ((-1)*d/D)*dA;
    b = ((-1)*d/D)*dB;
    c = ((-1)*d/D)*dC;
    fprintf('\nPlane equation: ax + by + cz + d = 0 \n  %gx + %gy + %gz + %g = 0   (det = %g)\n',a,b,c,d,D);

    normP = [a b c];
    modP = sqrt((a^2)+(b^2)+(c^2));
    angle = acos(c/modP); % Change between a/c when simulating configs. alpha (c) or gamma-X (a)
    theta = (pi/2)-(angle); %radians
    inclangle = -theta*(180/pi); %degrees
%     inclangle = -inclangle-90-90; % ONLY USE WHEN EVALUATING gamma!

    fprintf('  z = %g ; angle = %g \n',z,inclangle);
