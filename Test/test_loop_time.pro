pro test_loop_time
   tstart=systime(1)
   root_dir='C:\__Data\Datasave\2001_2009_halfhour_per_point\'
   restore,root_dir+'time_interval_divided_by_Bz_yearly_add_former_halfhour_per_point.sav'
   
   restore,filename='C:\__Data\Datasave\omni_imf_bz.sav'
   store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
   
   a=14
   j=0
   for i=0,N_ELEMENTS(t_beg[a])-1 do begin
     bz_tmep=tsample('BZ_GSM1',[(t_beg[a])[i]-0*60,(t_end[a])[i]+0*60],times=t_temp)
     indices=where(bz_tmep le 0)


     if (N_ELEMENTS(indices) gt 8) then j=j+1
     ; aaa=in_set((t_beg[a])[i],(tbeg0[a])[i])
     ; stop
   endfor
   
   print,systime(1)-tstart

   stop




end