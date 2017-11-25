pro test_time_intervals



;  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
;  according to this test, time intervals for (2margin) and (find_conti_intervals_mine) are not reliable
   restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
   t_beg=t_beg
   t_end=t_end
   
;   restore,'time_interval_divided_by_Bz_yearly_normal_5minute_per_point_add_former_time.sav'
;   restore,'time_interval_divided_by_Bz_yearly_normal_5minute_per_point_add_former_time_mine.sav'
   ;these two
;   


;   a0=fltarr(32)
;   a=fltarr(32)
;   
;   for i=0,31 do begin
;     a0[i]=N_ELEMENTS(tend0[i])
;     a[i]=N_ELEMENTS(t_end[i])  
;   endfor
;   

     
   a=14
  
   j=0
   
   for i=0,N_ELEMENTS(t_beg[a])-1 do begin
     
     tb_str=time_string((t_beg[a])[i],precision=-4,format=2)
     te_str=time_string((t_end[a])[i],precision=-4,format=2)
     filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')
     filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
     if ( (filename1 eq filename2) eq 1b) then begin
       filename=filename1
     endif else begin
       filename=[filename1,filename2]
     endelse
     cdf2tplot,filename,varformat=['BZ_GSM']
    
    
     bz_tmep=tsample('BZ_GSM',[(t_beg[a])[i]-0*60,(t_end[a])[i]+0*60],times=t_temp)
     indices=where(bz_tmep lt 0)
     
     cgdisplay  

     cgplot,t_temp,bz_tmep,yrange=[-10,10]
     
     print,i,'    ',N_ELEMENTS(indices)

     if (N_ELEMENTS(indices) ge 5) then stop

   endfor
   

   stop 



end