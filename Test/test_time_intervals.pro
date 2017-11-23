pro test_time_intervals

   root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
;  according to this test, time intervals for (2margin) and (find_conti_intervals_mine) are not reliable
   restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point.sav'
   tbeg0=t_beg
   tend0=t_end
   
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
;    
;   endfor
   
   
;   filename0=file_search('C:\__Data\OMNI\*.cdf')

;      for ii=0,106 do begin             ;divided by year
;        cdf2tplot,filename0[ii],varformat='BZ_GSM'
;        get_data,'BZ_GSM',time0,BZ_GSM0
;        append_array,time,time0
;        append_array,BZ_GSM,BZ_GSM0
;
;      endfor
;      save,time,BZ_GSM,filename='omni_imf_bz.sav'
     restore,filename='C:\__Data\Datasave\omni_imf_bz.sav'
     store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
      
   a=15
  
   j=0
   for i=0,N_ELEMENTS(t_beg[a])-1 do begin
     bz_tmep=tsample('BZ_GSM1',[(t_beg[a])[i]-0*60,(t_end[a])[i]+0*60],times=t_temp)
     indices=where(bz_tmep lt 0)
     
     cgdisplay
     cgplot,t_temp,bz_tmep,yrange=[-10,10]
     
     print,N_ELEMENTS(indices)
     if (N_ELEMENTS(indices) ge 4) then stop
    ; aaa=in_set((t_beg[a])[i],(tbeg0[a])[i]) 
     ; stop
   endfor
   

   stop 



end