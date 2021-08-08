% % % MODEL = sphere { <-0.44,3.96,1.22>, 0.15 }

load mgcrystal_pov.mat % Loads 'atomcut1' (bulk) and 'atomcut2' (inclusion) matrices
atompov1 = []; atompov2 = []; % Pre-allocating

% % Visualization
% figure;
% scatter3(atomcut1(:,1),atomcut1(:,2),atomcut1(:,3),15,[0 0 1],'filled'); hold on;
% scatter3(atomcut2(:,1),atomcut2(:,2),atomcut2(:,3),15,[0 1 0],'filled'); hold off;
% xlabel('x'); ylabel('y'); zlabel('z');
% axis equal;
% view(90,0)
% pause

cont = 0; % Filtering Z (-5:5), Y (-5:5) and X (-1:1) for atomcut1
for i = 1:numel(atomcut1(:,3))
    if atomcut1(i,3) >= -5
    if atomcut1(i,3) <= 5
        if atomcut1(i,1) >= -1
        if atomcut1(i,1) <= 1
            if atomcut1(i,2) >= -4
            if atomcut1(i,2) <= 4.5
                cont = cont + 1;
                atompov1(cont,1) = atomcut1(i,1);
                atompov1(cont,2) = atomcut1(i,2);
                atompov1(cont,3) = atomcut1(i,3);
            end;
            end;
        end;
        end;
    end;
    end;
end;
cont = 0; % Filtering Z (-5:5), Y (-5:5) and X (-1:1) for atomcut2
for i = 1:numel(atomcut2(:,3))
    if atomcut2(i,3) >= -5
    if atomcut2(i,3) <= 5
        if atomcut2(i,1) >= -1
        if atomcut2(i,1) <= 1
            if atomcut2(i,2) >= -4
            if atomcut2(i,2) <= 4.5
                cont = cont + 1;
                atompov2(cont,1) = atomcut2(i,1);
                atompov2(cont,2) = atomcut2(i,2);
                atompov2(cont,3) = atomcut2(i,3);
            end;
            end;
        end;
        end;
    end;
    end;
end;
figure;
subplot(1,2,1); scatter3(atompov1(:,1),atompov1(:,2),atompov1(:,3),15,[0 0 1],'filled');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal; view(110,20);
subplot(1,2,2); scatter3(atompov2(:,1),atompov2(:,2),atompov2(:,3),15,[0 1 0],'filled');
xlabel('x'); ylabel('y'); zlabel('z'); axis equal; view(110,20);
% pause

figure;
scatter3(atompov1(:,1),atompov1(:,2),atompov1(:,3),25,[0 0 1],'filled'); hold on;
scatter3(atompov2(:,1),atompov2(:,2),atompov2(:,3),25,[0 1 0],'filled'); hold off;
xlabel('x'); ylabel('y'); zlabel('z');
axis equal; view(90,0)
% pause
break

% Correction/approximation for values that are too small (< E-7)
for j = 1:numel(atompov1(:,3))
    if abs(atompov1(j,1)) < 0.0000001 % x values in atompov1 (atomcut1 - bulk)
        atompov1(j,1) = 0.00000;
    end;
    if abs(atompov1(j,2)) < 0.0000001 % y values in atompov1 (atomcut1 - bulk)
        atompov1(j,2) = 0.00000;
    end;
end;
for j = 1:numel(atompov2(:,3))
    if abs(atompov2(j,1)) < 0.0000001 % x values in atompov2 (atomcut2 - inclusion)
        atompov2(j,1) = 0.00000;
    end;
    if abs(atompov2(j,2)) < 0.0000001 % y values in atompov2 (atomcut2 - inclusion)
        atompov2(j,2) = 0.00000;
    end;
end;

path = strcat('C:/Users/Loren/Desktop/hcp3d_plots/POV-Ray/alpha - ',datestr(clock,'dd-mmm-yyyy HH.MM.SS')); mkdir(path);
arq1 = strcat(path,'/atomcut1.pov'); arq2 = strcat(path,'/atomcut2.pov');

% Saving .pov for atomcut1 (bulk)
lines = [];
for line = 1:numel(atompov1(:,1));
    povstr = strcat('sphere { <',num2str(atompov1(line,1)),',',num2str(atompov1(line,2)),',',num2str(atompov1(line,3)),'>, 0.10 }');
	lines = strvcat(lines,povstr); %#ok<VCAT>
    disp(line)
end;
dlmwrite(arq1,lines,'');

% Saving .pov for atomcut2 (inclusion)
lines = [];
for line = 1:numel(atompov2(:,1));
    povstr = strcat('sphere { <',num2str(atompov2(line,1)),',',num2str(atompov2(line,2)),',',num2str(atompov2(line,3)),'>, 0.10 }');
	lines = strvcat(lines,povstr); %#ok<VCAT>
    disp(line)
end;
dlmwrite(arq2,lines,'');
