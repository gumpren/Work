pro test1234
  restore,filepath('OMNI_2001_2003_Bz_Vxyz_p.sav',root_dir='C:\__Data\Datasave')
  restore,filepath('C3_FGM_2001_2003_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave')
  restore,filepath('time_need_omni_to_c3fgm_2001_2003.sav',root_dir='C:\__Data\Datasave')
  
  t_omni=(time_omni-time_omni[0])/60000.0
  t_c3fgm=(time_c3fgm-time_omni[0])/60000.0
  
  data1=divide_bz(t_omni,Bz_imf,p,Vx)
  
  t_c3fgm1=t_c3fgm
  time_shift=shift(t_c3fgm1,1)
  gapindex=where(t_c3fgm1-time_shift gt 6.0/60.0)
  insert_gaps,t_c3fgm1,gapindex
 
  store_data,'time',data={x:t_c3fgm,y:t_c3fgm1}
  tinterpol_mxn,'time',data1.t2_omni,/nearest_neighbor,/overwrite
  get_data,'time',data=data
  stop
       
end
