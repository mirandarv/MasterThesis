%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example script to calculate TS from calibration sphere using the TS_package
% Here we loop over several diameters of a sphere and plot the results
% Can be extended to loop over different variables (sound speed, density,
% etc.)
% Results are also saved as mat files
% GP - IMR 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

addpath(genpath('C:\Users\Miran\OneDrive\Dokumenter\aa Havteknologi\Master\calibration-code-master\calibration-code-master\matlab\TS_Package'))

%% Input variables
% Water properties
cw = 1450%:5:1520; % water sound speed [m/s]
rhow = 1025%.3288; % water density [kg/m^3]
%rhow = 1027

% Sphere properties
% WC
rhos = 14900; % density of sphere [m/s], from [1] / CRR326
% cc = 6864; % compressional sound speed in sphere [m/s], from [1]
% cs = 4161.2; % shear sound speed in sphere [m/s], from [1]
% rhos = 14950; % density of sphere [m/s], from [EK80]
cc = 6853; % compressional sound speed in sphere [m/s], from [EK80] / CRR326
cs = 4171; % shear sound speed in sphere [m/s], from [EK80] / CRR326

% Cu
% rhos = 8947: % density of sphere [m/s], from [1]
% cc = 4760; % compressional sound speed in sphere [m/s], from [1]
% cs = 2288.5; % shear sound speed in sphere [m/s], from [1]

% References
%  [1] Foote, K. G., and MacLennan, D. N. 1984. Comparison of copper and tungsten carbide calibration spheres. The Journal of the %        Acoustical Society of America, 75: 612–616.

% MacLennan, D.N. 1981. The theory of solid spheres as sonar calibration targets. Scottish Fisheries Research. Report Number 22.

D = [38.1]; % sphere diameter [mm]

freq_range = [90 170];   % kHz
scale = 1;
n = 4000;                       % number of calculation points
target_index = 1;
proc_flag = 1;
spec.freq=38;                   % for calculating bandwidth averaged TS
spec.BW=100;

T = [];
P = [];
S = [];

% Write variables to screen
disp(['Sphere diameter ' num2str(D) ' mm'])
disp(['Sphere density ' num2str(rhos) ' kg/m^3'])
disp(['Sphere compressional sound speed ' num2str(cc) ' m/s'])
disp(['Sphere shear sound speed ' num2str(cs) ' m/s'])
disp(['Water sound speed ' num2str(cw) ' m/s'])
disp(['Water density ' num2str(rhow) ' kg/m^3'])
disp(' ')
w=30;h=15;f=h/w;

% Loop over a set of values
for j = 1:length(D)
    para = struct('rho', rhos, 'cc', cc, 'cs', cs, 'ave_value', spec.BW, 'ave_unit', 0);
    [para,out]=solid_elastic_sphere_TS_fun(freq_range,spec.freq,scale,n,target_index,proc_flag,D(j),T,P,S,cw,rhow,para);
    % Plot
    figure(1)
    plot(out.freq,out.TS,'LineWidth',2)
    if length(D)==1
        title(['Sphere ',num2str(D),' mm Ø'])
    else
        title(['Sphere'])
    end
    if j==1
        hold
    else
        
    end
%     figure(2)
%     plot(out.freq,out.phase,'LineWidth',2)
%     if length(D)==1
%         title(['Sphere ',num2str(D),' mm Ø'])
%     else
%         title(['Sphere'])
%     end
%     if j==1
%         hold
% %     else
%         
%     end
    leg{j}=[num2str(D(j)),' mm'];
    save(['CalSphere_WC_',num2str(D(j)),'mm.mat'],'out','para')
end

figure(1)
FigHandle = figure(gcf);
set(FigHandle, 'Position', [100, 100, 1049, 1049*f]);
set(gca, 'fontsize', 12, 'linewidth', 2)
xlabel('Frequency [kHz]')
ylabel('TS [dB re 1m^2]')
xlim(freq_range)
grid
legend(leg,'Location','SouthEast')
hold
% figure(2)
% FigHandle = figure(gcf);
% set(FigHandle, 'Position', [100, 100, 1049, 1049*f]);
% set(gca, 'fontsize', 12, 'linewidth', 2)
% xlabel('Frequency [kHz]')
% ylabel('Phase [deg]')
% xlim(freq_range)
% grid
% legend(leg,'Location','SouthEast')
% hold