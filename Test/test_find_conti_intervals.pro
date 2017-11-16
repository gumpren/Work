pro test_find_conti_intervals
   
   cdf2tplot,'C:\__Data\OMNI\omni_hro_1min_20010101_v01.cdf',varformat='BZ_GSM'
   
   
   find_conti_intervals_mine,'BZ_GSM',-1000,0,margin=0*60,duration=[10,15]*60.0,nint=nint,tbeg=tbeg0,tend=tend0
   
   BZ_temp=tsample('BZ_GSM',[tbeg0[0],tend0[0]],times=t_c3fgm_temp)
   
   
   for i=17,nint-1 do begin
     BZ_temp=tsample('BZ_GSM',[tbeg0[i]-1*60.0,tend0[i]+1*60.0],times=t_c3fgm_temp)
     cgdisplay
     cgplot,t_c3fgm_temp,BZ_temp
     print,i
     append_array,BZ,BZ_temp
     append_array,t_c3fgm,t_c3fgm_temp
   endfor
   
   

   stop



end