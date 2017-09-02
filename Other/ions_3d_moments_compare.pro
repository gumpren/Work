pro ions_3d_moments_compare

  mp=1.67e-27
  charge=1.6e-19
  kb=1.38e-23
  Re=6371.0
  
  date='2002-07-30'
  timespan, date+'/17:45:01',25,/minutes
  init_crib_colors
  time_stamp,/off
    
  data_dir='C:\Users\ccvok\Desktop\CSA_Download_20160726_1432\'
  filename=data_dir+'C3_CP_CIS-HIA_HS_MAG_IONS_PSD\C3_CP_CIS-HIA_HS_MAG_IONS_PSD__20020730_174500_20020730_181000_V070824.cdf'
  filename1=data_dir+'C3_CP_CIS-HIA_ONBOARD_MOMENTS\C3_CP_CIS-HIA_ONBOARD_MOMENTS__20020730_174500_20020730_181000_V130911.cdf'
  cdf2tplot,filename,varformat='3d_ions__C3_CP_CIS-HIA_HS_MAG_IONS_PSD'
  cdf2tplot,filename1,varformat='*'
  loadcdf,filename,'delta_plus_energy_table__C3_CP_CIS-HIA_HS_MAG_IONS_PSD',max_delta_energy
  loadcdf,filename,'delta_minus_energy_table__C3_CP_CIS-HIA_HS_MAG_IONS_PSD',min_delta_energy
  
  get_data,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t,density
  get_data,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t,velocity_gse
  get_data,'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t,temperature
  get_data,'pressure_tensor__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t,pressure_tensor
  get_data,'pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t,pressure
  
  tname = CLUSTER_GENERATE_CIS_HIA_DIST_TPLOTVAR(filename,probe='C3')
  dist = Cluster_get_dist(tname,trange=trange,species=species, probe=probe,integ_time=integ_time)
  a=*dist
  
  n=dblarr(n_elements(a))
  vx=n & vy=n & vz=n & pxx=n & pyy=n & pzz=n & pxy=n & pxz=n & pyz=n & tempera=n & qx=n & qy=n & qz=n
  n1=dblarr(n_elements(a))
  vx1=n1 & vy1=n1 & vz1=n1 & pxx1=n1 & pyy1=n1 & pzz1=n1 & pxy1=n1 & pxz1=n1 & pyz1=n1 & tempera1=n1
  qx1=n1 & qy1=n1 & qz1=n1

  
  for j=0,n_elements(a)-1 do begin
    a[j].energy=a[j].energy+(max_delta_energy-min_delta_energy)/2.0
    velocity=1/1000.0*sqrt(2*a[j].energy*charge/mp)

    dvelocity=make_array(31,16,8)
    dv=1/1000.0*sqrt(2*(a[j].energy+max_delta_energy)*charge/mp)-1/1000.0*sqrt(2*(a[j].energy-min_delta_energy)*charge/mp)
    ;dv=1/1000.0*sqrt(2*(max_delta_energy-min_delta_energy)*charge/mp)
    for i=0,29 do begin
      ; dvelocity[i,*,*]=velocity[i,*,*]-velocity[i+1,*,*]
      dvelocity[i,*,*]=dv[i]
    endfor

    dvelocity1=make_array(31,16,8)   
    dvelocity1_v2=make_array(31,16,8)
    dvelocity1_vv=make_array(31,16,8)
    ;dv1=1/1000.0*sqrt(2*(a[j].energy+max_delta_energy)*charge/mp)-1/1000.0*sqrt(2*(a[j].energy-min_delta_energy)*charge/mp)
    dv1=1/1000.0*(max_delta_energy+min_delta_energy)*charge/sqrt(2*a[j].energy*mp*charge)  ;by csa cis_moments_3d program
    dv1_v2=dv1/velocity^2
    dv1_vv=dv1/velocity
    for i=0,29 do begin
      dvelocity1[i,*,*]=dv1[i]
      dvelocity1_v2[i,*,*]=dv1_v2[i]
      dvelocity1_vv[i,*,*]=dv1_vv[i]
    endfor

    value=a[j].data*velocity^2*dvelocity*(a[j].dtheta*!pi/180.0)*(a[j].dphi*!pi/180.0)*cos(a[j].theta*!pi/180.0)
    n[j]=1.0e-15*total(value)
    vx[j]=1.0e-15*1/n[j]*total(value*velocity*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vy[j]=1.0e-15*1/n[j]*total(value*velocity*sin(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vz[j]=1.0e-15*1/n[j]*total(value*velocity*sin(a[j].theta*!pi/180.0))
    pxx[j]=1.0e6*mp*total(value*velocity^2*cos(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n[j]*vx[j]*vx[j] 
    pyy[j]=1.0e6*mp*total(value*velocity^2*sin(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n[j]*vy[j]*vy[j]
    pzz[j]=1.0e6*mp*total(value*velocity^2*sin(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n[j]*vy[j]*vy[j]
    pxy[j]=1.0e6*mp*total(value*velocity^2*sin(a[j].phi*!pi/180.0)*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n[j]*vx[j]*vy[j]
    pxz[j]=1.0e6*mp*total(value*velocity^2*cos(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n[j]*vx[j]*vz[j]
    pyz[j]=1.0e6*mp*total(value*velocity^2*sin(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n[j]*vy[j]*vz[j]
    tempera[j]=1.0e-21*1/(3.0*n[j]*kb)*(pxx[j]+pyy[j]+pzz[j])
    qx[j]=1.0e7*0.5*mp*total(value*velocity^3*cos(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxx[j]+vy[j]*pxy[j]+vz[j]*pxz[j])-5.0*vx[j]*(pxx[j]+pyy[j]+pzz[j])
    qy[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxy[j]+vy[j]*pyy[j]+vz[j]*pyz[j])-5.0*vy[j]*(pxx[j]+pyy[j]+pzz[j])
    qz[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxz[j]+vy[j]*pyz[j]+vz[j]*pzz[j])-5.0*vz[j]*(pxx[j]+pyy[j]+pzz[j])


    value1=a[j].data*velocity^2*dvelocity1*(a[j].dtheta*!pi/180.0)*(a[j].dphi*!pi/180.0)*cos(a[j].theta*!pi/180.0)
    n1[j]=1.0e-15*total(value1)
    vx1[j]=1.0e-15*1/n1[j]*total(value1*velocity*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vy1[j]=1.0e-15*1/n1[j]*total(value1*velocity*sin(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vz1[j]=1.0e-15*1/n1[j]*total(value1*velocity*sin(a[j].theta*!pi/180.0))
    pxx1[j]=1.0e6*mp*total(value1*velocity^2*cos(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vx[j]*vx[j]
    pyy1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vy[j]*vy[j]
    pzz1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vz[j]*vz[j]
    pxy1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vx1[j]*vy1[j]
    pxz1[j]=1. *mp*total(value1*velocity^2*cos(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n1[j]*vx1[j]*vz1[j]
    pyz1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n1[j]*vy1[j]*vz1[j]
    tempera1[j]=1.0e-21*1/(3.0*n1[j]*kb)*(pxx1[j]+pyy1[j]+pzz1[j])
    qx1[j]=1.0e7*0.5*mp*total(value1*velocity^3*cos(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxx1[j]+vy1[j]*pxy1[j]+vz1[j]*pxz1[j])-5.0*vx1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
    qy1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxy1[j]+vy1[j]*pyy1[j]+vz1[j]*pyz1[j])-5.0*vy1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
    qz1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxz1[j]+vy1[j]*pyz1[j]+vz1[j]*pzz1[j])-5.0*vz1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
   
  endfor
   
   
  ;split_vec,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS'
  p=(pxx+pyy+pzz)/3.0
  p1=(pxx1+pyy1+pzz1)/3.0 
  
    
  store_data,'n_compare',data={x:t,y:[[density],[n],[n1]]}
  store_data,'vx_compare',data={x:t,y:[[velocity_gse[*,0]],[vx],[vx1]]}
  store_data,'vy_compare',data={x:t,y:[[velocity_gse[*,1]],[vy],[vy1]]}
  store_data,'vz_compare',data={x:t,y:[[velocity_gse[*,2]],[vz],[vz1]]}
  store_data,'p_compare',data={x:t,y:[[pressure],[p],[p1]]}
  store_data,'t_compare',data={x:t,y:[[temperature],[tempera],[tempera1]]}
  
  store_data,'pxx_compare',data={x:t,y:[[pressure_tensor[*,0,0]],[pxx],[pxx1]]}
  store_data,'pyy_compare',data={x:t,y:[[pressure_tensor[*,1,1]],[pyy],[pyy1]]}
  store_data,'pzz_compare',data={x:t,y:[[pressure_tensor[*,2,2]],[pzz],[pzz1]]}
  store_data,'pxy_compare',data={x:t,y:[[pressure_tensor[*,0,1]],[pxy],[pxy1]]}
  store_data,'pxz_compare',data={x:t,y:[[pressure_tensor[*,0,2]],[pxz],[pxz1]]}
  store_data,'pyz_compare',data={x:t,y:[[pressure_tensor[*,1,2]],[pyz],[pyz1]]}
  
  popen,'E:\OneDrive\IDLworks\cluster_statistics\ps\'+'moments_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
 ; popen,'E:\OneDrive\IDLworks\cluster_statistics\ps\'+'p_tensor_compare'+date,xsize=6,ysize=4.0,font=0,units='inches'
  
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
  tplot,['n_compare','vx_compare','vy_compare','vz_compare','p_compare','t_compare']
 ; tplot,['pxx_compare','pyy_compare','pzz_compare','pxy_compare','pxz_compare','pyz_compare','p_compare']
  
  pclose
  
  stop
  
end 