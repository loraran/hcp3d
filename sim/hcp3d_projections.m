function [fmg,sepDist,clatt,atomproj1,atomproj2] = hcp3d_projections(fmg,sepDist,clatt,atomlist)

% (1 0 0) Projection - Rotation of crystal matrix
theta1 = 90; fprintf('  (1 0 0) phi [90°]= %g \n',theta1); % use when pre-defined
% theta1 = input('  (1 0 0) phi [90°]= ');
thetarad1 = theta1*(pi/180);
% Rotation around Z-axis
X1 = atomlist(:,1)*cos(thetarad1) - atomlist(:,2)*sin(thetarad1);
Y1 = atomlist(:,1)*sin(thetarad1) + atomlist(:,2)*cos(thetarad1);
Z1 = atomlist(:,3);
atomproj1 = [X1 Y1 Z1 atomlist(:,4)];

% (1 1 0) Projection - Rotation of crystal matrix
theta2 = 60; fprintf('  (1 1 0) phi [60°]= %g \n',theta2); % use when pre-defined  % 60
% theta2 = input('  (1 1 0) phi [60°]= ');
thetarad2 = theta2*(pi/180);
% Rotation around Z-axis
X2 = atomlist(:,1)*cos(thetarad2) - atomlist(:,2)*sin(thetarad2);
Y2 = atomlist(:,1)*sin(thetarad2) + atomlist(:,2)*cos(thetarad2);
Z2 = atomlist(:,3);
atomproj2 = [X2 Y2 Z2 atomlist(:,4)];

save 'mgcrystal_proj.mat' fmg sepDist clatt atomlist atomproj1 atomproj2; % Saves data from 1st and 2nd projections on disc.

%%% VISUALIZATION ONLY
visu = input('View projections? [y/n]: ','s');
while visu ~= 'y' && visu ~= 'n'
    visu = input('View projections? [y/n]: ','s');
end;
if visu == 'y'
    figure;
    subplot(1,3,1);
    scatter3(atomlist(:,1),atomlist(:,2),atomlist(:,3),15,[0.4 0.4 0.4],'filled');
    xlabel('x'); ylabel('y'); zlabel('z');
    title('HCP Lattice [atomlist]');
    axis equal;
    
    subplot(1,3,2);
    scatter3(atomproj1(:,1),atomproj1(:,2),atomproj1(:,3),15,[0 0 1],'filled');
    xlabel('x'); ylabel('y'); zlabel('z');
    title('(1 0 0) Projection [atomproj1]');
    axis equal;
    view(90,0);
    
    subplot(1,3,3);
    scatter3(atomproj2(:,1),atomproj2(:,2),atomproj2(:,3),15,[0 1 0.5],'filled');
    xlabel('x'); ylabel('y'); zlabel('z');
    title('(1 1 0) Projection [atomproj2]');
    axis equal;
    view(90,0);
else
end;
