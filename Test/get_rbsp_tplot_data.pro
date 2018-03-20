pro get_rbsp_tplot_Data
  
  tplot_restore,filename='C:\Users\Gren\Desktop\rbspa_mom_hope_20150317.tplot'
  
  get_data,'Dens',time,density
  get_data,'Tpar',time,Tpar
  get_data,'Tperp',time,Tperp
  get_data,'Ppar',time,Ppar
  get_data,'Pperp',time,Pperp
  get_data,'Aniso',time,Aniso
  
  
  
  
  row=n_elements(time)
  data=fltarr(7,row)
  ;time_Str=time_string(time)
  data[0,*]=time
  data[1,*]=density
  data[2,*]=Tpar
  data[3,*]=Tperp
  data[4,*]=Ppar
  data[5,*]=Pperp
  data[6,*]=Aniso

  openw,lun,filepath('rbspa_mom_hope_20150317_data.txt',root_dir='C:\__Data\Datasave\'),/get_lun,width=5000
  printf,lun,data,format='(f19.1,1x,f10.1,1x,f10.1,1x,f10.1,5x,f4.1,5x,f4.1,5x,f4.1)'
 ; writeu,lun,data
  free_lun,lun
  
  
  stop


end