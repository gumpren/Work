;+
; :Author: Gren
;-

pro scatter_plot_2d_variable_lasttime_10minute_per_point_4panel
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
  vari_dawn=H_re 
  tt_dawn=t_last
  
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_strs[2]+'.sav'
  vari_dusk=H_re
  vari_str='H_x'
  tt_dusk=t_last
  
  title_char=namestr+'scatter_plot_2d_'+vari_str+'_dawn_dusk_lasttime_10minute_per_point_4panel'

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
    yrange=[-2.0,1.0]
    unit_str='(cm!u-3!n)'
    yticks=3
    ytickname=['10!u-2!n','10!u-1!n','10!u0!n','10!u1!n'] ;n
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
    
    append_Array,vari_dawn_north1,vari_dawn_north
    append_Array,vari_dawn_south1,vari_dawn_south
    append_Array,vari_dusk_north1,vari_dusk_north
    append_Array,vari_dusk_south1,vari_dusk_south

    append_Array,tt_dawn_north,tt_dawn[i]
    append_Array,tt_dawn_south,tt_dawn[i+15]
    append_Array,tt_dusk_north,tt_dusk[i]
    append_Array,tt_dusk_south,tt_dusk[i+15]

    
  endfor
  
  tt_arr=hash()
  tt_arr[0,0]=tt_dawn_north   &    tt_arr[0,1]=tt_dawn_south
  tt_arr[1,0]=tt_dusk_north   &    tt_arr[1,1]=tt_dusk_south
  
  vari_arr=hash()
  vari_arr[0,0]=vari_dawn_north1   &    vari_arr[0,1]=vari_dawn_south1
  vari_arr[1,0]=vari_dusk_north1   &    vari_arr[1,1]=vari_dusk_south1
  
  median_arr=hash()
  median_arr[0,0]=median_vari_dawn_north   &    median_arr[0,1]=median_vari_dawn_south
  median_arr[1,0]=median_vari_dusk_north   &    median_arr[1,1]=median_vari_dusk_south

  average_arr=hash()
  average_arr[0,0]=average_vari_dawn_north   &    average_arr[0,1]=average_vari_dawn_south
  average_arr[1,0]=average_vari_dusk_north   &    average_arr[1,1]=average_vari_dusk_south
 
  title_arr=[['N-IMF Dawnflank','N-IMF Duskflank'],$
             ['S-IMF Dawnflank','S-IMF Duskflank']]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   pos=set_plot_position(2,2,left=0.07,right=0.95,xgap=0.06,ygap=0.06,low=0.05,high=0.90)
  ;cgdisplay

  str_element,opt_plot,'charsize',1.2,/add
  str_element,opt_plot,'yticks',yticks,/add
  str_element,opt_plot,'ytickname',ytickname,/add
  str_element,opt_plot,'ytitle',vari_str+unit_str,/add
  str_element,opt_plot,'xtitle','Time(min)',/add                                                     
  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yminor',5,/add

  
  
  ;
  for i=0,1 do begin
    for j=0,1 do begin   
      
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle',vari_str+unit_str,/add
      endelse

      if i ne 1 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','Time(min)',/add
      endelse
     
   ;  cgplot,tt_arr[i,j],alog(vari_arr[i,j]),pos=pos[i,j,*],color='grey',psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot
     cgplot,x,alog10(median_arr[i,j]),pos=pos[i,j,*],xrange=xrange,color='red',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange
     cgoplot,x,alog10(average_arr[i,j]),xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange

     labels_stamp,pos[i,j,*],title_arr[i,j],charsize=1.0,/left_right_center,/up_out
    
    endfor         
  endfor
  
  cgtext,0.98,0.88,'median',alignment=0,charsize=1.0,font=0,color='red',/normal
  cgtext,0.98,0.85,'average',alignment=0,charsize=1.0,font=0,color='royal blue',/normal 
;  cgLegend, Colors=['red','red', 'black', 'black'], linestyle=[0,2,0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.9, 0.6], $
;       Titles=title_arr, Length=0.075, /Box, VSpace=1.15, /Background, $
;       BG_Color='light grey', /AddCmd   ;, PSyms=[6,15]
  
  cgps_close
 
  
  stop
  

end