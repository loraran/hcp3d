function [fmg,sepDist,clatt,atomproj1,atomproj2] = hcp3d_stack_abc(fmg,sepDist,clatt,nParticles,atomlist)

% % % Limiting matrix size in Z
% % trunc = [];
% % cont = 0;
% % for t = 1:numel(atomlist(:,3))
% %     if (atomlist(t,3) > -1 && (atomlist(t,3) < 1))
% %         cont = cont + 1;
% %         trunc(cont,:) = atomlist(t,:); %#ok<COLND,AGROW>
% %     end;
% % end;
% % atomlist = trunc;
% % figure; scatter3(atomlist(:,1),atomlist(:,2),atomlist(:,3),25,[1 0 0],'filled'); axis equal; view(90,0);
% % pause

% if nParticles == 12 || nParticles == 18
%     limit = 0;
% elseif nParticles == 15
%     limit = -0.25;
% else
% end;

% Eliminating atomic layer where (z = limit) in atomproj1
stackatomlist = [];
cont = 0;
for i = 1:numel(atomlist(:,3))
    if atomlist(i,3) > limit
        cont = cont + 1;
        stackatomlist(cont,:) = atomlist(i,:); %#ok<COLND,AGROW>
    end;
end;
atomproj1 = stackatomlist;

% Eliminating atomic layer where (z = limit) in atomproj2
stackatomlist = [];
cont = 0;
for i = 1:numel(atomlist(:,3))
    if atomlist(i,3) < limit
        cont = cont + 1;
        stackatomlist(cont,:) = atomlist(i,:); %#ok<COLND,AGROW>
    end;
end;
atomproj2 = stackatomlist;
% Pushing atomproj2 to (z = 0) position
atomproj2(:,3) = atomproj2(:,3) + 0.5;

% save 'mgcrystal_stackfault.mat' fmg sepDist clatt atomlist atomproj1 atomproj2; % Saves data from 1st and 2nd projections on disc.

%%% VISUALIZATION ONLY - START
visu = input('View projections? [y/n]: ','s');
while visu ~= 'y' && visu ~= 'n'
    visu = input('View projections? [y/n]: ','s');
end;
if visu == 'y'
%     figure;
%     subplot(1,2,1);
%     scatter3(atomproj1(:,1),atomproj1(:,2),atomproj1(:,3),15,[0 0 1],'filled');
%     xlabel('x'); ylabel('y'); zlabel('z');
%     title('HCP Lattice [atomproj1] (No Rotation)','FontWeight','bold');
%     axis equal;
%     view(90,0);
%     
%     subplot(1,2,2);
%     scatter3(atomproj2(:,1),atomproj2(:,2),atomproj2(:,3),15,[0 0 0.5],'filled');
%     xlabel('x'); ylabel('y'); zlabel('z');
%     title('HCP Lattice [atomproj2] (No Rotation)','FontWeight','bold');
%     axis equal;
%     view(90,0);
    
    figure;
    scatter3(atomproj1(:,1),atomproj1(:,2),atomproj1(:,3),15,[0 0 1],'filled'); hold on;
    scatter3(atomproj2(:,1),atomproj2(:,2),atomproj2(:,3),15,[0 0 0.5],'filled'); hold off;
    title('HCP Lattice [atomproj1+atomporj2] (No Rotation)','FontWeight','bold');
    axis equal;
    view(90,0);
else
end;
%%% VISUALIZATION ONLY - END

% Distance between stacking fault layers
dist = 0.5;
delta = input('Enter percentage of compression between stacking fault layers: ');
newc = clatt-(clatt*(delta/100));
fprintf('  Ok! Setting delta to %g percent. (c = %g Å)\n',delta,newc);
walk = (delta/100)*dist; % extra distance to move atomproj2
% Pushing atomproj2 to new position
atomproj2(:,3) = atomproj2(:,3) + walk;

stackingfault = [atomproj1 ; atomproj2];

% Limiting matrix size to -15 < z < 15
trunc = [];
cont = 0;
for t = 1:numel(stackingfault(:,3))
    if (stackingfault(t,3) > -15.5 && (stackingfault(t,3) < 15.5))
        cont = cont + 1;
        trunc(cont,:) = stackingfault(t,:); %#ok<COLND,AGROW>
    end;
end;
stackingfault = trunc;

save 'mgcrystal_stackfault.mat' fmg sepDist clatt atomlist atomproj1 atomproj2 stackingfault; % Saves data from 1st and 2nd projections on disc.