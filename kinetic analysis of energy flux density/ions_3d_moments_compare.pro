pro ions_3d_moments_compare

  mp=1.67e-27
  charge=1.6e-19
  kb=1.38e-23
  Re=6371.0
  Re_fac=(1.0e6*Re^2)/1.0e16   ; covert  erg/(m^2*s) to  1.0e16*erg/(Re^2*s)
  
  date='2002-07-30'
  timespan, date+'/17:45:01',25,/minutes
  init_crib_colors
  time_stamp,/off
    
  data_dir='C:\Users\ccvok\Desktop\CSA_Download_20161019_1340\'
  filename=data_dir+'C1_CP_CIS-HIA_HS_MAG_IONS_PSD\C1_CP_CIS-HIA_HS_MAG_IONS_PSD__20020730_174500_20020730_181000_V070905.cdf'
  filename1=data_dir+'C1_CP_CIS-HIA_ONBOARD_MOMENTS\C1_CP_CIS-HIA_ONBOARD_MOMENTS__20020730_174500_20020730_181000_V161018.cdf'
  filename2=data_dir+'C1_CP_FGM_SPIN\C1_CP_FGM_SPIN__20020730_174500_20020730_181000_V140305.cdf'
  cdf2tplot,filename,varformat='3d_ions__C1_CP_CIS-HIA_HS_MAG_IONS_PSD'
  cdf2tplot,filename1,varformat='*'
  cdf2tplot,filename2,varformat='*'
  loadcdf,filename,'delta_plus_energy_table__C1_CP_CIS-HIA_HS_MAG_IONS_PSD',max_delta_energy
  loadcdf,filename,'delta_minus_energy_table__C1_CP_CIS-HIA_HS_MAG_IONS_PSD',min_delta_energy
  loadcdf,filename1,'time_tags__C1_CP_CIS-HIA_ONBOARD_MOMENTS',time
  
  get_data,'B_vec_xyz_gse__C1_CP_FGM_SPIN',t1,B_gse
  get_data,'density__C1_CP_CIS-HIA_ONBOARD_MOMENTS',t,density ;data=density
  get_data,'velocity_gse__C1_CP_CIS-HIA_ONBOARD_MOMENTS',t,velocity_gse
  get_data,'temperature__C1_CP_CIS-HIA_ONBOARD_MOMENTS',t,temperature
  get_data,'pressure_tensor__C1_CP_CIS-HIA_ONBOARD_MOMENTS',t,pressure_tensor
  get_data,'pressure__C1_CP_CIS-HIA_ONBOARD_MOMENTS',t,pressure
  
  B_gsm=dblarr(n_elements(t1),3)
  velocity_gsm=dblarr(n_elements(time),3)
  for i=0L,n_elements(time)-1L do begin
    CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
    doy=julday(mo,dy,yr)-julday(01,01,yr)+1  
    geopack_recalc,yr,doy,hr,mn,sc
    geopack_conv_coord,B_gse[i,0],B_gse[i,1],B_gse[i,2],Bx_gsm,By_gsm,Bz_gsm,/from_gse,/to_gsm
    geopack_conv_coord,velocity_gse[i,0],velocity_gse[i,1],velocity_gse[i,2],velocity_xgsm,velocity_ygsm,velocity_zgsm,/from_gse,/to_gsm
    velocity_gsm[i,0]=velocity_xgsm
    velocity_gsm[i,1]=velocity_ygsm
    velocity_gsm[i,2]=velocity_zgsm
    B_gsm[i,0]=Bx_gsm 
    B_gsm[i,1]=By_gsm
    B_gsm[i,2]=Bz_gsm
  endfor
  
  
  tname = CLUSTER_GENERATE_CIS_HIA_DIST_TPLOTVAR(filename,probe='C1')
  dist = Cluster_get_dist(tname,trange=trange,species=species, probe=probe,integ_time=integ_time)
  a=*dist
  
  
  n=dblarr(n_elements(a))
  vx=n & vy=n & vz=n & pxx=n & pyy=n & pzz=n & pxy=n & pxz=n & pyz=n & tempera=n & Qx=n & Qy=n & Qz=n
  Qtotal_x=n  &  Qtotal_y=n  &  Qtotal_z=n
  n1=dblarr(n_elements(a))
  vx1=n1 & vy1=n1 & vz1=n1 & pxx1=n1 & pyy1=n1 & pzz1=n1 & pxy1=n1 & pxz1=n1 & pyz1=n1 & tempera1=n1
  Qx1=n1 & Qy1=n1 & Qz1=n1 & Qtotal_x1=n1  &  Qtotal_y1=n1  &  Qtotal_z1=n1
  
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
    Qx[j]=1.0e7*0.5*mp*total(value*velocity^3*cos(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxx[j]+vy[j]*pxy[j]+vz[j]*pxz[j])-5.0*vx[j]*(pxx[j]+pyy[j]+pzz[j])
    Qy[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxy[j]+vy[j]*pyy[j]+vz[j]*pyz[j])-5.0*vy[j]*(pxx[j]+pyy[j]+pzz[j])
    Qz[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].theta*!pi/180.0)^3)-10*(vx[j]*pxz[j]+vy[j]*pyz[j]+vz[j]*pzz[j])-5.0*vz[j]*(pxx[j]+pyy[j]+pzz[j])
    ;erg/(m^2*s)
    Qtotal_x[j]=1.0e7*0.5*mp*total(value*velocity^3*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    Qtotal_y[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    Qtotal_z[j]=1.0e7*0.5*mp*total(value*velocity^3*sin(a[j].theta*!pi/180.0))
    
    value1=a[j].data*velocity^2*dvelocity1*(a[j].dtheta*!pi/180.0)*(a[j].dphi*!pi/180.0)*cos(a[j].theta*!pi/180.0)
    n1[j]=1.0e-15*total(value1)
    vx1[j]=1.0e-15*1/n1[j]*total(value1*velocity*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vy1[j]=1.0e-15*1/n1[j]*total(value1*velocity*sin(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    vz1[j]=1.0e-15*1/n1[j]*total(value1*velocity*sin(a[j].theta*!pi/180.0))
    pxx1[j]=1.0e6*mp*total(value1*velocity^2*cos(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vx[j]*vx[j]
    pyy1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)^2*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vy[j]*vy[j]
    pzz1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vz[j]*vz[j]
    pxy1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0)^2)-1.0e21*mp*n1[j]*vx1[j]*vy1[j]
    pxz1[j]=1.0e6*mp*total(value1*velocity^2*cos(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n1[j]*vx1[j]*vz1[j]
    pyz1[j]=1.0e6*mp*total(value1*velocity^2*sin(a[j].phi*!pi/180.0)*sin(a[j].theta*!pi/180.0)*cos(a[j].theta*!pi/180.0))-1.0e21*mp*n1[j]*vy1[j]*vz1[j]
    tempera1[j]=1.0e-21*1/(3.0*n1[j]*kb)*(pxx1[j]+pyy1[j]+pzz1[j])
    Qx1[j]=1.0e7*0.5*mp*total(value1*velocity^3*cos(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxx1[j]+vy1[j]*pxy1[j]+vz1[j]*pxz1[j])-5.0*vx1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
    Qy1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].phi*!pi/180.0)^3*cos(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxy1[j]+vy1[j]*pyy1[j]+vz1[j]*pyz1[j])-5.0*vy1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
    Qz1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].theta*!pi/180.0)^3)-10*(vx1[j]*pxz1[j]+vy1[j]*pyz1[j]+vz1[j]*pzz1[j])-5.0*vz1[j]*(pxx1[j]+pyy1[j]+pzz1[j])
    Qtotal_x1[j]=1.0e7*0.5*mp*total(value1*velocity^3*cos(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    Qtotal_y1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].phi*!pi/180.0)*cos(a[j].theta*!pi/180.0))
    Qtotal_z1[j]=1.0e7*0.5*mp*total(value1*velocity^3*sin(a[j].theta*!pi/180.0))

  endfor
   
  Qx_Re=Qx*Re_fac  &  Qy_Re=Qy*Re_fac  &  Qz_Re=Qz*Re_fac  
  Qx1_Re=Qx1*Re_fac  &  Qy1_Re=Qy1*Re_fac  &  Qz1_Re=Qz1*Re_fac  
  Qtotal_x_Re=Qtotal_x*Re_fac   &  Qtotal_y_Re=Qtotal_y*Re_fac   &   Qtotal_z_Re=Qtotal_z*Re_fac
  Qtotal_x1_Re=Qtotal_x1*Re_fac  &  Qtotal_y1_Re=Qtotal_y1*Re_fac   &   Qtotal_z1_Re=Qtotal_z1*Re_fac
  
  Qtotal_Re=[[Qtotal_x1_Re],[Qtotal_y1_Re],[Qtotal_z1_Re]]
  Q_Re=[[Qx1_Re],[Qy1_Re],[Qz1_Re]]
  H_Re=return_thermal_energy_flow_density(pressure_tensor,velocity_gsm[*,0],velocity_gsm[*,1],velocity_gsm[*,2],2) 
  K_Re=return_kinetic_energy_flow_density(density,velocity_gsm[*,0],velocity_gsm[*,1],velocity_gsm[*,2],2)
  
  restore,filepath('H_Re.sav',root_dir='C:\__Data\Datasave\Kinetic analysis')
  
  betai=get_plasma_beta(B_gsm[*,0],B_gsm[*,1],B_gsm[*,2],pressure)
  ;split_vec,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS'
  p=(pxx+pyy+pzz)/3.0
  p1=(pxx1+pyy1+pzz1)/3.0 
     
  store_Data,'Vgsm',data={x:t,y:[[velocity_gsm[*,0]],[velocity_gsm[*,1]],[velocity_gsm[*,2]]]}
  store_Data,'Bgsm',data={x:t,y:[[B_gsm[*,0]],[B_gsm[*,1]],[B_gsm[*,2]]]}
  store_Data,'N',data={x:t,y:density}
  store_Data,'T',data={x:t,y:temperature}
  store_Data,'betai',data={x:t,y:betai}
  store_Data,'Vxgsm',data={x:t,y:velocity_gsm[*,0]}
  
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
  
  store_data,'Qx_compare',data={x:t,y:[[Qx_Re],[Qx1_Re]]}
  store_data,'Qy_compare',data={x:t,y:[[Qy_Re],[Qy1_Re]]}
  store_data,'Qz_compare',data={x:t,y:[[Qz_Re],[Qz1_Re]]}
  
  store_data,'Qtotal_x_compare',data={x:t,y:[[Qtotal_x_Re],[Qtotal_x1_Re]]}
  store_data,'Qtotal_y_compare',data={x:t,y:[[Qtotal_y_Re],[Qtotal_y1_Re]]}
  store_data,'Qtotal_z_compare',data={x:t,y:[[Qtotal_z_Re],[Qtotal_z1_Re]]}
  
  store_Data,'Qtotal_compare',data={x:t,y:[[Qtotal_Re[*,0]],[Qtotal_Re[*,1]],[Qtotal_Re[*,2]]]}
  store_Data,'H_compare',data={x:t,y:[[H_Re[*,0]],[H_Re[*,1]],[H_Re[*,2]]]}
  store_Data,'K_compare',data={x:t,y:[[K_Re[*,0]],[K_Re[*,1]],[K_Re[*,2]]]}
  store_Data,'Q_compare',data={x:t,y:[[Q_Re[*,0]],[Q_Re[*,1]],[Q_Re[*,2]]]}
  
  store_data,'Qtotal_H_K_xcompare',data={x:t,y:[[Qtotal_Re[*,0]],[H_Re[*,0]+K_Re[*,0]]]}
  store_data,'Qtotal_H_Q_xcompare',data={x:t,y:[[Qtotal_Re[*,0]],[H_Re[*,0]+Q_Re[*,0]]]}
  
  store_data,'H_mhd_k_compare_x',data={x:t,y:[[H_Re[*,0]],[H_mhd_Re[*,0]]]}
  store_data,'H_mhd_k_compare_y',data={x:t,y:[[H_Re[*,1]],[H_mhd_Re[*,1]]]}
  store_data,'H_mhd_k_compare_z',data={x:t,y:[[H_Re[*,2]],[H_mhd_Re[*,2]]]}

  
  TPLOT_SAVE,['Qx_compare','Qy_compare','Qz_compare','Q_compare','H_compare','K_compare','Qtotal_compare'$
      ,'n_compare','t_compare','vx_compare','vy_compare','vz_compare','p_compare','pxx_compare'$
      ,'pyy_compare','pzz_compare','pxy_compare','pxz_compare','pyz_compare','Vxgsm' $
      ,'Qtotal_x_compare','Qtotal_y_compare','Qtotal_z_compare','betai','Vgsm','Bgsm','N','T' $
      ,'Qtotal_H_K_xcompare','Qtotal_H_Q_xcompare'    $
       ],filename='C1_moments_data_'+date
  
  
  stop
  
  Qx_Re=Qx1_Re  &  Hx_Re=H_Re[*,0]  &  Kx_Re=K_Re[*,0]
  Bx=B_gsm[*,0]  &  Vx=velocity_gsm[*,0]   &  T=temperature
  save,Qtotal_x_Re,Qx_Re,Hx_Re,Kx_Re,Bx,T,Vx,filename='C:\__Data\Datasave\T_V_Q_H_K_x.sav'
  stop
end 