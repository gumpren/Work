pro Scatter_plot_2d_lasttime_ey
  
   Re=6371.0
   root_dir='C:\__Data\Datasave\2001_2009_median_30_pieces\'
   start=systime(1)
   compile_opt idl2
  ;;;  ________________________________part1_______________________
     
    a=findgen(280)
    t_beg=list(a,/ex)
    t_end=list(a,/ex)

    filename0=file_search('C:\__Data\OMNI\*.cdf')

    for jj=0,279 do begin
      if (jj le 139) then begin
        maxvalue=1000
        minvalue=0
      endif else begin
        maxvalue=0  
        minvalue=-1000
      endelse

     if (jj ge 0) and (jj le 139)  then duration=[(jj+5)*60.,(jj+6)*60.]
     if (jj ge 140) and (jj le 279)  then duration=[(jj-135)*60.,(jj-134)*60.]
   
 
   
     for ii=0,106 do begin             ;divided by year
       cdf2tplot,filename0[ii],varformat='BZ_GSM'
       get_data,'BZ_GSM',time0,BZ_GSM0
       append_array,time,time0
       append_array,BZ_GSM,BZ_GSM0

       if (((ii+1) mod 12) eq 0) or (ii eq 106) then begin
        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=0*60,duration=duration,nint=nint,tbeg=tbeg0,tend=tend0
        append_Array,tbeg1,tbeg0
        append_Array,tend1,tend0
        undefine,time,BZ_GSM
       endif
     endfor
      t_beg[jj]=tbeg1
      t_end[jj]=tend1
      undefine,tbeg1,tend1
      save,t_beg,t_end,$
        filename=root_dir+'scatter_time_interval_divided_by_Bz_yearly_normal.sav'
      print,(systime(1)-start)/60.
      
    endfor

    print,'a'
  
  
    save,t_beg,t_end,$
      filename=root_dir+'scatter_time_interval_divided_by_Bz_yearly_normal.sav'
    print,(systime(1)-start)/60.
    stop
  
  
  ;part_1_former
    restore,root_dir+'scatter_time_interval_divided_by_Bz_yearly_normal.sav'
    t_b=t_beg
    t_e=t_end
      aa=fltarr(30)
      for i=0,29 do begin
        aa[i]=N_ELEMENTS(t_end[i])
      endfor
  
  
    time_array=[15,25,35,45,55,65,75,85,95,105,115,125,135,145]*60.
    for i=14,1,-1 do begin
      tb1=t_b[i]
      te1=t_e[i]
      tb2=t_b[i-1]
      te2=t_e[i-1]
      append_array,tb2,tb1
      append_array,te2,tb1+time_array[i-1]
  
      t_beg[i-1]=tb2
      t_end[i-1]=te2
  
      tb11=t_b[i+15]
      te11=t_e[i+15]
      tb22=t_b[i+14]
      te22=t_e[i+14]
      append_array,tb22,tb11
      append_array,te22,tb11+time_array[i-1]
  
      t_beg[i+14]=tb22
      t_end[i+14]=te22
  
  
      print,i
    endfor
      t_beg.add,t_beg[15],15
      t_end.add,t_beg[15]+5*60.0,15
  
      t_beg.add,t_beg[0],0
      t_end.add,t_beg[0]+5*60.0,0
  
  
  
    bb=fltarr(32)
    for i=0,31 do begin
      bb[i]=N_ELEMENTS(t_end[i])
    endfor
  
    save,t_beg,t_end,$
          filename=root_dir+'scatter_time_interval_divided_by_Bz_yearly_add_former_time_32_pieces.sav'
  
  
    stop
  

































end