pro cluster_energy_flux_density_statistics_data_3
   Re=6371.0 
   root_dir='C:\__Data\Datasave\2001_2009_median_new_3\' 
;;________________________________part1_______________________
;    compile_opt idl2
;    filename0=file_search('C:\__Data\OMNI\*.cdf')
;    tbeg=dblarr(6) & tend=dblarr(6)
;    for jj=0,5 do begin
;      for ii=0,106 do begin
;        cdf2tplot,filename0[ii],varformat='BZ_GSM'
;        case jj of
;          0:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[10*60.,30*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg1,tbeg0
;             append_array,tend1,tend0
;            end
;          1:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[30*60.,90*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg2,tbeg0
;             append_array,tend2,tend0
;            end
;          2:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[90*60.,6666666.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg3,tbeg0
;             append_array,tend3,tend0
;            end
;          3:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[10*60.,30*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg4,tbeg0
;             append_array,tend4,tend0
;            end
;          4:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[30*60.,90*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg5,tbeg0
;             append_array,tend5,tend0
;            end
;          5:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[90*60.,6666666.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg6,tbeg0
;             append_array,tend6,tend0
;            end
;        endcase
;     endfor
;   endfor
;  
;  for ii=0,n_elements(tend6)-1 do begin
;    append_array,tbeg5,tbeg6[ii]
;    append_array,tend5,tbeg6[ii]+89*60
;  endfor
;  
;  for ii=0,n_elements(tend5)-1 do begin
;    append_array,tbeg4,tbeg5[ii]
;    append_array,tend4,tbeg5[ii]+29*60
;  endfor
;  
;  
;  
;  for ii=0,n_elements(tend3)-1 do begin
;    append_array,tbeg2,tbeg3[ii]
;    append_array,tend2,tbeg3[ii]+89*60
;  endfor
;
;  for ii=0,n_elements(tend2)-1 do begin
;    append_array,tbeg1,tbeg2[ii]
;    append_array,tend1,tbeg2[ii]+29*60
;  endfor
;  
;  
;  t_beg=create_struct('tbeg1',tbeg1,'tbeg2',tbeg2,'tbeg3',tbeg3,'tbeg4',tbeg4,'tbeg5',tbeg5,'tbeg6',tbeg6)
;  t_end=create_struct('tend1',tend1,'tend2',tend2,'tend3',tend3,'tend4',tend4,'tend5',tend5,'tend6',tend6)
;  
;  save,t_beg,t_end,$
;    filename=root_dir+'time_interval_divided_by_Bz.sav'
;  
;  stop
;   


; ;______________________________part2_______________________
;  
;  restore,root_dir+'time_interval_divided_by_Bz.sav'
;  start=systime(1)
;  for kk=0 ,5 do begin
;    
;    case kk  of
;      0:begin
;         tbeg=t_beg.tbeg1
;         tend=t_end.tend1
;        end
;      1:begin
;         tbeg=t_beg.tbeg2
;         tend=t_end.tend2
;        end
;      2:begin
;         tbeg=t_beg.tbeg3
;         tend=t_end.tend3
;        end
;      3:begin
;         tbeg=t_beg.tbeg4
;         tend=t_end.tend4
;        end
;      4:begin
;         tbeg=t_beg.tbeg5
;         tend=t_end.tend5
;        end
;      5:begin
;         tbeg=t_beg.tbeg6
;         tend=t_end.tend6
;        end
;    endcase
;  names=['_BZgt0_10_30','_BZgt0_30_90','_BZgt0_gt_90','_BZle0_10_30','_BZle0_30_90','_BZle0_gt_90']
;  
;  
;  for ii=0,8 do begin
;    year='200'+strcompress(ii+1,/remove)
;  
;    filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
;    cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
;    ; newname=['B_mag','B_gse','pos_gse']
;  
;  
;    filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
;    cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
;      'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
;  
;    factor_to_kev=1.0e6/(1000.0*11600)
;    calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
;    calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
;    calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
;    cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
;    cotrans,'pos_gse','pos_gsm',/gse2gsm
;    cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
;    calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
;    calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
;  
;    ;clean_spikes,'pressure',nsmooth=10
; 
;    tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;  
;    beta_fac=1.0e-9/(1.0e-9)^2
;    miu0=!pi*4e-7
;    calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
;    tclip,'Beta',0.3,10000
;    tdeflag,'Beta_clip','remove_nan'                 ; beta identified
;  
;    tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    get_data,'pos_gsm_interp',time,pos_gsm_interp
;  
;    index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
;    time1=time[index]
;    pos_gsm_interp=pos_gsm_interp[index,*]          ;  plasma sheet identified
;  
;    store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
;  
;    tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;    tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;  
;    ;some removed bad points will come back when doing interpol
;    ;      rbsp_remove_spikes,'pressure_interp',/samename
;    ;      rbsp_remove_spikes,'temperature_interp',/samename
;    ;      rbsp_remove_spikes,'velocity_gsm_interp',/samename
;    ;      rbsp_remove_spikes,'density_interp',/samename            ;remove bad points
;    ;
;    ;      tdeflag,'pressure_interp','remove_nan',/overwrite
;    ;      tdeflag,'temperature_interp','remove_nan',/overwrite
;    ;      tdeflag,'velocity_gsm_interp','remove_nan',/overwrite
;    ;      tdeflag,'density_interp','remove_nan',/overwrite
;    ;                                                    ; bad points in different variables are located in different positions in array list
;  
;    index=strfilter(time_string(tend,pre=-5),year,count=count,/index)
;  
;    for jj=index[0],index[count-1] do begin
;      tic
;      B_total_temp=tsample('B_total_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;      B_gsm_temp=tsample('B_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;      pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;  
;      if is_array(B_gsm_temp) then begin
;        append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
;        append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
;        append_Array,B_gsm,TEMPORARY(B_gsm_temp)
;        append_Array,B_total,TEMPORARY(B_total_temp)
;      endif
;  
;      density_temp=tsample('density_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;      velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;      temperature_temp=tsample('temperature_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;      pressure_temp=tsample('pressure_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;  
;      if is_array(density_temp) then begin
;        append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
;        append_Array,density,TEMPORARY(density_temp)
;        append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
;        append_Array,temperature,TEMPORARY(temperature_temp)
;        append_Array,pressure,TEMPORARY(pressure_temp)
;      endif
;  
;      print,jj
;      toc
;  
;    endfor
;  
;    append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
;    append_Array,pos_gsm1,TEMPORARY(pos_gsm)
;    append_Array,B_gsm1,TEMPORARY(B_gsm)
;    append_Array,B_total1,TEMPORARY(B_total)
;  
;    append_Array,t_c3cis1,TEMPORARY(t_c3cis)
;    append_Array,density1,TEMPORARY(density)
;    append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
;    append_Array,temperature1,TEMPORARY(temperature)
;    append_Array,pressure1,TEMPORARY(pressure)
;  
;    del_data,'*'
;    print,ii
;  
;  endfor
;  
;  
;;  save_time_c3fgmcis=(systime(1)-start)/3600.0
;;  print,'save_time ',save_time_c3fgmcis,' hour'
;;  save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'
;;  
;  save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,$
;    filename=root_dir+'c3_fgmcis_data_selected_'+names[kk]+'.sav'
;  
;  undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1
;  endfor
;  
;  save_time_c3fgmcis=(systime(1)-start)/3600.0
;  print,'save_time ',save_time_c3fgmcis,' hour'
;  
;  stop
;  
  
;________________________________part3_______________________  
 


    root_dir='C:\__Data\Datasave\2001_2009_median_new_3\'
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
    filename=file_search(root_dir+'c3_fgmcis_data_selected__BZ'+'*.sav')

    counts=dblarr(6)


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

    t_c3cis=list(a,/ex)
    B_gsm=list(a,/ex)
    pos_gsm=list(a,/ex)
    density=list(a,/ex)
    temperature=list(a,/ex)
    pressure=list(a,/ex)
    velocity_gsm=list(a,/ex)
    tt_bbf=list(a,/ex)


    for i=0,5 do begin
      restore,filename[i]
      counts[i]=n_elements(t_c3cis1)

      ;raw_data
      indext=where(temperature1 lt 32)    ;T [0.005,32] KeV
      indexv=where(abs((velocity_gsm1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
      indexn=where((density1[indext])[indexv] le 100.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,100]
      index_all=(([indext])[indexv])[indexn]

      t_c3cis[i]=t_c3cis1[index_all]
      density[i]=density1[index_all]
      temperature[i]=temperature1[index_all]
      pressure[i]=pressure1[index_all]
;      tt_bbf[i]=tt_bbf_save[index_all]

      B_gsm_x=B_gsm1[index_all,0]
      B_gsm_y=B_gsm1[index_all,1]
      B_gsm_z=B_gsm1[index_all,2]

      velocity_x=velocity_gsm1[index_all,0]
      velocity_y=velocity_gsm1[index_all,1]
      velocity_z=velocity_gsm1[index_all,2]

      B_gsm[i]=[[B_gsm_x],[B_gsm_y],[B_gsm_z]]
      velocity_gsm[i]=[[velocity_x],[velocity_y],[velocity_z]]

      pos_gsm_x=pos_gsm1[index_all,0]
      pos_gsm_y=pos_gsm1[index_all,1]
      pos_gsm_z=pos_gsm1[index_all,2]
      pos_gsm[i]=[[pos_gsm_x],[pos_gsm_y],[pos_gsm_z]]

      ;event_data
      
      eventimes[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],[],reverse_gap)
      event_n[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],density[i],reverse_gap)
      event_t[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],temperature[i],reverse_gap)
      event_p[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],pressure[i],reverse_gap)
      event_vx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,0],reverse_gap)
      event_vy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,1],reverse_gap)

      H_Re[i]=return_thermal_energy_flow_density(pressure[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
    ;    H_Re.(i)[idxh]=!values.f_nan
      event_hx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,0],reverse_gap)
      event_hy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,1],reverse_gap)


      K_Re[i]=return_kinetic_energy_flow_density(density[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
      event_kx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,0],reverse_gap)
      event_ky[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,1],reverse_gap)

      H_K_Re[i]=H_Re[i]+K_Re[i]
      event_h_k_x[i]=event_hx[i]+event_kx[i]
      event_h_k_y[i]=event_hy[i]+event_ky[i]

    endfor

    save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re,K_Re,H_K_Re,     $
      event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_median3.sav'

    save,t_c3cis,B_gsm,pos_gsm,density,temperature,pressure,velocity_gsm,tt_bbf_save,    $
      filename=root_dir+'raw_data'+save_str+'_list_median3.sav'
stop




end
 







  
  
;  reverse_gap=5.0/10.0
;  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'+'_median'
;  filename=file_search(root_dir+'c3_fgmcis_data_selected__BZ'+'*.sav')
;  counts=make_array(30)
;  for i=0,5 do begin
;    restore,filename[i]
;    counts[i]=n_elements(t_c3cis1)
;  endfor
;
;  a=findgen(6)
;  eventimes=list(a,/ex)
;  event_n=list(a,/ex)
;  event_t=list(a,/ex)
;  event_p=list(a,/ex)
;  event_vx=list(a,/ex)
;  event_vy=list(a,/ex)
;  H_Re=list(a,/ex)
;  event_hx=list(a,/ex)
;  event_hy=list(a,/ex)
;  K_Re=list(a,/ex)
;  event_kx=list(a,/ex)
;  event_ky=list(a,/ex)
;  H_K_Re=list(a,/ex)
;  event_h_k_x=list(a,/ex)
;  event_h_k_y=list(a,/ex)
;
;
;  ;  eventimes=create_struct(                     $
;  ;    'eventimes1',make_array(10*reverse_gap,30*reverse_gap),'eventimes2',make_array(10*reverse_gap,30*reverse_gap),'eventimes3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'eventimes4',make_array(10*reverse_gap,30*reverse_gap),'eventimes5',make_array(10*reverse_gap,30*reverse_gap),'eventimes6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  event_n=create_struct(                     $
;  ;    'event_n1',make_array(10*reverse_gap,30*reverse_gap),'event_n2',make_array(10*reverse_gap,30*reverse_gap),'event_n3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'event_n4',make_array(10*reverse_gap,30*reverse_gap),'event_n5',make_array(10*reverse_gap,30*reverse_gap),'event_n6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  event_t=create_struct(                     $
;  ;    'event_t1',make_array(10*reverse_gap,30*reverse_gap),'event_t2',make_array(10*reverse_gap,30*reverse_gap),'event_t3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'event_t4',make_array(10*reverse_gap,30*reverse_gap),'event_t5',make_array(10*reverse_gap,30*reverse_gap),'event_t6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  event_p=create_struct(                     $
;  ;    'event_p1',make_array(10*reverse_gap,30*reverse_gap),'event_p2',make_array(10*reverse_gap,30*reverse_gap),'event_p3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'event_p4',make_array(10*reverse_gap,30*reverse_gap),'event_p5',make_array(10*reverse_gap,30*reverse_gap),'event_p6',make_array(10*reverse_gap,30*reverse_gap))
;  ;
;  ;
;  ;  event_vx=create_struct(                     $
;  ;    'event_vx1',make_array(10*reverse_gap,30*reverse_gap),'event_vx2',make_array(10*reverse_gap,30*reverse_gap),'event_vx3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'event_vx4',make_array(10*reverse_gap,30*reverse_gap),'event_vx5',make_array(10*reverse_gap,30*reverse_gap),'event_vx6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  event_vy=create_struct(                     $
;  ;    'event_vy1',make_array(10*reverse_gap,30*reverse_gap),'event_vy2',make_array(10*reverse_gap,30*reverse_gap),'event_vy3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'event_vy4',make_array(10*reverse_gap,30*reverse_gap),'event_vy5',make_array(10*reverse_gap,30*reverse_gap),'event_vy6',make_array(10*reverse_gap,30*reverse_gap))
;  ;
;  ;
;  ;  H_Re=create_struct(                     $
;  ;    'H_Re1',make_array(counts[0],3),'H_Re2',make_array(counts[1],3),'H_Re3',make_array(counts[2],3), $
;  ;    'H_Re4',make_array(counts[3],3),'H_Re5',make_array(counts[4],3),'H_Re6',make_array(counts[5],3))
;  ;  K_Re=create_struct(                     $
;  ;    'K_Re1',make_array(counts[0],3),'K_Re2',make_array(counts[1],3),'K_Re3',make_array(counts[2],3), $
;  ;    'K_Re4',make_array(counts[3],3),'K_Re5',make_array(counts[4],3),'K_Re6',make_array(counts[5],3))
;  ;  H_K_Re=create_struct(                     $
;  ;    'H_K_Re1',make_array(counts[0],3),'H_K_Re2',make_array(counts[1],3),'H_K_Re3',make_array(counts[2],3), $
;  ;    'H_K_Re4',make_array(counts[3],3),'H_K_Re5',make_array(counts[4],3),'H_K_Re6',make_array(counts[5],3))
;  ;
;  ;
;  ;
;  ;  H_Re_x=create_struct(                     $
;  ;    'H_Re_x1',make_array(10*reverse_gap,30*reverse_gap),'H_Re_x2',make_array(10*reverse_gap,30*reverse_gap),'H_Re_x3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'H_Re_x4',make_array(10*reverse_gap,30*reverse_gap),'H_Re_x5',make_array(10*reverse_gap,30*reverse_gap),'H_Re_x6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  H_Re_y=create_struct(                     $
;  ;    'H_Re_y1',make_array(10*reverse_gap,30*reverse_gap),'H_Re_y2',make_array(10*reverse_gap,30*reverse_gap),'H_Re_y3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'H_Re_y4',make_array(10*reverse_gap,30*reverse_gap),'H_Re_y5',make_array(10*reverse_gap,30*reverse_gap),'H_Re_y6',make_array(10*reverse_gap,30*reverse_gap))
;  ;
;  ;  K_Re_x=create_struct(                     $
;  ;    'K_Re_x1',make_array(10*reverse_gap,30*reverse_gap),'K_Re_x2',make_array(10*reverse_gap,30*reverse_gap),'K_Re_x3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'K_Re_x4',make_array(10*reverse_gap,30*reverse_gap),'K_Re_x5',make_array(10*reverse_gap,30*reverse_gap),'K_Re_x6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  K_Re_y=create_struct(                     $
;  ;    'K_Re_y1',make_array(10*reverse_gap,30*reverse_gap),'K_Re_y2',make_array(10*reverse_gap,30*reverse_gap),'K_Re_y3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'K_Re_y4',make_array(10*reverse_gap,30*reverse_gap),'K_Re_y5',make_array(10*reverse_gap,30*reverse_gap),'K_Re_y6',make_array(10*reverse_gap,30*reverse_gap))
;  ;
;  ;  H_K_Re_x=create_struct(                     $
;  ;    'H_K_Re_x1',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_x2',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_x3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'H_K_Re_x4',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_x5',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_x6',make_array(10*reverse_gap,30*reverse_gap))
;  ;  H_K_Re_y=create_struct(                     $
;  ;    'H_K_Re_y1',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_y2',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_y3',make_array(10*reverse_gap,30*reverse_gap), $
;  ;    'H_K_Re_y4',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_y5',make_array(10*reverse_gap,30*reverse_gap),'H_K_Re_y6',make_array(10*reverse_gap,30*reverse_gap))
;  ;
;  for i=0,5 do begin
;    restore,filename[i]
;    eventimes[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
;    event_n[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
;    event_t[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
;    event_p[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
;    event_vx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,0],reverse_gap)
;    event_vy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,1],reverse_gap)
;
;    H_Re[i]=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
;    ;    H_Re.(i)[idxh]=!values.f_nan
;    event_hx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,0],reverse_gap)
;    event_hy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,1],reverse_gap)
;
;
;    K_Re[i]=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;    event_kx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,0],reverse_gap)
;    event_ky[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,1],reverse_gap)
;
;    H_K_Re[i]=H_Re[i]+K_Re[i]
;    event_h_k_x[i]=event_hx[i]+event_kx[i]
;    event_h_k_y[i]=event_hy[i]+event_ky[i]
;    ;    pos_gsm.(i)=pos_gsm1
;    ;    velocity_gsm.(i)=velocity_gsm1
;    ;    t_c3cis.(i)=t_c3cis1
;    ;    density.(i)=density1
;    ;    temperature.(i)=temperature1
;    ;    pressure.(i)=pressure1
;    ;cgplot,pressure1,title='p[i]'
;    ;    eventimes.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
;    ;    event_n.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
;    ;    event_t.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
;    ;    event_p.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
;    ;    event_vx.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,0],reverse_gap)
;    ;    event_vy.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,1],reverse_gap)
;    ;
;    ;    H_Re.(i)=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;    ;;    idxh=where(abs(H_Re.(i)) gt 1000.0)
;    ;;    H_Re.(i)[idxh]=!values.f_nan
;    ;    H_Re_x.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re.(i)[*,0],reverse_gap)
;    ;    H_Re_y.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re.(i)[*,1],reverse_gap)
;    ;
;    ;
;    ;    K_Re.(i)=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;    ;    K_Re_x.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re.(i)[*,0],reverse_gap)
;    ;    K_Re_y.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re.(i)[*,1],reverse_gap)
;    ;
;    ;    H_K_Re.(i)=H_Re.(i)+K_Re.(i)
;    ;    H_K_Re_x.(i)=H_Re_x.(i)+K_Re_x.(i)
;    ;    H_K_Re_y.(i)=H_Re_y.(i)+K_Re_y.(i)
;    ;
;  endfor
;
;  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re,K_Re,H_K_Re,     $
;    event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list.sav'
;
;  stop
;
;
;
;
;
;
;
;
;
;
;
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZgt0_30_90.sav'
;  pos_gsm2=pos_gsm1    &   velocity_gsm2=velocity_gsm1      &     t_c3cis2=t_c3cis1
;  density2=density1    &   temperature2=temperature1        &     pressure2=pressure1
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZgt0_gt_90.sav'
;  pos_gsm3=pos_gsm1    &   velocity_gsm3=velocity_gsm1      &     t_c3cis3=t_c3cis1
;  density3=density1    &   temperature3=temperature1        &     pressure3=pressure1
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZle0_10_30.sav'
;  pos_gsm4=pos_gsm1    &   velocity_gsm4=velocity_gsm1      &     t_c3cis4=t_c3cis1
;  density4=density1    &   temperature4=temperature1        &     pressure4=pressure1
;
;  idxn4=where(abs(density4) gt 100.0)
;  density4[idxn4]=!values.f_nan
;
;  idxt4=where(abs(temperature4) gt 300.0)
;  temperature4[idxt4]=!values.f_nan
;
;  idxp4=where(abs(pressure4) gt 100.0)
;  pressure4[idxp4]=!values.f_nan
;
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZle0_30_90.sav'
;  pos_gsm5=pos_gsm1    &   velocity_gsm5=velocity_gsm1      &     t_c3cis5=t_c3cis1
;  density5=density1    &   temperature5=temperature1        &     pressure5=pressure1
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZle0_gt_90.sav'
;  pos_gsm6=pos_gsm1    &   velocity_gsm6=velocity_gsm1      &     t_c3cis6=t_c3cis1
;  density6=density1    &   temperature6=temperature1        &     pressure6=pressure1
;
;  restore,root_dir+'c3_fgmcis_data_selected__BZgt0_10_30.sav'
;  pos_gsm1=pos_gsm1    &   velocity_gsm1=velocity_gsm1      &     t_c3cis1=t_c3cis1
;  density1=density1    &   temperature1=temperature1        &     pressure1=pressure1
;
;
;
;  eventimes1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
;  eventimes2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],[],reverse_gap)
;  eventimes3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],[],reverse_gap)
;  eventimes4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],[],reverse_gap)
;  eventimes5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],[],reverse_gap)
;  eventimes6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],[],reverse_gap)
;  save,eventimes1,eventimes2,eventimes3,eventimes4,eventimes5,eventimes6,filename=root_dir+'eventimes'+save_str+'.sav'
;
;  event_n1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
;  event_n2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],density2,reverse_gap)
;  event_n3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],density3,reverse_gap)
;  event_n4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],density4,reverse_gap)   ; n4 200 error
;  event_n5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],density5,reverse_gap)
;  event_n6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],density6,reverse_gap)
;  save,event_n1,event_n2,event_n3,event_n4,event_n5,event_n6,filename=root_dir+'event_n'+save_str+'.sav'
;
;
;  event_t1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
;  event_t2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],temperature2,reverse_gap)
;  event_t3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],temperature3,reverse_gap)
;  event_t4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],temperature4,reverse_gap)  ;t4 27 error
;  event_t5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],temperature5,reverse_gap)
;  event_t6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],temperature6,reverse_gap)
;  save,event_t1,event_t2,event_t3,event_t4,event_t5,event_t6,filename=root_dir+'event_t'+save_str+'.sav'
;
;
;  event_p1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
;  event_p2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],pressure2,reverse_gap)
;  event_p3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],pressure3,reverse_gap)
;  event_p4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],pressure4,reverse_gap)
;  event_p5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],pressure5,reverse_gap)
;  event_p6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],pressure6,reverse_gap)
;  save,event_p1,event_p2,event_p3,event_p4,event_p5,event_p6,filename=root_dir+'event_p'+save_str+'.sav'
;
;  event_vx1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,0],reverse_gap)
;  event_vx2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],velocity_gsm2[*,0],reverse_gap)
;  event_vx3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],velocity_gsm3[*,0],reverse_gap)
;  event_vx4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],velocity_gsm4[*,0],reverse_gap)
;  event_vx5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],velocity_gsm5[*,0],reverse_gap)
;  event_vx6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],velocity_gsm6[*,0],reverse_gap)
;
;  event_vy1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,1],reverse_gap)
;  event_vy2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],velocity_gsm2[*,1],reverse_gap)
;  event_vy3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],velocity_gsm3[*,1],reverse_gap)
;  event_vy4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],velocity_gsm4[*,1],reverse_gap)
;  event_vy5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],velocity_gsm5[*,1],reverse_gap)
;  event_vy6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],velocity_gsm6[*,1],reverse_gap)
;  save,event_vx1,event_vx2,event_vx3,event_vx4,event_vx5,event_vx6,event_vy1,event_vy2,event_vy3,event_vy4,event_vy5,event_vy6,  $
;    filename=root_dir+'event_vxy'+save_str+'.sav'
;
;
;  H_Re1=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;  ;  idxh1=where(abs(H_Re1) gt 200.0)
;  ;  H_Re1[idxh1]=!values.f_nan
;  ;
;  H_Re2=return_thermal_energy_flow_density(pressure2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
;  ;  idxh2=where(abs(H_Re2) gt 200.0)
;  ;  H_Re2[idxh2]=!values.f_nan
;
;  H_Re3=return_thermal_energy_flow_density(pressure3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
;  ;  idxh3=where(abs(H_Re3) gt 200.0)
;  ;  H_Re3[idxh3]=!values.f_nan
;
;  H_Re4=return_thermal_energy_flow_density(pressure4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
;  ;  idxh4=where(abs(H_Re4) gt 200.0)
;  ;  H_Re4[idxh4]=!values.f_nan
;
;  H_Re5=return_thermal_energy_flow_density(pressure5,velocity_gsm5[*,0],velocity_gsm5[*,1],velocity_gsm5[*,2],2)
;  ;  idxh5=where(abs(H_Re5) gt 200.0)
;  ;  H_Re5[idxh5]=!values.f_nan
;
;  H_Re6=return_thermal_energy_flow_density(pressure6,velocity_gsm6[*,0],velocity_gsm6[*,1],velocity_gsm6[*,2],2)
;  ;  idxh6=where(abs(H_Re6) gt 200.0)
;  ;  H_Re6[idxh6]=!values.f_nan
;
;
;  K_Re1=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
;  ;  idxk1=where(abs(K_Re1) gt 20.0)
;  ;  K_Re1[idxk1]=!values.f_nan
;
;  K_Re2=return_kinetic_energy_flow_density(density2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
;  ;  idxk2=where(abs(K_Re2) gt 100.0)
;  ;  K_Re2[idxk2]=!values.f_nan
;
;  K_Re3=return_kinetic_energy_flow_density(density3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
;  ;  idxk3=where(abs(K_Re3) gt 100.0)
;  ;  K_Re3[idxk3]=!values.f_nan
;
;  K_Re4=return_kinetic_energy_flow_density(density4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
;  ;  idxk4=where(abs(K_Re4) gt 100.0)
;  ;  K_Re4[idxk4]=!values.f_nan
;
;  K_Re5=return_kinetic_energy_flow_density(density5,velocity_gsm5[*,0],velocity_gsm5[*,1],velocity_gsm5[*,2],2)
;  ;  idxk5=where(abs(K_Re5) gt 100.0)
;  ;  K_Re5[idxk5]=!values.f_nan
;
;  K_Re6=return_kinetic_energy_flow_density(density6,velocity_gsm6[*,0],velocity_gsm6[*,1],velocity_gsm6[*,2],2)
;  ;  idxk6=where(abs(K_Re6) gt 100.0)
;  ;  K_Re6[idxk6]=!values.f_nan
;
;
;  ;  H_Re_x1=return_vari_event_new(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,0],reverse_gap)
;  ;  H_Re_x2=return_vari_event_new(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,0],reverse_gap)
;  ;  H_Re_x3=return_vari_event_new(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,0],reverse_gap)
;  ;  H_Re_x4=return_vari_event_new(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,0],reverse_gap)  ; -1.0e4 error
;  ;  H_Re_x5=return_vari_event_new(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,0],reverse_gap)
;  ;  H_Re_x6=return_vari_event_new(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,0],reverse_gap)
;  ;
;  ;
;  ;  H_Re_y1=return_vari_event_new(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,1],reverse_gap)
;  ;  H_Re_y2=return_vari_event_new(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,1],reverse_gap)
;  ;  H_Re_y3=return_vari_event_new(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,1],reverse_gap)
;  ;  H_Re_y4=return_vari_event_new(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,1],reverse_gap)  ; -1.4e4 error
;  ;  H_Re_y5=return_vari_event_new(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,1],reverse_gap)
;  ;  H_Re_y6=return_vari_event_new(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,1],reverse_gap)
;  ;
;  ;  save,H_Re_x1,H_Re_x2,H_Re_x3,H_Re_x4,H_Re_x5,H_Re_x6,  $
;  ;       H_Re_y1,H_Re_y2,H_Re_y3,H_Re_y4,H_Re_y5,H_Re_y6,  $
;  ;       filename=root_dir+'H_Re_xy'+save_str+'_new2190.sav'
;
;
;
;
;  H_Re_x1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,0],reverse_gap)
;  H_Re_x2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,0],reverse_gap)
;  H_Re_x3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,0],reverse_gap)
;  H_Re_x4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,0],reverse_gap)  ; -1.0e4 error
;  H_Re_x5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,0],reverse_gap)
;  H_Re_x6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,0],reverse_gap)
;
;  H_Re_y1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,1],reverse_gap)
;  H_Re_y2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,1],reverse_gap)
;  H_Re_y3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,1],reverse_gap)
;  H_Re_y4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,1],reverse_gap)  ; -1.4e4 error
;  H_Re_y5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,1],reverse_gap)
;  H_Re_y6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,1],reverse_gap)
;  save,H_Re_x1,H_Re_x2,H_Re_x3,H_Re_x4,H_Re_x5,H_Re_x6,H_Re_y1,H_Re_y2,H_Re_y3,H_Re_y4,H_Re_y5,H_Re_y6,  $
;    filename=root_dir+'H_Re_xy'+save_str+'.sav'
;
;
;  K_Re_x1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,0],reverse_gap)
;  K_Re_x2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,0],reverse_gap)
;  K_Re_x3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,0],reverse_gap)
;  K_Re_x4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,0],reverse_gap)  ; -550 error
;  K_Re_x5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],K_Re5[*,0],reverse_gap)
;  K_Re_x6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],K_Re6[*,0],reverse_gap)    ; a big data 0.8
;
;  K_Re_y1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,1],reverse_gap)
;  K_Re_y2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,1],reverse_gap)
;  K_Re_y3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,1],reverse_gap)
;  K_Re_y4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,1],reverse_gap)  ; -730  error
;  K_Re_y5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],K_Re5[*,1],reverse_gap)
;  K_Re_y6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],K_Re6[*,1],reverse_gap)
;
;
;  save,K_Re_x1,K_Re_x2,K_Re_x3,K_Re_x4,K_Re_x5,K_Re_x6,K_Re_y1,K_Re_y2,K_Re_y3,K_Re_y4,K_Re_y5,K_Re_y6, $
;    filename=root_dir+'K_Re_xy'+save_str+'.sav'
;
;  stop