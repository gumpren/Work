pro plot_line_mlt_bz_lasttime

  start=systime(1)
  save_str=''
  title_char='line_mlt_bz_lasttime'
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onset_numbers_under_IMF_bz_lasttime_divided_by_10minutes_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0_add_AE_AU_AL.sav'

  nums=dblarr(30)
  mlt_mean=dblarr(30)
  mlt_median=dblarr(30)
  for i=0,14 do begin
    nums[i]=n_elements(onset_last_time[14-i])
    mlt_mean[i]=mean(onset_mltonset_mlt[14-i])
    mlt_median[i]=median(onset_mlt[14-i])
  endfor
  for i=15,29 do begin
    nums[i]=n_elements(onset_last_time[i])
    mlt_mean[i]=mean(onset_mlt[i])
    mlt_median[i]=median(onset_mlt[i])
  endfor


  x=10*(indgen(15))+5

  ;______________________________________________________________________________

  ;mlt pic
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0

  pos=set_plot_position(2,1,left=0.07,right=0.48,xgap=0.06,ygap=0.06,low=0.05,high=0.60)
  ;cgdisplay

  str_element,opt_plot,'charsize',1.0,/add
  str_element,opt_plot,'color',black,/add
  str_element,opt_plot,'yticks',yticks,/add
  ; str_element,o;pt_plot,'ytickname',ytickname,/add
  str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/add
  str_element,opt_plot,'ytitle','MLT',/add
  str_element,opt_plot,'xtickformat','(a1)',/add
  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yminor',9,/add
  str_element,opt_plot,'yticks',3,/add
  str_element,opt_plot,'thick',4,/add
  ;  str_element,opt_plot,'ylog',1,/add
  ;  str_element,opt_plot,'xrange',[0.0,150.0],/add
  str_element,opt_plot,'yrange',[21,24],/add
  str_element,opt_plot,'xtickformat','(a1)',/add
  title_arr=['northward_IMF','southward_IMF']
  mlt_=hash()
  mlt_[0,0]=mlt_mean[0:14]      &     mlt_[0,1]=mlt_median[0:14]
  mlt_[1,0]=mlt_mean[15:29]     &     mlt_[1,1]=mlt_median[15:29]

  for i=0,1 do begin
    if i ne 1 then begin
      str_element,opt_plot,'xtickformat','(a1)',/add
      str_element,opt_plot,'xtitle',/delete
    endif else begin
      str_element,opt_plot,'xtickformat',/delete
      str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/add
    endelse

    ;  cgplot,tt_arr[i,j],alog(vari_arr[i,j]),pos=pos[i,j,*],color='grey',psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot
    cgplot,x,mlt_[i,0],pos=pos[i,0,*],/normal,/noerase,_extra=opt_plot,linestyle=0
    cgoplot,x,mlt_[i,1],pos=pos[i,0,*],/normal,/noerase,_extra=opt_plot,linestyle=2

    ;  cgoplot,x,alog10(average_arr[i,j]),xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange

    ;     cgplot,x,median_smooth_arr[i,0],pos=pos[i,0,*],xrange=xrange,color='red',/normal,/noerase,_extra=opt_plot,yrange=yrange
    ;     cgoplot,x,median_smooth_arr[i,1],pos=pos[i,0,*],xrange=xrange,color='blue',/normal,/noerase,_extra=opt_plot,yrange=yrange
    ;     ;
    ;     cgoplot,x,average_arr[i,j],xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,yrange=yrange

    labels_stamp,pos[i,0,*],title_arr[i],charsize=1.0,/left_right_center,/up_out
  endfor

  ;  cgtext,0.98,0.88,'median',alignment=0,charsize=1.0,font=0,color='red',/normal
  ;  cgtext,0.98,0.85,'average',alignment=0,charsize=1.0,font=0,color='royal blue',/normal
  cgLegend, Colors=['black', 'black'], linestyle=[0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.42], $
    Titles=['mean','median'], Length=0.075, VSpace=1.0, /Background, $
    BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15]

  cgLegend, Colors=['black', 'black'], linestyle=[0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.12], $
    Titles=['mean','median'], Length=0.075, VSpace=1.0, /Background, $
    BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15]
  cgps_close

  stop




end