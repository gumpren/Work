 pro cluster_energy_flux_density_statistics_data_2
    Re=6371.0
  ;________________________________part1_______________________
  ;  compile_opt idl2
  ;  filename0=file_search('C:\__Data\OMNI\*.cdf')
  ;  tbeg=dblarr(6) & tend=dblarr(6)
  ;  for jj=0,9 do begin
  ;    for ii=0,106 do begin
  ;      cdf2tplot,filename0[ii],varformat='BZ_GSM'
  ;      case jj of
  ;        0:begin
  ;           find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[5*60.,15*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg1,tbeg0
  ;           append_array,tend1,tend0
  ;          end
  ;        1:begin
  ;           find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[15*60.,30*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg2,tbeg0
  ;           append_array,tend2,tend0
  ;          end
  ;        2:begin
  ;           find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[30*60.,60*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg3,tbeg0
  ;           append_array,tend3,tend0
  ;          end
  ;        3:begin
  ;           find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[60*60.,90*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg4,tbeg0
  ;           append_array,tend4,tend0
  ;          end
  ;        4:begin
  ;           find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[90*60.,6666666.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg5,tbeg0
  ;           append_array,tend5,tend0
  ;          end  
  ;        5:begin
  ;           find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[5*60.,15*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg6,tbeg0
  ;           append_array,tend6,tend0
  ;          end
  ;        6:begin
  ;           find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[15*60.,30*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg7,tbeg0
  ;           append_array,tend7,tend0
  ;          end
  ;        7:begin
  ;           find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[30*60.,60*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg8,tbeg0
  ;           append_array,tend8,tend0
  ;          end
  ;        8:begin
  ;           find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[60*60.,90*60.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg9,tbeg0
  ;           append_array,tend9,tend0
  ;          end
  ;        9:begin
  ;           find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[90*60.,6666666.],nint=nint,tbeg=tbeg0,tend=tend0
  ;           append_array,tbeg10,tbeg0
  ;           append_array,tend10,tend0
  ;          end
  ;       endcase
  ;      endfor
  ;    endfor
  ;
  ;t_beg=create_struct('tbeg1',tbeg1,'tbeg2',tbeg2,'tbeg3',tbeg3,'tbeg4',tbeg4,'tbeg5',tbeg5,'tbeg6',tbeg6,'tbeg7',tbeg7,'tbeg8',tbeg8,'tbeg9',tbeg9,'tbeg10',tbeg10)
  ;t_end=create_struct('tend1',tend1,'tend2',tend2,'tend3',tend3,'tend4',tend4,'tend5',tend5,'tend6',tend6,'tend7',tend7,'tend8',tend8,'tend9',tend9,'tend10',tend10)
  ;
  ;save,t_beg,t_end,$
  ;  filename='C:\__Data\Datasave\2001_2009_median_new_2\time_interval_divided_by_Bz.sav'
  ;
  ;stop
  ;________________________________part2_______________________
  
;  ;_______________________________part2_______________________
;    restore,'C:\__Data\Datasave\2001_2009_median_new_2\time_interval_divided_by_Bz.sav'
;    for kk=0 ,9 do begin
;      start=systime(1)
;      case kk  of
;        0:begin
;           tbeg=t_beg.tbeg1
;           tend=t_end.tend1
;          end
;        1:begin
;           tbeg=t_beg.tbeg2
;           tend=t_end.tend2
;          end
;        2:begin
;           tbeg=t_beg.tbeg3
;           tend=t_end.tend3
;          end
;        3:begin
;           tbeg=t_beg.tbeg4
;           tend=t_end.tend4
;          end
;        4:begin
;           tbeg=t_beg.tbeg5
;           tend=t_end.tend5
;          end
;        5:begin
;           tbeg=t_beg.tbeg6
;           tend=t_end.tend6
;          end
;        6:begin
;           tbeg=t_beg.tbeg7
;           tend=t_end.tend7
;          end
;        7:begin
;           tbeg=t_beg.tbeg8
;           tend=t_end.tend8
;          end
;        8:begin
;           tbeg=t_beg.tbeg9
;           tend=t_end.tend9
;          end
;        9:begin
;           tbeg=t_beg.tbeg10
;           tend=t_end.tend10
;          end
;      endcase
;    names=['_BZgt0_5_15','_BZgt0_15_30','_BZgt0_30_60','_BZgt0_60_90','_BZgt0_gt_90',$
;           '_BZle0_5_15','_BZle0_15_30','_BZle0_30_60','_BZle0_60_90','_BZle0_gt_90']
;  
;  
;    for ii=0,8 do begin
;      year='200'+strcompress(ii+1,/remove)
;  
;      filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
;      cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
;      ; newname=['B_mag','B_gse','pos_gse']
;  
;  
;      filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
;      cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
;        'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
;  
;      factor_to_kev=1.0e6/(1000.0*11600)
;      calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
;      calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
;      calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
;      cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
;      cotrans,'pos_gse','pos_gsm',/gse2gsm
;      cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
;      calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
;      calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
;  
;      ;clean_spikes,'pressure',nsmooth=10
;  
;  
;      tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
;  
;      beta_fac=1.0e-9/(1.0e-9)^2
;      miu0=!pi*4e-7
;      calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
;      tclip,'Beta',0.3,10000
;      tdeflag,'Beta_clip','remove_nan'                 ; beta identified
;  
;      tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      get_data,'pos_gsm_interp',time,pos_gsm_interp
;  
;      index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
;      time1=time[index]
;      pos_gsm_interp=pos_gsm_interp[index,*]          ;  plasma sheet identified
;  
;      store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
;  
;      tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;  
;      ;some removed bad points will come back when doing interpol
;      ;      rbsp_remove_spikes,'pressure_interp',/samename
;      ;      rbsp_remove_spikes,'temperature_interp',/samename
;      ;      rbsp_remove_spikes,'velocity_gsm_interp',/samename
;      ;      rbsp_remove_spikes,'density_interp',/samename            ;remove bad points
;      ;
;      ;      tdeflag,'pressure_interp','remove_nan',/overwrite
;      ;      tdeflag,'temperature_interp','remove_nan',/overwrite
;      ;      tdeflag,'velocity_gsm_interp','remove_nan',/overwrite
;      ;      tdeflag,'density_interp','remove_nan',/overwrite
;      ;                                                    ; bad points in different variables are located in different positions in array list
;  
;      index=strfilter(time_string(tend,pre=-5),year,count=count,/index)
;  
;      for jj=index[0],index[count-1] do begin
;        tic
;        B_total_temp=tsample('B_total_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;        B_gsm_temp=tsample('B_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;        pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
;  
;        if is_array(B_gsm_temp) then begin
;          append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
;          append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
;          append_Array,B_gsm,TEMPORARY(B_gsm_temp)
;          append_Array,B_total,TEMPORARY(B_total_temp)
;        endif
;  
;        density_temp=tsample('density_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;        velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;        temperature_temp=tsample('temperature_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;        pressure_temp=tsample('pressure_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
;  
;        if is_array(density_temp) then begin
;          append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
;          append_Array,density,TEMPORARY(density_temp)
;          append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
;          append_Array,temperature,TEMPORARY(temperature_temp)
;          append_Array,pressure,TEMPORARY(pressure_temp)
;        endif
;  
;        print,jj
;        toc
;  
;      endfor
;  
;      append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
;      append_Array,pos_gsm1,TEMPORARY(pos_gsm)
;      append_Array,B_gsm1,TEMPORARY(B_gsm)
;      append_Array,B_total1,TEMPORARY(B_total)
;  
;      append_Array,t_c3cis1,TEMPORARY(t_c3cis)
;      append_Array,density1,TEMPORARY(density)
;      append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
;      append_Array,temperature1,TEMPORARY(temperature)
;      append_Array,pressure1,TEMPORARY(pressure)
;  
;      del_data,'*'
;      print,ii
;  
;    endfor
;  
;  
;    save_time_c3fgmcis=(systime(1)-start)/3600.0
;    print,'save_time ',save_time_c3fgmcis,' hour'
;    save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'
;  
;    save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,$
;      filename='C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected_'+names[kk]+'.sav'
;  
;    undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1
;  endfor
;  
;    stop
  
  ;________________________________part3_______________________
  
  
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  root_dir='C:\__Data\Datasave\2001_2009_median_new_2\'
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZgt0_15_30.sav'
  pos_gsm2=pos_gsm1    &   velocity_gsm2=velocity_gsm1      &     t_c3cis2=t_c3cis1
  density2=density1    &   temperature2=temperature1        &     pressure2=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZgt0_30_60.sav'
  pos_gsm3=pos_gsm1    &   velocity_gsm3=velocity_gsm1      &     t_c3cis3=t_c3cis1
  density3=density1    &   temperature3=temperature1        &     pressure3=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZgt0_60_90.sav'
  pos_gsm4=pos_gsm1    &   velocity_gsm4=velocity_gsm1      &     t_c3cis4=t_c3cis1
  density4=density1    &   temperature4=temperature1        &     pressure4=pressure1

  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZgt0_gt_90.sav'
  pos_gsm5=pos_gsm1    &   velocity_gsm5=velocity_gsm1      &     t_c3cis5=t_c3cis1
  density5=density1    &   temperature5=temperature1        &     pressure5=pressure1

  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZle0_5_15.sav'
  pos_gsm6=pos_gsm1    &   velocity_gsm6=velocity_gsm1      &     t_c3cis6=t_c3cis1
  density6=density1    &   temperature6=temperature1        &     pressure6=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZle0_15_30.sav'
  pos_gsm7=pos_gsm1    &   velocity_gsm7=velocity_gsm1      &     t_c3cis7=t_c3cis1
  density7=density1    &   temperature7=temperature1        &     pressure7=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZle0_30_60.sav'
  pos_gsm8=pos_gsm1    &   velocity_gsm8=velocity_gsm1      &     t_c3cis8=t_c3cis1
  density8=density1    &   temperature8=temperature1        &     pressure8=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZle0_60_90.sav'
  pos_gsm9=pos_gsm1    &   velocity_gsm9=velocity_gsm1      &     t_c3cis9=t_c3cis1
  density9=density1    &   temperature9=temperature1        &     pressure9=pressure1
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZle0_gt_90.sav'
  pos_gsm10=pos_gsm1    &   velocity_gsm10=velocity_gsm1      &     t_c3cis10=t_c3cis1
  density10=density1    &   temperature10=temperature1        &     pressure10=pressure1
  
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_2\c3_fgmcis_data_selected__BZgt0_5_15.sav'
  pos_gsm1=pos_gsm1    &   velocity_gsm1=velocity_gsm1      &     t_c3cis1=t_c3cis1
  density1=density1    &   temperature1=temperature1        &     pressure1=pressure1
  
  
;  eventimes1=return_vari_event_new(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
;  eventimes2=return_vari_event_new(pos_gsm2[*,0],pos_gsm2[*,1],[],reverse_gap)
;  eventimes3=return_vari_event_new(pos_gsm3[*,0],pos_gsm3[*,1],[],reverse_gap)
;  eventimes4=return_vari_event_new(pos_gsm4[*,0],pos_gsm4[*,1],[],reverse_gap)
;  eventimes5=return_vari_event_new(pos_gsm5[*,0],pos_gsm5[*,1],[],reverse_gap)
;  eventimes6=return_vari_event_new(pos_gsm6[*,0],pos_gsm6[*,1],[],reverse_gap)
;  save,eventimes1,eventimes2,eventimes3,eventimes4,eventimes5,eventimes6,filename=root_dir+'eventimes'+save_str+'.sav'
;  
;  event_n1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
;  event_n2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],density2,reverse_gap)
;  event_n3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],density3,reverse_gap)
;  event_n4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],density4,reverse_gap)
;  event_n5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],density5,reverse_gap)
;  event_n6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],density6,reverse_gap)
;  save,event_n1,event_n2,event_n3,event_n4,event_n5,event_n6,filename=root_dir+'event_n'+save_str+'.sav'
;  
;  
;  event_t1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
;  event_t2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],temperature2,reverse_gap)
;  event_t3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],temperature3,reverse_gap)  ;
;  event_t4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],temperature4,reverse_gap)
;  event_t5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],temperature5,reverse_gap)
;  event_t6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],temperature6,reverse_gap)
;  save,event_t1,event_t2,event_t3,event_t4,event_t5,event_t6,filename=root_dir+'event_t'+save_str+'.sav'
;  
;  
;  event_p1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
;  event_p2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],pressure2,reverse_gap)
;  event_p3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],pressure3,reverse_gap)  ;1000 npa error
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
  idxp7=where(abs(pressure7) gt 100.0)
  pressure7[idxp7]=!values.f_nan
  
  H_Re1=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
  H_Re2=return_thermal_energy_flow_density(pressure2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
  H_Re3=return_thermal_energy_flow_density(pressure3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
  H_Re4=return_thermal_energy_flow_density(pressure4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
  H_Re5=return_thermal_energy_flow_density(pressure5,velocity_gsm5[*,0],velocity_gsm5[*,1],velocity_gsm5[*,2],2)
  H_Re6=return_thermal_energy_flow_density(pressure6,velocity_gsm6[*,0],velocity_gsm6[*,1],velocity_gsm6[*,2],2)
  H_Re7=return_thermal_energy_flow_density(pressure7,velocity_gsm7[*,0],velocity_gsm7[*,1],velocity_gsm7[*,2],2)
  H_Re8=return_thermal_energy_flow_density(pressure8,velocity_gsm8[*,0],velocity_gsm8[*,1],velocity_gsm8[*,2],2)
  H_Re9=return_thermal_energy_flow_density(pressure9,velocity_gsm9[*,0],velocity_gsm9[*,1],velocity_gsm9[*,2],2)
  H_Re10=return_thermal_energy_flow_density(pressure10,velocity_gsm10[*,0],velocity_gsm10[*,1],velocity_gsm10[*,2],2)


  H_Re_x1=return_vari_event_new(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,0],reverse_gap)
  H_Re_x2=return_vari_event_new(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,0],reverse_gap)
  H_Re_x3=return_vari_event_new(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,0],reverse_gap)
  H_Re_x4=return_vari_event_new(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,0],reverse_gap)  ; -1.0e4 error
  H_Re_x5=return_vari_event_new(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,0],reverse_gap)
  H_Re_x6=return_vari_event_new(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,0],reverse_gap)
  H_Re_x7=return_vari_event_new(pos_gsm7[*,0],pos_gsm7[*,1],H_Re7[*,0],reverse_gap)
  H_Re_x8=return_vari_event_new(pos_gsm8[*,0],pos_gsm8[*,1],H_Re8[*,0],reverse_gap)
  H_Re_x9=return_vari_event_new(pos_gsm9[*,0],pos_gsm9[*,1],H_Re9[*,0],reverse_gap)
  H_Re_x10=return_vari_event_new(pos_gsm10[*,0],pos_gsm10[*,1],H_Re10[*,0],reverse_gap)
  
  H_Re_y1=return_vari_event_new(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,1],reverse_gap)
  H_Re_y2=return_vari_event_new(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,1],reverse_gap)
  H_Re_y3=return_vari_event_new(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,1],reverse_gap)
  H_Re_y4=return_vari_event_new(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,1],reverse_gap)  ; -1.4e4 error
  H_Re_y5=return_vari_event_new(pos_gsm5[*,0],pos_gsm5[*,1],H_Re5[*,1],reverse_gap)
  H_Re_y6=return_vari_event_new(pos_gsm6[*,0],pos_gsm6[*,1],H_Re6[*,1],reverse_gap)
  H_Re_y7=return_vari_event_new(pos_gsm7[*,0],pos_gsm7[*,1],H_Re7[*,1],reverse_gap)
  H_Re_y8=return_vari_event_new(pos_gsm8[*,0],pos_gsm8[*,1],H_Re8[*,1],reverse_gap)  
  H_Re_y9=return_vari_event_new(pos_gsm9[*,0],pos_gsm9[*,1],H_Re9[*,1],reverse_gap)
  H_Re_y10=return_vari_event_new(pos_gsm10[*,0],pos_gsm10[*,1],H_Re10[*,1],reverse_gap)
  
  save,H_Re_x1,H_Re_x2,H_Re_x3,H_Re_x4,H_Re_x5,H_Re_x6,H_Re_x7,H_Re_x8,H_Re_x9,H_Re_x10,  $
       H_Re_y1,H_Re_y2,H_Re_y3,H_Re_y4,H_Re_y5,H_Re_y6,H_Re_y7,H_Re_y8,H_Re_y9,H_Re_y10,  $
       filename=root_dir+'H_Re_xy'+save_str+'_new3.sav'
 
 
  K_Re1=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
  K_Re2=return_kinetic_energy_flow_density(density2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
  K_Re3=return_kinetic_energy_flow_density(density3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
  K_Re4=return_kinetic_energy_flow_density(density4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
  K_Re5=return_kinetic_energy_flow_density(density5,velocity_gsm5[*,0],velocity_gsm5[*,1],velocity_gsm5[*,2],2)
  K_Re6=return_kinetic_energy_flow_density(density6,velocity_gsm6[*,0],velocity_gsm6[*,1],velocity_gsm6[*,2],2)

  K_Re_x1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,0],reverse_gap)
  K_Re_x2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,0],reverse_gap)
  K_Re_x3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,0],reverse_gap)
  K_Re_x4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,0],reverse_gap)  ; -550 error
  K_Re_x5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],K_Re5[*,0],reverse_gap)
  K_Re_x6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],K_Re6[*,0],reverse_gap)    ; a big data 0.8
  
  K_Re_y1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,1],reverse_gap)
  K_Re_y2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,1],reverse_gap)
  K_Re_y3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,1],reverse_gap)
  K_Re_y4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,1],reverse_gap)  ; -730  error
  K_Re_y5=return_vari_event(pos_gsm5[*,0],pos_gsm5[*,1],K_Re5[*,1],reverse_gap)
  K_Re_y6=return_vari_event(pos_gsm6[*,0],pos_gsm6[*,1],K_Re6[*,1],reverse_gap)
  
  
  save,K_Re_x1,K_Re_x2,K_Re_x3,K_Re_x4,K_Re_x5,K_Re_x6,K_Re_y1,K_Re_y2,K_Re_y3,K_Re_y4,K_Re_y5,K_Re_y6, $
    filename=root_dir+'K_Re_xy'+save_str+'.sav'
  
  stop
  end