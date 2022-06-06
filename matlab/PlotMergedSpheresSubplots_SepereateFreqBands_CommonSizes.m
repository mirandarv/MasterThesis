clear all
close all

figure(1)

    t=tiledlayout(3,2,'TileSpacing','Compact','Padding','Compact') 

    %subplot(3,2,1)
    nexttile
        D = [38.1 57.2]; % sphere diameter [mm]
        freq_range = [34 45];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,2)
        D = [35 38.1]; % sphere diameter [mm]
        freq_range = [45 90];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,3)
        D = [35 38.1]; % sphere diameter [mm]
        freq_range = [90 170];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,4)
        D = [25 35]; % sphere diameter [mm]
        freq_range = [160 260];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,5)
        D = [24 25]; % sphere diameter [mm]
        freq_range = [280 380];   % kHz
        PlotMergeSpheres_func(D,freq_range)

    nexttile    
    %subplot(3,2,6)
        D = [20 22]; % sphere diameter [mm]
        freq_range = [280 450];   % kHz
        PlotMergeSpheres_func(D,freq_range)
        
set(gcf,'Position',[1, 1, 700, 600]) 