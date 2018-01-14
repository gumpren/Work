        ;+
           ; :Author: Gren
           ;-

pro scatter_plot_2d_H_K_X_Earthward_Tailward_lasttime_10minute_per_point
  h_Factor=1.0/(6.371^2*1.0e3)
  
  ;1W/m^2=6.371^2*1.0e3(1.0e15*erg/(Re^2*s))
  
  region_strs=['','_dawnflank','_duskflank','_near_dawnflank','_far_dawnflank','_near_duskflank','_far_duskflank']
  
  region_str=region_strs[0]
  namestr=''
  
    
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\'
    
  restore,filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+region_str+'.sav'
  vari=K_re
  vari_str='K_x'
  
  title_char=namestr+'scatter_plot_2d_'+vari_str+'_Earthward_Tailward_lasttime_10minute_per_point'+region_str
  
  x=10*(indgen(15))+5 
     
  median_vari_north_gt0=dblarr(15)
  median_vari_north_lt0=dblarr(15)
  median_vari_south_gt0=dblarr(15)
  median_vari_south_lt0=dblarr(15)
  
  average_vari_north_gt0=dblarr(15)
  average_vari_north_lt0=dblarr(15)
  average_vari_south_gt0=dblarr(15)
  average_vari_south_lt0=dblarr(15)
     
     
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
    yrange=[-3,1]
    ytickname=['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n']; hkx
    unit_str='(10!u16!nerg/(Re!u2!ns))'
  endif
  
  if (vari_str eq 'V_x' eq 1b)  then begin
   ; yrange=[-3,1]
   ; ytickname=['10!u-3!n','10!u-2!n','10!u-1!n','10!u0!n','10!u1!n']; hx
    unit_str='(Km/s)'
  endif
 
   
   
  for i=0,14 do begin
  
    if ( (size(vari[i]))[0] eq 1)  then begin
      vari1=vari[i]   
      vari2=vari[i+15]
    endif
    
    if ( (size(vari[i]))[0] eq 2)  then begin
      vari1=(vari[i])[*,0]
      vari2=(vari[i+15])[*,0]
    endif
    
    idx_north_gt0=where(vari1 gt 0)
    idx_north_lt0=where(vari1 lt 0)
    idx_south_gt0=where(vari2 gt 0)
    idx_south_lt0=where(vari2 lt 0)
    
    vari_north_gt0=get_varii(vari1[idx_north_gt0],log=1)
    vari_north_lt0=get_varii(-vari1[idx_north_lt0],log=1)
    vari_south_gt0=get_varii(vari2[idx_south_gt0],log=1)
    vari_south_lt0=get_varii(-vari2[idx_south_lt0],log=1)
    
    
                                                        
    median_vari_north_gt0[i]=median(vari_north_gt0)
    median_vari_north_lt0[i]=median(vari_north_lt0)
    median_vari_south_gt0[i]=median(vari_south_gt0)
    median_vari_south_lt0[i]=median(vari_south_lt0)

    average_vari_north_gt0[i]=average(vari_north_gt0,/nan)
    average_vari_north_lt0[i]=average(vari_north_lt0,/nan)
    average_vari_south_gt0[i]=average(vari_south_gt0,/nan)
    average_vari_south_lt0[i]=average(vari_south_lt0,/nan)
        
    append_Array,vari_north_gt01,vari_north_gt0
    append_Array,vari_north_lt01,vari_north_lt0
    append_Array,vari_south_gt01,vari_south_gt0
    append_Array,vari_south_lt01,vari_south_lt0
    
    append_Array,t_north_gt0,(t_last[i])[idx_north_gt0]
    append_Array,t_north_lt0,(t_last[i])[idx_north_lt0]
    append_Array,t_south_gt0,(t_last[i+15])[idx_south_gt0]
    append_Array,t_south_lt0,(t_last[i+15])[idx_south_lt0]

  endfor  
  
   
  tt_arr=hash()
  tt_arr[0,0]=t_north_gt0   &    tt_arr[0,1]=t_north_lt0
  tt_arr[1,0]=t_south_gt0   &    tt_arr[1,1]=t_south_lt0
  
  vari_arr=hash()
  vari_arr[0,0]=vari_north_gt01   &    vari_arr[0,1]=vari_north_lt01
  vari_arr[1,0]=vari_south_gt01   &    vari_arr[1,1]=vari_south_lt01
  
  median_arr=hash()
  median_arr[0,0]=median_vari_north_gt0   &    median_arr[0,1]=median_vari_north_lt0
  median_arr[1,0]=median_vari_south_gt0   &    median_arr[1,1]=median_vari_south_lt0
  
  average_arr=hash()
  average_arr[0,0]=average_vari_north_gt0   &    average_arr[0,1]=average_vari_north_lt0
  average_arr[1,0]=average_vari_south_gt0   &    average_arr[1,1]=average_vari_south_lt0

  
  
  title_arr=[['N-IMF Earthward','S-IMF Earthward'],$
             ['N-IMF Tailward','S-IMF Tailward']]+region_str
      
   cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   pos=set_plot_position(2,2,left=0.07,right=0.95,xgap=0.06,ygap=0.06,low=0.05,high=0.90)
   ;cgdisplay
   
   str_element,opt_plot,'charsize',1.2,/add  
   str_element,opt_plot,'yticks',yticks,/add
   str_element,opt_plot,'ytickname',ytickname,/add
   str_element,opt_plot,'xminor',2,/add
   str_element,opt_plot,'yminor',5,/add
                                                  ;there is something wrong about density's ytickname
      
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
      
      if j eq 0 then color_scatter='grey'
      if j eq 1 then color_scatter='grey'
      
      
     cgplot,tt_arr[i,j],vari_arr[i,j],pos=pos[i,j,*],color=color_scatter,psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot
     cgoplot,x,average_arr[i,j],xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange
     cgoplot,x,median_arr[i,j],xrange=xrange,color='red',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange

     labels_stamp,pos[i,j,*],title_arr[i,j],charsize=1.0,/left_right_center,/up_out
    endfor
   endfor
  
  cgtext,0.98,0.88,'median',alignment=0,charsize=1.0,font=0,color='red',/normal
  cgtext,0.98,0.85,'average',alignment=0,charsize=1.0,font=0,color='royal blue',/normal
  print,'a'
  cgps_close
  
  stop
  


 ; stop


end