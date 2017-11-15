pro test_find_conti_intervals
   
   cdf2tplot,'C:\__Data\OMNI\omni_hro_1min_20010101_v01.cdf',varformat='BZ_GSM'
   
   
   find_conti_intervals,'BZ_GSM',-1000,0,margin=0*60,duration=[10,20]*60.0,nint=nint,tbeg=tbeg0,tend=tend0

   BZ_temp=tsample('BZ_GSM',[tbeg0[1],tEND0[1]],times=t_c3fgm_temp)
   

   stop



end