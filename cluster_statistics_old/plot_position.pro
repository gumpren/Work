pro plot_position
  restore,filepath('C3_FGM_2001_2003_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave\2001_2003_median')
  restore,filepath('time_need_omni_to_c3fgm_2001_2003.sav',root_dir='C:\__Data\Datasave\2001_2003_median')
  restore,filepath('C3_CIS_2001_2003_n_vbxyz_p_T_need_addbeta.sav',root_dir='C:\__Data\Datasave\2001_2003_median')
  
  x=(x_pos[t_need1])[tfgm_need.tfgm_need1]
  y=(y_pos[t_need1])[tfgm_need.tfgm_need1]
  
  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  ;dx=(x1-x0-detax*(xno-1))/xno
  dx=0.15
  yno=4
  
  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\cluster_statistics\ps\'
  device,filename=output_dir+'position_2001_2003_median_addbeta.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,4,1,0,0]
  loadct,39
  device,decomposed=0
  
  plot,x,y,position=[x0,0.51,x0+dx,0.51+2.8*dx],psym=3
  
  device,/close_file
  set_plot,entry_device
  
end