;PRO EX_BOX, X0, Y0, X1, Y1, color
;
;  ;Call POLYFILL.
;
;  POLYFILL, [X0, X0, X1, X1], [Y0, Y1, Y1, Y0], COL = color
;
;END


pro plot_bar_numbers_bz_lasttime_less_panel
  
  start=systime(1)
  save_str=''
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onset_data_less_panel.sav'
    
  ;cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  
  nums=dblarr(10)
  mlt_mean=dblarr(10)
  mlt_median=dblarr(10)
  maglat_mean=dblarr(10)
  maglat_median=dblarr(10)
  maxAE_mean=dblarr(10)
  maxAE_median=dblarr(10)
  maxAU_mean=dblarr(10)
  maxAU_median=dblarr(10)
  minAL_mean=dblarr(10)
  minAL_median=dblarr(10)
   
  for i=0,4 do begin
    nums[i]=n_elements(onset_last_time_less[4-i])
    
    mlt_mean[i]=mean(onset_mlt_less[4-i])  
    maglat_mean[i]=mean(onset_maglat_less[4-i]) 
    maxAE_mean[i]=mean(AE_max_less[4-i])       ; for line seperate lineplot [i] ; for combined barplot [14-i]
    maxAU_mean[i]=mean(AU_max_less[4-i])
    minAL_mean[i]=mean(AL_min_less[4-i])
    
    mlt_median[i]=median(onset_mlt_less[4-i])
    maglat_median[i]=median(onset_maglat_less[4-i])    
    maxAE_median[i]=median(AE_max_less[4-i])
    maxAU_median[i]=median(AU_max_less[4-i])
    minAL_median[i]=median(AL_min_less[4-i])
  endfor
  for i=5,9 do begin
   nums[i]=n_elements(onset_last_time_less[i])
    
    mlt_mean[i]=mean(onset_mlt_less[i])  
    maglat_mean[i]=mean(onset_maglat_less[i]) 
    maxAE_mean[i]=mean(AE_max_less[i])      
    maxAU_mean[i]=mean(AU_max_less[i])
    minAL_mean[i]=mean(AL_min_less[i])
    
    mlt_median[i]=median(onset_mlt_less[i])
    maglat_median[i]=median(onset_maglat_less[i])    
    maxAE_median[i]=median(AE_max_less[i])
    maxAU_median[i]=median(AU_max_less[i])
    minAL_median[i]=median(AL_min_less[i])
  endfor
  
  
  x=10*(indgen(15))+5
  
; ;; ______________________________________________________________________________
;  ; numbers 1 solution
;  cgdisplay
;
;  
;  xval=indgen(31)
;  yval=nums
;  loadct,39
;  
;  str_element,opt_plot,'ytitle','numbers',/add
;  str_element,opt_plot,'xtitle','Bz last time',/add
;  str_element,opt_plot,'yrange',[0,450],/add
;  str_element,opt_plot,'xrange',[0,30],/add
;  str_element,opt_plot,'xticks',10,/add
;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','30','60','90','120','150'],/add
;
;  
;  cgplot,[0,0],[0,0],position=[0.15,0.2,0.9,0.95],_extra=opt_plot
;  for i=0,29 do EX_BOX,xval[i],!y.CRANGE[0],xval[i+1],yval[i],200
;
; 
;  stop
  
  ;______________________________________________________________________________
    
  ;numbers 
  title_char='barplot_numbers_bz_lasttime_less_panel'
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   ;cgdisplay 
  str_element,opt_plot,'ytitle','numbers',/add
  str_element,opt_plot,'charsize',0.7,/add
  str_element,opt_plot,'xtitle','B'+cgsymbol('down')+'z'+cgsymbol('n')+'>0'+'                                  '+ $
                        cgsymbol('Delta')+'t '+'(minutes)'+'                                  '+'B'+cgsymbol('down')+'z'+cgsymbol('n')+'<0',/add          
                                   
                                   
  ;str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xticklen',0.01,/add
  str_element,opt_plot,'yminor',2,/add
  ;  str_element,opt_plot,'ystyle',8,/add
  ;  str_element,opt_plot,'xstyle',8,/add 
;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','0','30','60','90','120','150'],/add
;  str_element,opt_plot,'xticks',11,/add
  str_element,opt_plot,'yrange',[0,800],/add
;  str_element,opt_plot,'xticks',10,/add
;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','30','60','90','120','150'],/add

  labels=['[90,150]','[60,90]','[40,60]','[20,40]','[0,20]','[0,20]','[20,40]','[40,60]','[60,90]','[90,150]']
   ; ,labelskip=3.0
  ;cgplot,indgen(30),nums,_REF_EXTRA=opt_plot
  cgbarplot,maxAE_median,barNames=labels,BASERANGE=1.0,window=1,position=[0.1,0.1,0.9,0.6],colors='royal blue',_REF_EXTRA=opt_plot  ;,barspace=0.0
  cgps_close
  
  
 ; stop
  
 ;;______________________________________________________________________________

   ;AE_max
   title_char='barplot_AE_max_median_bz_lasttime_less_panel'   
   cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   ;cgdisplay
   str_element,opt_plot,'ytitle','AE'+cgsymbol('down')+'max',/add
   str_element,opt_plot,'charsize',0.7,/add
   str_element,opt_plot,'xtitle','B'+cgsymbol('down')+'z'+cgsymbol('n')+'>0'+'                                  '+ $
     cgsymbol('Delta')+'t '+'(minutes)'+'                                  '+'B'+cgsymbol('down')+'z'+cgsymbol('n')+'<0',/add
  
  
   ;str_element,opt_plot,'xticks',2,/add
   str_element,opt_plot,'xticklen',0.01,/add
   str_element,opt_plot,'yminor',2,/add
   ;  str_element,opt_plot,'ystyle',8,/add
   ;  str_element,opt_plot,'xstyle',8,/add
   ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','0','30','60','90','120','150'],/add
   ;  str_element,opt_plot,'xticks',11,/add
   str_element,opt_plot,'yrange',[0,800],/add
   ;  str_element,opt_plot,'xticks',10,/add
   ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','30','60','90','120','150'],/add
  
   labels=['[90,150]','[60,90]','[40,60]','[20,40]','[0,20]','[0,20]','[20,40]','[40,60]','[60,90]','[90,150]']
   ; ,labelskip=3.0
   ;cgplot,indgen(30),nums,_REF_EXTRA=opt_plot
   cgbarplot,maxAE_median,barNames=labels,BASERANGE=1.0,window=1,position=[0.1,0.1,0.9,0.6],colors='royal blue',_REF_EXTRA=opt_plot  ;,barspace=0.0
   cgps_close


 
; ;______________________________________________________________________________
;  ;MLT
;  title_char='barplot_mlt_bz_lasttime_less_panel'
;  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
;  ;cgdisplay
;  str_element,opt_plot,'ytitle','MLT',/add
;  str_element,opt_plot,'charsize',0.7,/add
;  str_element,opt_plot,'xtitle','B'+cgsymbol('down')+'z'+cgsymbol('n')+'>0'+'                                  '+ $
;    cgsymbol('Delta')+'t '+'(minutes)'+'                                  '+'B'+cgsymbol('down')+'z'+cgsymbol('n')+'<0',/add
;  
;  
;  ;str_element,opt_plot,'xticks',2,/add
;  str_element,opt_plot,'xticklen',0.01,/add
;  str_element,opt_plot,'yminor',2,/add
;  ;  str_element,opt_plot,'ystyle',8,/add
;  ;  str_element,opt_plot,'xstyle',8,/add
;  ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','0','30','60','90','120','150'],/add
;  ;  str_element,opt_plot,'xticks',11,/add
;  str_element,opt_plot,'yrange',[22,24],/add
;  ;  str_element,opt_plot,'xticks',10,/add
;  ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','30','60','90','120','150'],/add
;  
;  labels=['[90,150]','[60,90]','[40,60]','[20,40]','[0,20]','[0,20]','[20,40]','[40,60]','[60,90]','[90,150]']
;  ; ,labelskip=3.0
;  ;cgplot,indgen(30),nums,_REF_EXTRA=opt_plot
;  cgbarplot,mlt_median,barNames=labels,BASERANGE=1.0,window=1,position=[0.1,0.1,0.9,0.6],colors='royal blue',_REF_EXTRA=opt_plot  ;,barspace=0.0
;  cgps_close
   
  
  
  
  ;______________________________________________________________________________
  ;MAGLAT
  title_char='barplot_maglat_median_bz_lasttime_less_panel'
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  ;cgdisplay
  str_element,opt_plot,'ytitle','MAGLAT',/add
  str_element,opt_plot,'charsize',0.7,/add
  str_element,opt_plot,'xtitle','B'+cgsymbol('down')+'z'+cgsymbol('n')+'>0'+'                                  '+ $
    cgsymbol('Delta')+'t '+'(minutes)'+'                                  '+'B'+cgsymbol('down')+'z'+cgsymbol('n')+'<0',/add
  
  
  ;str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xticklen',0.01,/add
  str_element,opt_plot,'yminor',2,/add
  ;  str_element,opt_plot,'ystyle',8,/add
  ;  str_element,opt_plot,'xstyle',8,/add
  ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','0','30','60','90','120','150'],/add
  ;  str_element,opt_plot,'xticks',11,/add
  str_element,opt_plot,'yrange',[0,90],/add
  ;  str_element,opt_plot,'xticks',10,/add
  ;  str_element,opt_plot,'xtickname',['150','120','90','60','30','0','30','60','90','120','150'],/add
  
  labels=['[90,150]','[60,90]','[40,60]','[20,40]','[0,20]','[0,20]','[20,40]','[40,60]','[60,90]','[90,150]']
  ; ,labelskip=3.0
  ;cgplot,indgen(30),nums,_REF_EXTRA=opt_plot
  cgbarplot,maglat_median,barNames=labels,BASERANGE=1.0,window=1,position=[0.1,0.1,0.9,0.6],colors='royal blue',_REF_EXTRA=opt_plot  ;,barspace=0.0
  cgps_close
  
  stop

end