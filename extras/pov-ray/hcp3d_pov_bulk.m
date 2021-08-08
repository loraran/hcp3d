% % % MODEL = sphere { <-0.44,3.96,1.22>, 0.15 }

% hcp3d_pov EXCLUSIVE FOR FULL BULK EXTRACTION
load mgcrystal_proj.mat; % loads matrices atomlist, atomproj1 (100) and atomproj2 (110)
path = strcat('C:/Users/Loren/Desktop/hcp3d_plots/POV-Ray/bulk - ',datestr(clock,'dd-mmm-yyyy HH.MM.SS')); mkdir(path);

%% HCP3D_POV_BULK FOR ATOMLIST
atompov = [];

cont = 0; % Filtering Z (-5:5) and X (-1:1) for atomlist
for i = 1:numel(atomlist(:,3))
    if atomlist(i,3) >= -5
        if atomlist(i,3) <= 5
            if atomlist(i,1) >= -1
                if atomlist(i,1) <= 1
                    cont = cont + 1;
                    atompov(cont,1) = atomlist(i,1); %#ok<*SAGROW>
                    atompov(cont,2) = atomlist(i,2);
                    atompov(cont,3) = atomlist(i,3);
                end;
            end;
        end;
    end;
end;

% Correction/approximation for values that are too small (< E-7)
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,1)) < 0.0000001
        atompov(j,1) = 0.00000;
    end;
end;
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,2)) < 0.0000001
        atompov(j,2) = 0.00000;
    end;
end;
% figure;
% scatter3(atompov(:,1),atompov(:,2),atompov(:,3),15,'filled');
% xlabel('x'); ylabel('y'); zlabel('z'); axis equal;

arq = strcat(path,'/atomlist.pov');

lines = [];
for line = 1:numel(atompov(:,1));
    povstr = strcat('sphere { <',num2str(atompov(line,1)),',',num2str(atompov(line,2)),',',num2str(atompov(line,3)),'>, 0.13 }');
	lines = strvcat(lines,povstr);  %#ok<VCAT,DSTRVCT>
    disp(line)
end;
dlmwrite(arq,lines,'');


%% HCP3D_POV_BULK FOR ATOMPROJ1 (100)
atompov = [];

cont = 0; % Filtering Z (-5:5) and X (-1:1) for atomlist
for i = 1:numel(atomproj1(:,3))
    if atomproj1(i,3) >= -5
        if atomproj1(i,3) <= 5
            if atomproj1(i,1) >= -1
                if atomproj1(i,1) <= 1
                    cont = cont + 1;
                    atompov(cont,1) = atomproj1(i,1); %#ok<*SAGROW>
                    atompov(cont,2) = atomproj1(i,2);
                    atompov(cont,3) = atomproj1(i,3);
                end;
            end;
        end;
    end;
end;

% Correction/approximation for values that are too small (< E-7)
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,1)) < 0.0000001
        atompov(j,1) = 0.00000;
    end;
end;
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,2)) < 0.0000001
        atompov(j,2) = 0.00000;
    end;
end;
% figure;
% scatter3(atompov(:,1),atompov(:,2),atompov(:,3),15,'filled');
% xlabel('x'); ylabel('y'); zlabel('z'); axis equal;

arq = strcat(path,'/atomproj1.pov');

lines = [];
for line = 1:numel(atompov(:,1));
    povstr = strcat('sphere { <',num2str(atompov(line,1)),',',num2str(atompov(line,2)),',',num2str(atompov(line,3)),'>, 0.13 }');
	lines = strvcat(lines,povstr);  %#ok<VCAT,DSTRVCT>
    disp(line)
end;
dlmwrite(arq,lines,'');


%% HCP3D_POV_BULK FOR ATOMPROJ2 (110)
atompov = [];

cont = 0; % Filtering Z (-5:5) and X (-1:1) for atomlist
for i = 1:numel(atomproj2(:,3))
    if atomproj2(i,3) >= -5
        if atomproj2(i,3) <= 5
            if atomproj2(i,1) >= -1
                if atomproj2(i,1) <= 1
                    cont = cont + 1;
                    atompov(cont,1) = atomproj2(i,1); %#ok<*SAGROW>
                    atompov(cont,2) = atomproj2(i,2);
                    atompov(cont,3) = atomproj2(i,3);
                end;
            end;
        end;
    end;
end;

% Correction/approximation for values that are too small (< E-7)
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,1)) < 0.0000001
        atompov(j,1) = 0.00000;
    end;
end;
for j = 1:numel(atompov(:,3))
    if abs(atompov(j,2)) < 0.0000001
        atompov(j,2) = 0.00000;
    end;
end;
% figure;
% scatter3(atompov(:,1),atompov(:,2),atompov(:,3),15,'filled');
% xlabel('x'); ylabel('y'); zlabel('z'); axis equal;

arq = strcat(path,'/atomproj2.pov');

lines = [];
for line = 1:numel(atompov(:,1));
    povstr = strcat('sphere { <',num2str(atompov(line,1)),',',num2str(atompov(line,2)),',',num2str(atompov(line,3)),'>, 0.13 }');
	lines = strvcat(lines,povstr);  %#ok<VCAT,DSTRVCT>
    disp(line)
end;
dlmwrite(arq,lines,'');
