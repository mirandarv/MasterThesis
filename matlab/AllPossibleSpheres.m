clear all
close all

conn = database('master','','');

addpath(genpath('C:\Users\Miran\OneDrive\Dokumenter\aa Havteknologi\Master\calibration-code-master\calibration-code-master\matlab\TS_Package'))

%% Input variables
% Water properties
cw = 1450%:5:1520; % water sound speed [m/s]
rhow = 1025%.3288; % water density [kg/m^3]

% Sphere properties
% WC
 rhos = 14900; % density of sphere [m/s], from [1] / CRR326
 cc = 6853; % compressional sound speed in sphere [m/s], from [EK80] / CRR326
 cs = 4171; % shear sound speed in sphere [m/s], from [EK80] / CRR326

% Cu
% rhos = 8947; % density of sphere [m/s], from [1]
% cc = 4760; % compressional sound speed in sphere [m/s], from [1]
% cs = 2288.5; % shear sound speed in sphere [m/s], from [1]

% References
%  [1] Foote, K. G., and MacLennan, D. N. 1984. Comparison of copper and tungsten carbide calibration spheres. The Journal of the %        Acoustical Society of America, 75: 612–616.

% MacLennan, D.N. 1981. The theory of solid spheres as sonar calibration targets. Scottish Fisheries Research. Report Number 22.

%D = 20:60; % sphere diameter [mm] 
%D = 25:.1:60
%D = 10:.1:90
D=12.1:.1:90
freq_range = [34 450];   % kHz
scale = 1;
n = 2*(freq_range(2)-freq_range(1))+1;                       % number of calculation points
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
    
    %% add to database
    new_sphere= table(append({'WC'},num2str(D(j))),D(j),{out.t_str}, ...
    'VariableNames',{'name' 'diameter' ...
    'material'});
    sqlwrite(conn,'master.dbo.sphere',new_sphere);
    
    for i=1:length(out.TS)
        new_TS= table(append({'WC'},num2str(D(j))),out.freq(i),out.TS(i), ...
        'VariableNames',{'name' 'frequency' ...
        'strength'});
        sqlwrite(conn,'master.dbo.target_strength',new_TS);
    end
    D(j)
%     %% Plot
%     figure(1)
%     plot(out.freq,out.TS,'LineWidth',2)
%     if length(D)==1
%         title(['Sphere ',num2str(D),' mm Ø'])
%     else
%         title(['Sphere'])
%     end
%     if j==1
%         hold
%     else
%         
%     end
%     figure(2)
%     plot(out.freq,out.phase,'LineWidth',2)
%     if length(D)==1
%         title(['Sphere ',num2str(D),' mm Ø'])
%     else
%         title(['Sphere'])
%     end
%     if j==1
%         hold
%     else
%         
%     end
%     leg{j}=[num2str(D(j)),' mm'];
%     save(['CalSphere_WC_',num2str(D(j)),'mm.mat'],'out','para')
end
% 
% figure(1)
% FigHandle = figure(gcf);
% set(FigHandle, 'Position', [100, 100, 1049, 1049*f]);
% set(gca, 'fontsize', 12, 'linewidth', 2)
% xlabel('Frequency [kHz]')
% ylabel('TS [dB re 1m^2]')
% xlim(freq_range)
% grid
% legend(leg,'Location','SouthEast')
% hold
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