clear;

path = strcat('C:/Users/Loren/Desktop/hcp3d_plots/',datestr(clock,'dd-mmm-yyyy HH.MM.SS')); mkdir(path);
disp(datestr(clock,'dd-mmm-yyyy HH.MM.SS'));

% Execute hcp3d_lattice.m - Setting up a 3D matrix
fprintf('\n'); disp('- HCP LATTICE -'); disp('Define the crystal lattice size.');
nParticles = input('  nPart = ');
fprintf('  wait ...\n');
hcp3d_lattice(nParticles);
load mgcrystal_perf.mat;

% Execute hcp3d_projections.m - Generate and save matrix projections
fprintf('Enter information on plane projections.\n');
hcp3d_projections(fmg,sepDist,clatt,atomlist);
load mgcrystal_proj.mat;

% % %     %%% Highlight Planes
% % %     % Limiting atomlist size in Z
% % %     trunc = [];
% % %     cont = 0;
% % %     for t = 1:numel(atomlist(:,3))
% % %         if (atomlist(t,3) > -1.5 && (atomlist(t,3) < 0.5))
% % %             cont = cont + 1;
% % %             trunc(cont,:) = atomlist(t,:); %#ok<COLND,AGROW>
% % %         end;
% % %     end;
% % %     atomlist = trunc;
% % %     % Limiting atomproj1 size in Z
% % %     trunc = [];
% % %     cont = 0;
% % %     for t = 1:numel(atomproj1(:,3))
% % %         if (atomproj1(t,3) > -1.5 && (atomproj1(t,3) < 0.5))
% % %             cont = cont + 1;
% % %             trunc(cont,:) = atomproj1(t,:); %#ok<COLND,AGROW>
% % %         end;
% % %     end;
% % %     atomproj1 = trunc;
% % %     step = -1;
% % %     % beta - [ 0.8002 1.73e-016 0 ; -0.2667 -0.616 step ; 0.2667 -0.924 step ]
% % %     figure; scatter3(atomproj1(:,1),atomproj1(:,2),atomproj1(:,3),25,[0.4 0.4 0.4],'filled'); axis equal;
% % %     xlabel('x'); ylabel('y'); zlabel('z'); view(42,24); % view(0,88);
% % %     patch('XData',[0.8002 0.2667 -0.2667 0.2667],'YData',[1.73e-016 -0.924 -0.616 0.308],'ZData',[0 step step 0],'LineStyle','none','FaceColor','r','FaceAlpha',0.80);
% % %     % gamma (beta') - [ -0.308 0.8002 0 ;  0.308 -0.2667 0 ; 0.308 0 step ]
% % %     figure; scatter3(atomlist(:,1),atomlist(:,2),atomlist(:,3),25,[0.4 0.4 0.4],'filled'); axis equal;
% % %     xlabel('x'); ylabel('y'); zlabel('z'); view(-48,24); % view(-90,88);
% % %     patch('XData',[-0.308 0.308 0.308 -0.308],'YData',[0.8002 -0.2667
% % %     -0.2667 0.8002],'ZData',[0 0 step step],'LineStyle','none','FaceColor','b','FaceAlpha',0.80);
% % %     break

time = 0; % Zstep for alpha/beta/gamma-Z planes; equivalent to Xstep for gamma-X plane
for step = -0.75
    if step == 0
        step = -1e-007; %#ok<FXSET>
    end;
    coordstep = step;
    tic;
% Execute hcp3d_progcut.m - Progressively cut, perform rotations on the matrix and obtain its diffraction pattern
hcp3d_progcut(fmg,sepDist,clatt,atomproj1,atomproj2,path,coordstep);
% hcp3d_progcut_beta(fmg,sepDist,clatt,atomproj1,atomproj2,path,coordstep);
% hcp3d_progcut_gammaZ(fmg,sepDist,clatt,atomproj1,atomproj2,path,coordstep);
    time = time + toc;
end;
fprintf('- END - Total elapsed time is %g seconds.\n',time);

disp('____________________________________________________________________________');