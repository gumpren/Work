
;pro 
  
   root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
   restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_all_plus.sav'
   
   i=0
   time=t_c3cis_all[i]
   n=density_all[i]
   t=temperature_all[i]
   p=pressure_all[i]
   v=velocity_all[i]
   pos=pos_gsm_all[i]
   b=b_gsm_all[i]   
   h=h_re[i]
   k=k_re[i]
   hk=h_k_re[i]
   time_intervals=time_intervals(trange=['2001-01-01','2002-01-01'],/MONTHLY_RES)
   
   store_Data,'density',data={x:time,y:n}
   
   
   for index=0,N_ELEMENTS(time_intervals)-2,2 do begin
     tstart=time_intervals[index]
     tend=time_intervals[index+1]

     plot_trange=[tstart,tend]

     print,time_string(plot_trange)



     popen,'asd'+time_String(tstart,format=2),/ENCAPSULATED
     tplot,'density',TRANGE=plot_trange
     pclose

   endfor



end   