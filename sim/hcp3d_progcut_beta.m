function [atomdefect,atomcut1,atomcut2] = hcp3d_progcut_beta(fmg,sepDist,clatt,atomproj1,atomproj2,path,coordstep)

dcutsize = 2;

for z = coordstep
    P = [ 0.8002 1.73e-016 0 ; -0.2667 -0.616 z ; 0.2667 -0.924 z ]; % vermelho (beta)

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
    angle = acos(c/modP);
    theta = (pi/2)-(angle);
    inclangle = -theta*(180/pi);

    fprintf('  z = %g ; angle = %g \n',z,inclangle);

%%% (1 0 0) PROJECTION - START
% Perform cut in bulk crystal (delete atoms in deffect place)
for dp = 1:numel(atomproj1(:,1))
    distcut = abs(a*atomproj1(dp,1)+b*atomproj1(dp,2)+c*atomproj1(dp,3)+d)/sqrt(a^2+b^2+c^2);
    if distcut > dcutsize  % Signs: > gives the remaining of the crystal, < gives the cut-out portion
        atomproj1(dp,4) = 12;
    else
        atomproj1(dp,4) = 0;
    end;
end;

% Eliminating useless portions of the matrix (fmglocal = 0)
cutatomlist = [];
cont = 0;
for i = 1:numel(atomproj1(:,4))
    if atomproj1(i,4) == 12
        cont = cont + 1;
        cutatomlist(cont,:) = atomproj1(i,:); %#ok<COLND,AGROW>
    end;
end;
atomcut1 = cutatomlist;
%%% (1 0 0) PROJECTION - END

% %%% (1 1 0) PROJECTION - START
% % ADAPTING MATRIX FOR BETA PLANES 
% % Rotation around Z-axis
% ang1 = (-60)*(pi/180);
% X = atomproj2(:,1)*cos(ang1) - atomproj2(:,2)*sin(ang1);
% Y = atomproj2(:,2)*cos(ang1) + atomproj2(:,1)*sin(ang1);
% Z = atomproj2(:,3);
% atomproj2 = [X Y Z atomproj2(:,4)];
% % ADAPTING MATRIX FOR BETA PLANES 

% Rotation around Y-axis
inclanglerad = (-inclangle)*(pi/180);
X = atomproj2(:,1)*cos(inclanglerad) + atomproj2(:,3)*sin(inclanglerad);
Y = atomproj2(:,2);
Z = atomproj2(:,3)*cos(inclanglerad) - atomproj2(:,1)*sin(inclanglerad);
atomproj2 = [X Y Z atomproj2(:,4)];

% % ADAPTING MATRIX FOR BETA PLANES 
% % Counter-rotation around Z-axis
% ang2 = (60)*(pi/180);
% X = atomproj2(:,1)*cos(ang2) - atomproj2(:,2)*sin(ang2);
% Y = atomproj2(:,2)*cos(ang2) + atomproj2(:,1)*sin(ang2);
% Z = atomproj2(:,3);
% atomproj2 = [X Y Z atomproj2(:,4)];
% % ADAPTING MATRIX FOR BETA PLANES

% Perform cut in bulk crystal (delete atoms in deffect place)
for dp = 1:numel(atomproj2(:,1))
    distcut = abs(a*atomproj2(dp,1)+b*atomproj2(dp,2)+c*atomproj2(dp,3)+d)/sqrt(a^2+b^2+c^2);
    if distcut < dcutsize  % Signs: > gives the remaining of the crystal, < gives the cut-out portion
        atomproj2(dp,4) = 12;
    else
        atomproj2(dp,4) = 0;
    end;
end;

% Eliminating useless portions of the matrix (fmglocal = 0)
cutatomlist = [];
cont = 0;
for i = 1:numel(atomproj2(:,4))
    if atomproj2(i,4) == 12
        cont = cont + 1;
        cutatomlist(cont,:) = atomproj2(i,:); %#ok<COLND,AGROW>
    end;
end;
atomcut2 = cutatomlist;
%%% (1 1 0) PROJECTION - END

figure;
scatter3(atomcut1(:,1),atomcut1(:,2),atomcut1(:,3),15,[0 0 1],'filled');
axis equal;
hold on;
scatter3(atomcut2(:,1),atomcut2(:,2),atomcut2(:,3),15,[0 0 1],'filled');
hold off;
xlabel('x'); ylabel('y'); zlabel('z');
axis equal;
view(60,0)
% break

atomdefect = [atomcut1 ; atomcut2];
% save 'mgcrystal_defect.mat' atomdefect atomcut1 atomcut2;

save 'mgcrystal_pov.mat' atomcut1 atomcut2;
save 'mgcrystal_defect.mat' atomdefect;
% break

atomcalc = atomdefect; atomname = 'atomdefect';
hcp3d_fft(fmg,sepDist,clatt,inclangle,atomname,atomcalc,path,coordstep);

end;
