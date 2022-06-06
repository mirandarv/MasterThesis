%Les inn data, frekvensrespons pr tobisstim og plot frekvensspekter.


%les inn filer i mappe

filer=dir(['*.json']);

  for k=1:length(filer);  % Løkke over filer
jsonData=jsondecode(fileread([filer(k).name]))
 

df=(jsonData.info.parameters.FrequencyResolution); %frekvensoppløysing

minFr=jsonData.pings(1).channels.minFrequency; 
maxFr=jsonData.pings(1).channels.maxFrequency;
teljarv=1;
fr=minFr:df:maxFr;
for i= 1:length(jsonData.pings)
  for j=1:length(jsonData.pings(i).channels(1).targets)
   
    ang_atv(teljarv)=jsonData.pings(i).channels.targets(j).athwartshipAngle;
    ang_alo(teljarv)=jsonData.pings(i).channels.targets(j).alongshipAngle;
    
    figure(1)
   plot(ang_atv(teljarv),ang_alo(teljarv),'b*')
   hold on
    if -0.5<=ang_alo(teljarv) && ang_alo(teljarv)<=0.5 && ang_atv(teljarv)<=0.5 &&-0.5<= ang_atv(teljarv)
    
   figure(1)
   plot(ang_atv(teljarv),ang_alo(teljarv),'r*')
   hold on
     set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
                        'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
                    set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
                    xlabel('deg atw')
                    ylabel('deg alo')
figure(2)
   plot(fr./1000,jsonData.pings(i).channels.targets(j).tsc)
   hold on
     set(findobj(gcf,'type','axes'),'FontName','Calibri','FontSize',22, ...
                        'FontWeight','Bold', 'LineWidth', 1.5,'layer','top');
                    set(findobj(gcf, 'Type', 'Line'),'LineWidth',1.5);
                    xlabel('kHz')
    end   
        
%tsbb=jsonData.pings(i).channels.targets
  teljarv=teljarv+1;
  end
end
%plot(ang_atv,ang_alo,'*')
  end
  
