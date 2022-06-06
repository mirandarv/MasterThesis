%read frequency data from calibraton
filer=dir(['*.xml']);

  for k=1:length(filer);  
    
%     if k==1
%         [s]=xml2struct('TrList_calibration_EgersundWC38.xml');
%         n=[ 2 3 4 5]
%         
%     elseif k==3
%         [s]=xml2struct('TrList_calibration_EgersundWC38allOn.xml');
%         n=[1 2 3 4]
%         
%     elseif k==2
%         [s]=xml2struct('TrList_calibrationSandvikflakWC38original.xml');
%         n=[4 5 6 8] 
%     end
 [s]=xml2struct(filer(k).name);
%n=[ 2 3 4 5]
%n=1;
   % for b=n;
      
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
          %legend('gain')
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
          %legend('gain')
          if k==length(filer);
            xlabel('frequency, kHz')
          end
            ylabel('gain')
            hold on;
               set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',27, ...
                        'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
                    set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
                    grid on
            
%             figure(20)
%             hold on;
%                set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
%                         'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
%                     set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
%             
%                 plot(f/1000,BeamAl,'*')
%                 hold on
%            
%             
%         
%             title('BeamAl')
%             
%             xlabel('frequency, kHz')
%             ylabel('')
%             hold on;
%                set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
%                         'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
%                     set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
%                     grid on
%             
%                  figure(3)
%            
%          
%                 plot(f/1000,BeamAtw,'*')
%            
%               hold on;
%             title('BeamAtw')
%             
%             xlabel('frequency, kHz')
%             ylabel('')
%             hold on;
%                set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
%                         'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
%                     set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
%              grid on
%                  figure(4)
%           
%            
%                 plot(f/1000,AngAl,'*')
%              hold on;
%             title('AngAl')
%             
%             xlabel('frequency, kHz')
%             ylabel('')
%             hold on;
%                set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
%                         'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
%                     set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
%                     grid on
%                  figure(5)
%             hold on;
%            
%                 plot(f/1000,AngAtw,'*')
%            hold on
%             title('AngAtw')
%             
%             xlabel('frequency, kHz')
%             ylabel('')
%             hold on;
%                set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
%                         'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
%                     set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
%       grid on
      clear f g BeamAl BeamAtw AngAl AngAtw a
 
    
end