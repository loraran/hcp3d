clear; tic;

% path = strcat('C:/Users/Loren/Desktop/hcp3d_plots/stacking_fault/',datestr(clock,'dd-mmm-yyyy HH.MM.SS')); mkdir(path);
disp(datestr(clock,'dd-mmm-yyyy HH.MM.SS'));

% Execute hcp3d_lattice.m - Setting up a 3D matrix
fprintf('\n'); disp('- HCP LATTICE -'); disp('Define the crystal lattice size.');
nParticles = input('  nPart = ');
fprintf('  wait ...\n');
hcp3d_lattice(nParticles);
load mgcrystal_perf.mat;
break % Use this to verify the bulk matrix (atomlist).

path = strcat('C:/Users/Loren/Desktop/hcp3d_plots/stacking_fault/',datestr(clock,'dd-mmm-yyyy HH.MM.SS'),' - nPart ',num2str(nParticles)); mkdir(path);

% Execute hcp3d_projections.m - Generate and save matrix projections
hcp3d_stack_abb(fmg,sepDist,clatt,nParticles,atomlist);
% hcp3d_stack_abc(fmg,sepDist,clatt,nParticles,atomlist);
load mgcrystal_stackfault.mat;
% break % Use this to verify the stacking fault matrix (stackingfault).

atomcalc = stackingfault; atomname = 'stackingfault';
inclangle = 0; coordstep = 0;
hcp3d_fft(fmg,sepDist,clatt,inclangle,atomname,atomcalc,path,coordstep);
fprintf('- END - Total elapsed time is %g seconds.\n',toc);

disp('____________________________________________________________________________');