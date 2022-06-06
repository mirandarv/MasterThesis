clear all
close all

figure(1)

    t=tiledlayout(3,2,'TileSpacing','Compact','Padding','Compact') 

    %subplot(3,2,1)
    nexttile
        D = [37.9 85.7]; % sphere diameter [mm]
        freq_range = [34 45];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,2)
        D = [34.2 80.7]; % sphere diameter [mm]
        freq_range = [45 90];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,3)
        D = [27.9 45.7]; % sphere diameter [mm]
        freq_range = [90 170];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,4)
        D = [31 35]; % sphere diameter [mm]
        freq_range = [160 260];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,5)
        D = [21.7 24]; % sphere diameter [mm]
        freq_range = [280 380];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,6)
        D = [21.7 24]; % sphere diameter [mm]
        freq_range = [280 450];   % kHz
        PlotMergeSpheres_func(D,freq_range)
        
set(gcf,'Position',[1, 1, 700, 600])        