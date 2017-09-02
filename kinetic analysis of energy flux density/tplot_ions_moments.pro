pro tplot_ions_moments
   date='2002-07-30'
   timespan, date+'/17:45:01',25,/minutes
   init_crib_colors
   
   TPLOT_RESTORE,filename='C:\__Data\Datasave\Kinetic analysis\C1_moments_data_2002-07-30.tplot'
 
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'Qtotal_H+K(Q)_compare_'+date,xsize=6,ysize=4.0,font=0,units='inches'

   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options, 'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,6]

   options, 'Vxgsm',ytitle='Vx(km/s)',labflag=-1
   options, 'Qtotal_H_K_xcompare',ytitle='Qtotal_x/(H+K)',labels=['Q_total','H+K'],labflag=-1
   options, 'Qtotal_H_Q_xcompare',ytitle='Qtotal_x/(H+Q)',labels=['Q_total','H+Q'],labflag=-1
   tplot,['Vxgsm','Qtotal_H_K_xcompare','Qtotal_H_Q_xcompare']
   pclose

   stop
   
  
  
  
   
   ;tplot n_vxyz_t_compare
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'n_vxyz_t_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
   
   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,4,6]
   
   options, 'n_compare',ytitle='N(cm!u-3!n!x)',labels=['N_obs','N','N1'],labflag=-1
   options, 'vx_compare',ytitle='Vx(km/s)',labels=['Vx_obs','Vx','Vx1'],labflag=-1
   options, 'vy_compare',ytitle='Vy(km/s)',labels=['Vy_obs','Vy','Vy1'],labflag=-1
   options, 'vz_compare',ytitle='Vz(km/s)',labels=['Vz_obs','Vz','Vz1'],labflag=-1
   options, 'p_compare',ytitle='P(nPa)',labels=['P_obs','P','P1'],labflag=-1
   options, 't_compare',ytitle='T(MK)',labels=['T_obs','T','T1'],labflag=-1
   tplot,['n_compare','vx_compare','vy_compare','vz_compare','t_compare']
   pclose
   
   stop
   
   
   
   
   
   ;tplot staus
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'n_vxyz_t_beta_1111'+date,xsize=6,ysize=4.0,font=0,units='inches'

   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,4,6]

   options, 'N',ytitle='N(cm!u-3!n!x)',labflag=-1
   options, 'Vgsm',ytitle='V(km/s)',labels=['Vx','Vy','Vz'],labflag=-1
   options, 'Bgsm',ytitle='B(nT)',labels=['Bx','By','Bz'],labflag=-1
   options, 'T',ytitle='T(MK)',labflag=-1
   options, 'betai',ytitle='Beta',labflag=-1,ylog=1
   tplot,['Vgsm','Bgsm','N','T','betai']
   get_data,'T',t,Temp
   store_data,'thresh',data={x:t,y:fltarr(n_elements(t))+0.3},dlimits={color:6,linestyles:2}
   tplot_panel,oplotvar='thresh',panel=4
   pclose
   stop
   
   
   
       
  ;tplot_Qxyz
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'Qtotal_xyz_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
   
   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.6
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,6]
   
   options, 'Qtotal_x_compare',ytitle='Qtotal_x(10!u16!n!xergs!u-1!n!xRe!u-2!n!x)',labels=['Qtotal_x','Qtotal_x1'],labflag=-1
   options, 'Qtotal_y_compare',ytitle='Qtotal_y(10!u16!n!xergs!u-1!n!xRe!u-2!n!x)',labels=['Qtotal_y','Qtotal_y1'],labflag=-1
   options, 'Qtotal_z_compare',ytitle='Qtotal_z(10!u16!n!xergs!u-1!n!xRe!u-2!n!x)',labels=['Qtotal_z','Qtotal_z1'],labflag=-1
   tplot,['Qtotal_x_compare','Qtotal_y_compare','Qtotal_z_compare']
   pclose
   stop
   
   
   
    
   ;tplot_p_tensor
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'P_tensor_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,4,6]
   
   options, 'p_compare',ytitle='P(nPa)',labels=['P_obs','P','P1'],labflag=-1
   options, 'pxx_compare',ytitle='Pxx(nPa)',labels=['Pxx_obs','Pxx','Pxx1'],labflag=-1
   options, 'pyy_compare',ytitle='Pyy(nPa)',labels=['Pyy_obs','Pyy','Pyy1'],labflag=-1
   options, 'pzz_compare',ytitle='Pzz(nPa)',labels=['Pzz_obs','Pzz','Pzz1'],labflag=-1
   options, 'pxy_compare',ytitle='Pxy(nPa)',labels=['Pxy_obs','Pxy','Pxy1'],labflag=-1
   options, 'pxz_compare',ytitle='Pxz(nPa)',labels=['Pxz_obs','Pxz','Pxz1'],labflag=-1
   options, 'pyz_compare',ytitle='Pyz(nPa)',labels=['Pyz_obs','Pyz','Pyz1'],labflag=-1
   tplot,['p_compare','pxx_compare','pyy_compare','pzz_compare','pxy_compare','pxz_compare','pyz_compare']
   pclose
   stop
   
   
   
   
   ;tplot_Qxyz_Hxyz_Kxyz
   popen,'E:\OneDrive\IDLworks\PS\kinetic analysis of energy flux density\'+'Q_H_K_xyz_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [10,10]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off
   options,'*',colors=[0,4,6]
   
   options, 'Vxgsm', ytitle='Vx(km/s)',labflag=-1
   options, 'Qtotal_compare',ytitle='Q_total',labels=['Q_totalx','Q_totaly','Q_totalz'],labflag=-1
   options, 'H_compare',ytitle='H',labels=['Hx','Hy','Hz'],labflag=-1
   options, 'K_compare',ytitle='K(10!u16!n!xergs!u-1!n!xRe!u-2!n!x)',labels=['Kx','Ky','Kz'],labflag=-1
   options, 'Q_compare',ytitle='Q',labels=['Qx','Qy','Qz'],labflag=-1
   tplot,['Vxgsm','Qtotal_compare','H_compare','K_compare','Q_compare']
   pclose
   
   stop


end
   