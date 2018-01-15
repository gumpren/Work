;+
; :Author: Gren
;-

pro line_plot_variable_all_in_one_lasttime_10minute_per_point
  h_Factor=1.0/(6.371^2*1.0e3)

  ;1W/m^2=6.371^2*1.0e3(1.0e15*erg/(Re^2*s))

  region_strs=['','_dawnflank','_duskflank','_near_dawnflank','_far_dawnflank','_near_duskflank','_far_duskflank']

  ;region_str=region_strs[4]
  namestr=''
  
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\'
  
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[1]+'.sav'
  vari_dawn=K_re

  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[2]+'.sav'
  vari_dusk=K_re
  vari_str='K_x'
  
  title_char=namestr+'line_plot_all_in_one_median_'+vari_str+'_dawn_dusk_lasttime_10minute_per_point'

  x=10*(indgen(15))+5
  
  median_vari_dawn_north=dblarr(15)
  median_vari_dawn_south=dblarr(15)
  median_vari_dusk_north=dblarr(15)
  median_vari_dusk_south=dblarr(15)

  average_vari_dawn_north=dblarr(15)
  average_vari_dawn_south=dblarr(15)
  average_vari_dusk_north=dblarr(15)
  average_vari_dusk_south=dblarr(15)


  xrange=[0.0,150.0]
  if (vari_str eq 'density' eq 1b)  then begin
    yrange=[-2.0,0.0]
    unit_str='(cm!u-3!n)'
    yticks=2
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n'] ;n
  endif
  if (vari_str eq 'pressure' eq 1b)  then begin
    yrange=[-2.0,0.0]
    unit_str='(nPa)'
    yticks=2
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n'];['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n'] ;p
  endif
  if (vari_str eq 'temperature' eq 1b)  then begin
    yrange=[-1.0,1.0]
    unit_str='(KeV)'
    yticks=2
    ytickname=['10!u-1!n','10!u0!n','10!u1!n'];['10!u-1!n','10!u0!n','10!u1!n'];t
  endif
  if (vari_str eq 'e_gsm_y' eq 1b)  then begin
    yrange=[-8,4] ; ey
  endif

  if (vari_str eq 'H_x' eq 1b)  then begin
;    yrange=[-2,0]
;    yticks=2
;    ytickname=['10!u-2!n','10!u-1!n','10!u0!n']; hx
    yrange=[-3,1]
    ytickname=['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n']; hx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif

  if (vari_str eq 'K_x' eq 1b)  then begin
    yrange=[-10,2]
    ytickname=['10!u-10!n','10!u-8!n','10!u-6!n','10!u-4!n','10!u-2!n','10!u0!n','10!u2!n']; hx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif

  if (vari_str eq 'H_K_x' eq 1b)  then begin
    yrange=[-2,0]
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n']; hkx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif


  for i=0,14 do begin

    if ( (size(vari_dusk[i]))[0] eq 1)  then begin
      vari_dawn_north=get_varii(vari_dawn[i],log=0)
      vari_dawn_south=get_varii(vari_dawn[i+15],log=0)
      vari_dusk_north=get_varii(vari_dusk[i],log=0)
      vari_dusk_south=get_varii(vari_dusk[i+15],log=0)      
    endif

    if ( (size(vari_dusk[i]))[0] eq 2)  then begin
      vari_dawn_north=get_varii((vari_dawn[i])[*,0],log=0)
      vari_dawn_south=get_varii((vari_dawn[i+15])[*,0],log=0)
      vari_dusk_north=get_varii((vari_dusk[i])[*,0],log=0)
      vari_dusk_south=get_varii((vari_dusk[i+15])[*,0],log=0)
    endif



    median_vari_dawn_north[i]=median(vari_dawn_north)
    median_vari_dawn_south[i]=median(vari_dawn_south)
    median_vari_dusk_north[i]=median(vari_dusk_north)   
    median_vari_dusk_south[i]=median(vari_dusk_south)

    average_vari_dawn_north[i]=average(vari_dawn_north,/nan)
    average_vari_dawn_south[i]=average(vari_dawn_south,/nan) 
    average_vari_dusk_north[i]=average(vari_dusk_north,/nan)   
    average_vari_dusk_south[i]=average(vari_dusk_south,/nan)
  endfor


  median_arr=hash()
  median_arr[0]=median_vari_dawn_north
  median_arr[1]=median_vari_dawn_south
  median_arr[2]=median_vari_dusk_north
  median_arr[3]=median_vari_dusk_south
  
  average_arr=hash()
  average_arr[0]=average_vari_dawn_north
  average_arr[1]=average_vari_dawn_south
  average_arr[2]=average_vari_dusk_north
  average_arr[3]=average_vari_dusk_south
  
  

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(1,1,left=0.07,right=0.90,xgap=0.05,ygap=0.07,low=0.07,high=0.60)
  ;cgdisplay

  str_element,opt_plot,'charsize',1.2,/add
  str_element,opt_plot,'yticks',yticks,/add
  str_element,opt_plot,'ytickname',ytickname,/add
  str_element,opt_plot,'ytitle',vari_str+unit_str,/add
  str_element,opt_plot,'xtitle','Time(min)',/add                                                     

  str_element,opt_plot,'yminor',10,/add
  
  
  
  ;plot_line_in_one
  for i=0,3 do begin
      
      if i le 1 then begin
        str_element,opt_plot,'color','red',/add
      endif else begin
        str_element,opt_plot,'color','black',/add
      endelse
      
      if i eq 0 or i eq 2 then str_element,opt_plot,'linestyle',0,/add  ; solid line
      if i eq 1 or i eq 3 then str_element,opt_plot,'linestyle',2,/add  ; dashed line
      
      cgplot,x,alog10(median_arr[i]),pos=pos[0,0,*],xrange=xrange,yrange=yrange,ylog=ylog,/normal,/noerase,_extra=opt_plot
           
  endfor
  
  title_arr=['N-IMF Dawnflank','S-IMF Dawnflank','N-IMF Duskflank','S-IMF Duskflank']
  
  
;  for i=0,3 do begin    
;    cgtext,0.92,0.55-0.04*i,title_arr[i],alignment=0,charsize=1.0,font=0,/normal
;  endfor
    
  cgLegend, Colors=['red','red', 'black', 'black'], linestyle=[0,2,0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.9, 0.2035], $
       Titles=title_arr, Length=0.075, /Box, VSpace=1.15, /Background, $
       BG_Color='light grey', /AddCmd   ;, PSyms=[6,15]
  
  cgps_close
 
  



   stop


end