pro  cluster_EFD_statistics_data_all_quest
  ;1111  and  2222  get the same list, but 2222's list data size  is smaller than 1111's  why?
  ;          2222 restruct the list   
  ;   data link    1111:246M,  'C:\__Data\Datasave\2001_2009_6pieces_include_BBF\raw_data_2001_2009_gap1.000Re_list_all_plus_median3.sav'
  ;                2222;225M,  'C:\__Data\Datasave\2001_2009_6pieces_include_BBF\raw_data_2001_2009_gap1.000Re_list_all_median3_method1.sav'
  Re=6371.0
  root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  
  
   
  ;111111; ;  ________________________________method1___________bbf plus no_bbf data____________
  a=findgen(6)
  eventimes=list(a,/ex)
  event_n=list(a,/ex)
  event_t=list(a,/ex)
  event_p=list(a,/ex)
  event_vx=list(a,/ex)
  event_vy=list(a,/ex)
  H_Re=list(a,/ex)
  event_hx=list(a,/ex)
  event_hy=list(a,/ex)
  K_Re=list(a,/ex)
  event_kx=list(a,/ex)
  event_ky=list(a,/ex)
  H_K_Re=list(a,/ex)
  event_h_k_x=list(a,/ex)
  event_h_k_y=list(a,/ex)

  t_c3cis_all=list(a,/ex)
  B_gsm_all=list(a,/ex)
  pos_gsm_all=list(a,/ex)
  density_all=list(a,/ex)
  temperature_all=list(a,/ex)
  pressure_all=list(a,/ex)
  velocity_all=list(a,/ex)



  restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_bbf_median3.sav'
  b_gsm2=b_gsm
  density2=density
  pos_gsm2=pos_gsm
  pressure2=pressure
  temperature2=temperature
  t_c3cis2=t_c3cis
  velocity_bbf2=velocity_bbf

  ; undefine,b_gsm,density,pos_gsm,pressure,temperature,t_c3cis,velocity_no_bbf
  restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_nobbf_median3.sav'

  for i=0,5 do begin
    t_c3cis1=[t_c3cis2[i],t_c3cis[i]]
    temperature1=[temperature2[i],temperature[i]]
    pressure1=[pressure2[i],pressure[i]]
    density1=[density2[i],density[i]]
    pos_gsm1=[pos_gsm2[i],pos_gsm[i]]
    b_gsm1=[b_gsm2[i],b_gsm[i]]
    velocity_all1=[velocity_bbf2[i],velocity_no_bbf[i]]


    t_c3cis_all[i]=t_c3cis1
    density_all[i]=density1
    temperature_all[i]=temperature1
    pressure_all[i]=pressure1
    pos_gsm_all[i]=pos_gsm1
    b_gsm_all[i]=b_gsm1
    velocity_all[i]=velocity_all1

    ;event_data
    eventimes[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
    event_n[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
    event_t[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
    event_p[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
    event_vx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_all1[*,0],reverse_gap)
    event_vy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_all1[*,1],reverse_gap)

    H_Re[i]=return_thermal_energy_flow_density(pressure1,velocity_all1[*,0],velocity_all1[*,1],velocity_all1[*,2],2)
    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
    ;    H_Re.(i)[idxh]=!values.f_nan
    event_hx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,0],reverse_gap)
    event_hy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,1],reverse_gap)


    K_Re[i]=return_kinetic_energy_flow_density(density1,velocity_all1[*,0],velocity_all1[*,1],velocity_all1[*,2],2)
    event_kx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,0],reverse_gap)
    event_ky[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,1],reverse_gap)

    H_K_Re[i]=H_Re[i]+K_Re[i]
    event_h_k_x[i]=event_hx[i]+event_kx[i]
    event_h_k_y[i]=event_hy[i]+event_ky[i]

  endfor

  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,     $
    event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_all_plus_median3.sav'

  save,t_c3cis_all,pos_gsm_all,b_gsm_all,density_all,temperature_all,pressure_all,velocity_all,H_Re,K_Re,H_K_Re,    $
    filename=root_dir+'raw_data'+save_str+'_list_all_plus_median3.sav'
  stop


  ; 2222222;  ________________________________method1___________bbf plus no_bbf data____________
  a=findgen(6)
  eventimes=list(a,/ex)
  event_n=list(a,/ex)
  event_t=list(a,/ex)
  event_p=list(a,/ex)
  event_vx=list(a,/ex)
  event_vy=list(a,/ex)
  H_Re=list(a,/ex)
  event_hx=list(a,/ex)
  event_hy=list(a,/ex)
  K_Re=list(a,/ex)
  event_kx=list(a,/ex)
  event_ky=list(a,/ex)
  H_K_Re=list(a,/ex)
  event_h_k_x=list(a,/ex)
  event_h_k_y=list(a,/ex)

  t_c3cis_all=list(a,/ex)
  B_gsm_all=list(a,/ex)
  pos_gsm_all=list(a,/ex)
  density_all=list(a,/ex)
  temperature_all=list(a,/ex)
  pressure_all=list(a,/ex)
  velocity_all=list(a,/ex)



  restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_bbf_median3.sav'
  b_gsm2=b_gsm
  density2=density
  pos_gsm2=pos_gsm
  pressure2=pressure
  temperature2=temperature
  t_c3cis2=t_c3cis
  velocity_bbf2=velocity_bbf

  ; undefine,b_gsm,density,pos_gsm,pressure,temperature,t_c3cis,velocity_no_bbf
  restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_nobbf_median3.sav'

  for i=0,5 do begin
    t_c3cis1=[t_c3cis2[i],t_c3cis[i]]
    temperature1=[temperature2[i],temperature[i]]
    pressure1=[pressure2[i],pressure[i]]
    density1=[density2[i],density[i]]
    pos_gsm1=[pos_gsm2[i],pos_gsm[i]]
    b_gsm1=[b_gsm2[i],b_gsm[i]]
    velocity_all1=[velocity_bbf2[i],velocity_no_bbf[i]]


    indext=where(temperature1 lt 32)    ;T [0.005,32] KeV
    vvx=(velocity_all1[*,0])[indext]  &  vvy=(velocity_all1[*,1])[indext]  & vvz=(velocity_all1[*,2])[indext]
    indexv=where( sqrt(vvx^2+vvy^2+vvz^2) le 2500.0) ;indexv=where(abs((velocity_all1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
    indexn=where((density1[indext])[indexv] le 100.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,10]
    index_all=(([indext])[indexv])[indexn]

    t_c3cis[i]=t_c3cis1[index_all]
    density_all[i]=density1[index_all]
    temperature_all[i]=temperature1[index_all]
    pressure_all[i]=pressure1[index_all]

    B_gsm_x=B_gsm1[index_all,0]
    B_gsm_y=B_gsm1[index_all,1]
    B_gsm_z=B_gsm1[index_all,2]

    velocity_x=velocity_all1[index_all,0]
    velocity_y=velocity_all1[index_all,1]
    velocity_z=velocity_all1[index_all,2]

    pos_gsm_x=pos_gsm1[index_all,0]
    pos_gsm_y=pos_gsm1[index_all,1]
    pos_gsm_z=pos_gsm1[index_all,2]

    B_gsm_all[i]=[[B_gsm_x],[B_gsm_y],[B_gsm_z]]
    velocity_all[i]=[[velocity_x],[velocity_y],[velocity_z]]
    pos_gsm_all[i]=[[pos_gsm_x],[pos_gsm_y],[pos_gsm_z]]




    ;event_data
    eventimes[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],[],reverse_gap)
    event_n[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],density_all[i],reverse_gap)
    event_t[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],temperature_all[i],reverse_gap)
    event_p[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],pressure_all[i],reverse_gap)
    event_vx[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(velocity_all[i])[*,0],reverse_gap)
    event_vy[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(velocity_all[i])[*,1],reverse_gap)

    H_Re[i]=return_thermal_energy_flow_density(pressure_all[i],(velocity_all[i])[*,0],(velocity_all[i])[*,1],(velocity_all[i])[*,2],2)
    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
    ;    H_Re.(i)[idxh]=!values.f_nan
    event_hx[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(H_Re[i])[*,0],reverse_gap)
    event_hy[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(H_Re[i])[*,1],reverse_gap)


    K_Re[i]=return_kinetic_energy_flow_density(density_all[i],(velocity_all[i])[*,0],(velocity_all[i])[*,1],(velocity_all[i])[*,2],2)
    event_kx[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(K_Re[i])[*,0],reverse_gap)
    event_ky[i]=return_vari_event((pos_gsm_all[i])[*,0],(pos_gsm_all[i])[*,1],(K_Re[i])[*,1],reverse_gap)

    H_K_Re[i]=H_Re[i]+K_Re[i]
    event_h_k_x[i]=event_hx[i]+event_kx[i]
    event_h_k_y[i]=event_hy[i]+event_ky[i]

  endfor

  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,     $
    event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_all_median3_method1.sav'

  save,t_c3cis_all,pos_gsm_all,b_gsm_all,density_all,temperature_all,pressure_all,velocity_all,H_Re,K_Re,H_K_Re,    $
    filename=root_dir+'raw_data'+save_str+'_list_all_median3_method1.sav'
  stop












end