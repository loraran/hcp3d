function [mgfourier] = hcp3d_fftXk(fmg,sepDist,clatt,inclangle,atomname,atomcalc,path,coordstep)

path2 = strcat('angle_',num2str(inclangle),'_step_',num2str(coordstep)); mkdir(path,path2);

%%% Defining the structure factor indexes (HCP)
lambda = 1.03293;                       % E ~= 12keV; lambda ~= 12395/12000
sigma = 2.0;                            % Debye-Waller factor

lmax = 5; %#ok<NASGU> % L = 0:1:lmax
Imin = 0.000;
Imax = 9.000;
Ncont = 500; % basic = 500 (ATTENTION: processing time is proportional)
Istep = (Imax-Imin)/Ncont;
Imin = Imin+Istep;
Imax = Imax+Istep;

atomfourier = zeros(1,Ncont+1);         % Pre-allocating atomfourier
Q = zeros(1,Ncont+1);                   % Pre-allocating Q
tth = zeros(1,Ncont+1);                 % Pre-allocating tth
mgfourier = zeros(Ncont+1,2); % zeros(Ncont+1,2*(lmax+1));  % Pre-allocating mgfourier
maxnatoms = numel(atomcalc(:,1));

fprintf('  lambda = %g\n  sigma = %g\n',lambda,sigma);

tic;
set(0,'DefaultFigureWindowStyle','docked');
figure;
%%% Variations in H, K, L
for hLoc = 0:3
    for lLoc = 0:6
        contloc = 1;
        for j = Imin:Istep:Imax
            kLoc = j;
            atomtemp = zeros(maxnatoms,1);
            atomsoma = 0;
            Dhkl = sqrt((3*(sepDist^2)*(clatt^2))/((4*(hLoc^2 + (hLoc*kLoc) + kLoc^2))+(3*(sepDist^2)*(lLoc^2))));
            Qloc = (2*pi)/Dhkl;
            for f = 1:maxnatoms
                if atomcalc(f,4) == fmg
                    fmgLocal = 12.22064*exp(-Qloc/6.94162) + 0.09719; % Atomic Scattering Factor
                else
                    fmgLocal = 0;
                end;
                atomtemp(f,1) = (fmgLocal*exp(sigma)*(exp(2*pi*1i*(hLoc*atomcalc(f,1)+kLoc*atomcalc(f,2)+lLoc*atomcalc(f,3)))));
                atomsoma = atomsoma + atomtemp(f);
            end;
            atomfourier(contloc) = abs(atomsoma)^2;
            if atomfourier(contloc) < 0
                atomfourier(contloc) = 0;
            end;
            Q(contloc) = Qloc;
            tth(contloc) = (2*asin(Qloc*lambda/(4*pi)))*(180/pi);
            contloc = contloc + 1;
        end;
        mgfourier(:,1) = real(transpose(tth)); % Q(lLoc)
        mgfourier(:,2) = real(transpose(atomfourier)); % atomfourier(lLoc)
        
        subplot(1,3,1)
        scatter3(atomcalc(:,1),atomcalc(:,2),atomcalc(:,3),10,[0 0 1],'filled'); % for visualization only
        xlabel('x'); ylabel('y'); zlabel('z');
        title([atomname,' - angle = ',num2str(inclangle)],'FontWeight','bold')
        axis equal;
        view(0,90); % azul
        
        if (hLoc == 3) && (kLoc == 1)
%         elseif (hLoc == 0) && (kLoc == 1)
        else
        subplot(1,3,[2 3])
        for y = 2:2:numel(mgfourier(1,:))
            plot(mgfourier(:,y-1),mgfourier(:,y));
%             plot(mgfourier(:,y-1),log(mgfourier(:,y)));
            axis([20 80 0 10^10]);
%             patch('XData',[24.2 24.2 26.2 26.2],'YData',[0 10^11 10^11 0],'LineStyle','none','FaceColor','y','FaceAlpha',0.05);
            rectangle('Position',[24.2,-10^8,2.0,10^13],'LineWidth',1,'LineStyle',':'); % ?[1] peak = 25.2°
            rectangle('Position',[28.2,-10^8,2.0,10^13],'LineWidth',1,'LineStyle',':'); % ?[2] peak = 29.2°
            rectangle('Position',[40.8,-10^8,2.0,10^13],'LineWidth',1,'LineStyle',':'); % ?[3] peak = 41.8°
            rectangle('Position',[65.8,-10^8,2.0,10^13],'LineWidth',1,'LineStyle',':'); % ?[4] peak = 66.8°
            rectangle('Position',[68.0,-10^8,2.0,10^13],'LineWidth',1,'LineStyle','--'); % (301) peak = 69.0°
            rectangle('Position',[77.0,-10^8,2.0,10^13],'LineWidth',1,'LineStyle','--'); % (303) peak = 78.0°
            hold all; % hold on;
        end;
%         hold off;
        xlabel('2-theta'); ylabel('Intensity');
        title('FFT','FontWeight','bold');

        fprintf('  (h k l) planes = (%g K %g) ...\n',hLoc,lLoc);
        
        % Saving mgfourier to .txt file (comment to disable)
        fftname = strcat(atomname,'_ang',num2str(inclangle),'_',num2str(hLoc),'j',num2str(lLoc),'.txt');
        fftfile = fullfile(path,path2,fftname);
        save(fftfile,'mgfourier','-ascii');
%         fopen(fftfile, 'w+'); % Opening the file to write and save mgfourier
%         dlmwrite(fftfile, real(mgfourier), '\t');
%         fclose('all');

        end;
    end;
    if lLoc == 6
        subplot(1,3,[2 3])
        legend('0K0','0K1','0K2','0K3','0K4','0K5','0K6','1K0','1K1','1K2','1K3','1K4','1K5','1K6','2K0','2K1','2K2','2K3','2K4','2K5','2K6','3K0','3K1','3K2','3K3','3K4','3K5','3K6')
    else
    end;
end;

toc
beep