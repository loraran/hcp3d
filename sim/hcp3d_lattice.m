function [fmg,sepDist,clatt,atomlist] = hcp3d_lattice(nParticles)
tic;
fmg = 12;
% Make sure nPart is a perfect square
nPart = nParticles^2;  % number of particles
intRoot = floor(sqrt(nPart));
if (sqrt(nPart) - intRoot) > 1e-7
     % Display an error message
     disp('Number of particles should be a perfect square.');
     coords = zeros(2,nPart); %#ok<NASGU>
     Lx = 0.0; %#ok<NASGU>
     Ly = 0.0; %#ok<NASGU>
     return 
end;

% Lattice parameters (separation length between atoms)
% Q = 2.895; % matches H0L simulations for gamma planes (NOT H1L)
Q = 5.21; % matches simulations for alpha/beta planes
% Q = 1;
sepDist = 3.2094/Q; %%% In-plane lattice parameters - a, b
clatt = 5.2108; % 1.6236*sepDist; %%% Out-of-plane lattice parameter - c

% Find the box size
Lx = sepDist * 1 * sqrt(nPart);
Ly = Lx*sqrt(3)/2; %#ok<NASGU>
Natomsc = nPart;

% Create a vector of linearly spaced points along the x-direction
% linspace(a,b,n) generates row vector of n points lin. spaced bet. a and b
xPos = linspace(sepDist/2, Lx-sepDist/2, 1 * sqrt(nPart)) - Lx/2;
% And find the corresponding y-direction increments
yPos = (sqrt(3)/2)*xPos;

% Create a matrix with all combinations of x and y
[X,Y] = meshgrid(xPos,yPos);
% Shift coordinates to the be at the center of each particle
X(1:2:end,:) = X(1:2:end,:) + sepDist/2;
maxZ = max(size(X));
Z = zeros(maxZ,maxZ) - nPart/4;

% Reshape the matrix to be 1D in X and 1D in Y
% (numel returns the number of elements in a given array)
coords = [reshape(X,1,numel(X)); reshape(Y,1,numel(Y))]; %#ok<NASGU>
X2 = X;
Y2 = Y + 0.5*sepDist;
Z2 = Z + 0.5;
% Z2 = Z + clatt/2;
%  plot3(X,Y,Z,'k.'); hold on;
%  plot3(X2,Y2,Z2,'r.'); hold off;
%  pause

% Setting up a three-dimensional matrix
natoms = numel(X);
atoms = zeros(1,1); % pre-allocating
hcpcor = zeros(1,1); % pre-allocating
for f = 1:natoms;
    atoms(f,1) = X(f);
    atoms(f,2) = Y(f);
    atoms(f,3) = Z(f);
    atoms(f+natoms,1) = X2(f);
    atoms(f+natoms,2) = Y2(f);
    atoms(f+natoms,3) = Z2(f);
     hcpcor(f,1) = 0; % Defining colormap to differentiate layers
     hcpcor(f+natoms,1) = 1; % Defining colormap to differentiate layers
end;
for g = 2:2:(1*Natomsc)
    for f = 1:natoms;
        atoms(f+natoms*g,1) = X(f);
        atoms(f+natoms*g,2) = Y(f);
        atoms(f+natoms*g,3) = Z(f) + g*0.5;
        atoms(f+natoms*(g+1),1) = X2(f);
        atoms(f+natoms*(g+1),2) = Y2(f);
        atoms(f+natoms*(g+1),3) = Z2(f) + g*0.5;
         hcpcor(f+natoms*g,1) = 0; % Defining colormap to differentiate layers
         hcpcor(f+natoms*(g+1),1) = 1; % Defining colormap to differentiate layers
    end;
end;
%  figure;
%  hcpmap = [0 0 0; 1 0 0]; % defining colormap
%  colormap(hcpmap)
%  scatter3(atoms(:,1),atoms(:,2),atoms(:,3),3,hcpcor(:),'filled');
%  xlabel('x'); ylabel('y'); zlabel('z');

% Limiting integration of atoms to a spherical domain
limitsphere = intRoot - 0; % side of matrix: intRoot, line 6
maxradsphere = (sqrt(2))*(floor(limitsphere));
maxnatoms = numel(atoms(:,1));
cont = 0;
S = zeros(1,1); fmglocal = zeros(1,1); fmgreal = zeros(1,1);
for i = 1:maxnatoms
    if ((atoms(i,1)^2)+(atoms(i,2)^2)+(atoms(i,3)^2)) <= maxradsphere^2
        S(i) = 25; % for visualization only
        fmglocal(i) = fmg;
        cont = cont + 1;
        fmgreal(cont)= fmg;
    else
        S(i) = 1; % for visualization only
        fmglocal(i) = 0;
    end;
end;
atoms(:,4) = fmglocal(:);
%  figure;
%  scatter3(atoms(:,1),atoms(:,2),atoms(:,3),S(:),'filled'); % for visualization only
%  axis equal;

% Eliminating useless portions of the matrix (fmglocal = 0)
cont = 0;
for i = 1:numel(atoms(:,4))
    if atoms(i,4) == 12
        cont = cont + 1;
        atomes(cont,:) = atoms(i,:); %#ok<AGROW>
    end;
end;
maxnatoms = numel(atomes(:,1)); %#ok<NASGU>
%  figure;
%  scatter3(atomes(:,1),atomes(:,2),atomes(:,3),25,'filled'); % for visualization only
%  axis equal;
 
atomlist = atomes;
save 'mgcrystal_perf.mat' fmg sepDist clatt atomlist; % Saves data from the perfect crystal on disc.
toc
beep
