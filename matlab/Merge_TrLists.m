%% merge table

conn = database('master','','');
tablename='master.dbo.merge_spheres';
rows=sqlread(conn,tablename);

%% read frequency data from calibraton

filer=dir(['*.xml']);

  for k=1:length(filer);  

 [s]=xml2struct(filer(k).name);
      
        for a=1:length(s.Root.TransducerData.Transducer.FrequencyPar)
            
            
            f(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.Frequency);
            g(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.Gain);
            AngAl(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.AngleOffsetAlongship);
            AngAtw(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.AngleOffsetAthwartship);
            BeamAl(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.BeamWidthAlongship);
            BeamAtw(a)=str2num(s.Root.TransducerData.Transducer.FrequencyPar{1,a}.Attributes.BeamWidthAthwartship);
            
             end 
            figure(1)
            subplot(length(filer),1,k)
            hold on;
          
                plot(f/1000,g,'*')
                ylim([23 31])
                legend(filer(k).name, 'Interpreter', 'none')
          hold on;

          if k==length(filer);
            xlabel('frequency, kHz')
          end
            ylabel('gain')
            hold on;
               set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',27, ...
                        'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
                    set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
                    grid on
             set(gca,'fontsize', 27);
                    
                    
                       figure(2)
           
          
                plot(f/1000,g,'*')
                hold on
                ylim([23 31])
                legend(filer(k).name, 'Interpreter', 'none')
          hold on;

          if k==length(filer);
            xlabel('frequency, kHz')
          end
            ylabel('gain')
            hold on;
               set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',27, ...
                        'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
                    set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
                    grid on
            
      clear f g BeamAl BeamAtw AngAl AngAtw a
 
    
end