
function plotMergeSpheres_func(D,freq_range)

frequencies=freq_range(1):freq_range(2);
%% Input variables
% Water properties
cw = 1450%:5:1520; % water sound speed [m/s]
rhow = 1025%.3288; % water density [kg/m^3]
%rhow = 1027

%% Sphere properties
% WC
rhos = 14900; % density of sphere [m/s], from [1] / CRR326
cc = 6853; % compressional sound speed in sphere [m/s], from [EK80] / CRR326
cs = 4171; % shear sound speed in sphere [m/s], from [EK80] / CRR326

%% Plot both spheres
scale = 1;
n = 2*(freq_range(2)-freq_range(1))+1; % number of calculation points
target_index = 1;
proc_flag = 1;
spec.freq=38;                   % for calculating bandwidth averaged TS
spec.BW=100;
C={'r','b','g','y'};

T = [];
P = [];
S = [];
target_strength=[];

% Write variables to screen
disp(['Sphere diameter ' num2str(D) ' mm'])
disp(['Sphere density ' num2str(rhos) ' kg/m^3'])
disp(['Sphere compressional sound speed ' num2str(cc) ' m/s'])
disp(['Sphere shear sound speed ' num2str(cs) ' m/s'])
disp(['Water sound speed ' num2str(cw) ' m/s'])
disp(['Water density ' num2str(rhow) ' kg/m^3'])
disp(' ')
w=30;h=15;f=h/w;

figure(1)
    for j = 1:length(D)
        para = struct('rho', rhos, 'cc', cc, 'cs', cs, 'ave_value', spec.BW, 'ave_unit', 0);
        [para,out]=solid_elastic_sphere_TS_fun(freq_range,spec.freq,scale,n,target_index,proc_flag,D(j),T,P,S,cw,rhow,para);
        target_strength(:,j)=out.TS;
        % Plot
        plot(out.freq,out.TS,'color',C{j},'LineWidth',2)
%         if freq_range(1)< 38 && 38<freq_range(2)
%             title(['FM38'])
%         elseif freq_range(1)<70 && 70<freq_range(2)
%             title(['FM70'])
%         elseif freq_range(1)<120 && 120<freq_range(2)
%             title([['FM120'])
%         else
%             title(['Spheres'])
%         end
        if ismember(38,frequencies)
            title(['FM38'])
        elseif ismember(70,frequencies)
            title(['FM70'])
        elseif ismember(120,frequencies)
            title(['FM120'])
        elseif ismember(200,frequencies)
            title(['FM200'])
        elseif ismember(333,frequencies)
            title(['FM333'])
        else
            title([''])
        end
        
        if j==1
            hold
        else

        end
        leg{j}=[num2str(D(j)),' mm'];
        save(['CalSphere_WC_',num2str(D(j)),'mm.mat'],'out','para')
        sphere_names(j)=convertCharsToStrings(['WC',num2str(D(j))])
    end

%% Plot Merge spheres

%     for i=1:height(rows)
%         for j=1:length(sphere_names)
%             if string(rows{i,4})==sphere_names(j)
%                 plot(rows{i,1},target_strength(i,j),'color',C{j},'marker','*')
%             end
% 
%         end
%     end
%% Figure

FigHandle = figure(gcf);
set(FigHandle, 'Position', [100, 100, 1049, 1049*f]);
set(gca, 'fontsize', 12, 'linewidth', 2)
xlabel('Frequency [kHz]')
ylabel('TS [dB re 1m^2]')
xlim(freq_range)
ylim([-65 -30])
legend(sphere_names,'Location','SouthEast')
grid
hold
