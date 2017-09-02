 pro cluster_energy_flux_density_statistics_data_5
    Re=6371.0
    root_dir='C:\__Data\Datasave\2001_2009_median_new_5\'
;;  ________________________________part1_______________________
;    compile_opt idl2
;    filename0=file_search('C:\__Data\OMNI\*.cdf')
;    tbeg=dblarr(6) & tend=dblarr(6)
;    for jj=0,29 do begin
;      for ii=0,106 do begin
;        cdf2tplot,filename0[ii],varformat='BZ_GSM'
;        case jj of
;          0:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[5*60.,15*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg1,tbeg0
;             append_array,tend1,tend0
;            end
;          1:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[15*60.,25*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg2,tbeg0
;             append_array,tend2,tend0
;            end
;          2:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[25*60.,35*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg3,tbeg0
;             append_array,tend3,tend0
;            end
;          3:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[35*60.,45*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg4,tbeg0
;             append_array,tend4,tend0
;            end  
;          4:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[45*60.,55*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg5,tbeg0
;             append_array,tend5,tend0
;            end
;          5:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[55*60.,65*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg6,tbeg0
;             append_array,tend6,tend0
;            end  
;          6:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[65*60.,75*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg7,tbeg0
;             append_array,tend7,tend0
;            end
;          7:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[75*60.,85*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg8,tbeg0
;             append_array,tend8,tend0
;            end
;          8:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[85*60.,95*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg9,tbeg0
;             append_array,tend9,tend0
;            end
;          9:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[95*60.,105*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg10,tbeg0
;             append_array,tend10,tend0
;            end
;          10:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[105*60.,115*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg11,tbeg0
;             append_array,tend11,tend0
;            end
;          11:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[115*60.,125*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg12,tbeg0
;             append_array,tend12,tend0
;            end
;          12:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[125*60.,135*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg13,tbeg0
;             append_array,tend13,tend0
;            end
;          13:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[135*60.,145*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg14,tbeg0
;             append_array,tend14,tend0
;            end
;          14:begin
;             find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[145*60.,66666666666666.6*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg15,tbeg0
;             append_array,tend15,tend0
;            end 
;            
;            
;            
;          15:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[5*60.,15*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg16,tbeg0
;             append_array,tend16,tend0
;            end
;          16:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[15*60.,25*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg17,tbeg0
;             append_array,tend17,tend0
;            end
;          17:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[25*60.,35*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg18,tbeg0
;             append_array,tend18,tend0
;            end
;          18:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[35*60.,45*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg19,tbeg0
;             append_array,tend19,tend0
;            end
;          19:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[45*60.,55*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg20,tbeg0
;             append_array,tend20,tend0
;            end
;          20:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[55*60.,65*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg21,tbeg0
;             append_array,tend21,tend0
;            end
;          21:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[65*60.,75*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg22,tbeg0
;             append_array,tend22,tend0
;            end
;          22:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[75*60.,85*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg23,tbeg0
;             append_array,tend23,tend0
;            end
;          23:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[85*60.,95*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg24,tbeg0
;             append_array,tend24,tend0
;            end
;          24:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[95*60.,105*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg25,tbeg0
;             append_array,tend25,tend0
;            end
;          25:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[105*60.,115*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg26,tbeg0
;             append_array,tend26,tend0
;            end
;          26:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[115*60.,125*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg27,tbeg0
;             append_array,tend27,tend0
;            end
;          27:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[125*60.,135*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg28,tbeg0
;             append_array,tend28,tend0
;            end
;          28:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[135*60.,145*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg29,tbeg0
;             append_array,tend29,tend0
;            end
;          29:begin
;             find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[145*60.,66666666666666.6*60.],nint=nint,tbeg=tbeg0,tend=tend0
;             append_array,tbeg30,tbeg0
;             append_array,tend30,tend0
;            end 
;         endcase
;        endfor
;      endfor
;      
;;  for ii=0,n_elements(tend8)-1 do begin
;;    append_array,tbeg7,tbeg8[ii]
;;    append_array,tend7,tbeg8[ii]+89*60
;;  endfor
;;
;;  for ii=0,n_elements(tend7)-1 do begin
;;    append_array,tbeg6,tbeg7[ii]
;;    append_array,tend6,tbeg7[ii]+44*60
;;  endfor
;;  
;;  for ii=0,n_elements(tend6)-1 do begin
;;    append_array,tbeg5,tbeg6[ii]
;;    append_array,tend5,tbeg6[ii]+14*60
;;  endfor
;;
;;
;;
;;  for ii=0,n_elements(tend4)-1 do begin
;;    append_array,tbeg3,tbeg4[ii]
;;    append_array,tend3,tbeg4[ii]+89*60
;;  endfor
;;
;;  for ii=0,n_elements(tend3)-1 do begin
;;    append_array,tbeg2,tbeg3[ii]
;;    append_array,tend2,tbeg3[ii]+44*60
;;  endfor
;;  
;;  for ii=0,n_elements(tend2)-1 do begin
;;    append_array,tbeg1,tbeg2[ii]
;;    append_array,tend1,tbeg2[ii]+14*60
;;  endfor
;
;  t_beg=create_struct('tbeg1',tbeg1,'tbeg2',tbeg2,'tbeg3',tbeg3,'tbeg4',tbeg4,'tbeg5',tbeg5,      $
;                      'tbeg6',tbeg6,'tbeg7',tbeg7,'tbeg8',tbeg8,'tbeg9',tbeg9,'tbeg10',tbeg10,    $
;                      'tbeg11',tbeg11,'tbeg12',tbeg12,'tbeg13',tbeg13,'tbeg14',tbeg14,'tbeg15',tbeg15,$
;                      'tbeg16',tbeg16,'tbeg17',tbeg17,'tbeg18',tbeg18,'tbeg19',tbeg19,'tbeg20',tbeg20,$
;                      'tbeg21',tbeg21,'tbeg22',tbeg22,'tbeg23',tbeg23,'tbeg24',tbeg24,'tbeg25',tbeg25,$
;                      'tbeg26',tbeg26,'tbeg27',tbeg27,'tbeg28',tbeg28,'tbeg29',tbeg29,'tbeg30',tbeg30)
;   t_end=create_struct('tend1',tend1,'tend2',tend2,'tend3',tend3,'tend4',tend4,'tend5',tend5,      $
;                      'tend6',tend6,'tend7',tend7,'tend8',tend8,'tend9',tend9,'tend10',tend10,    $
;                      'tend11',tend11,'tend12',tend12,'tend13',tend13,'tend14',tend14,'tend15',tend15,$
;                      'tend16',tend16,'tend17',tend17,'tend18',tend18,'tend19',tend19,'tend20',tend20,$
;                      'tend21',tend21,'tend22',tend22,'tend23',tend23,'tend24',tend24,'tend25',tend25,$
;                      'tend26',tend26,'tend27',tend27,'tend28',tend28,'tend29',tend29,'tend30',tend30)
;  save,t_beg,t_end,$
;    filename=root_dir+'time_interval_divided_by_Bz.sav'
;  
;  stop

   ;________________________________part2_______________________
;    restore,root_dir+'time_interval_divided_by_Bz.sav'
;    start=systime(1)
;    for kk=15,29 do begin 
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
;        10:begin
;           tbeg=t_beg.tbeg11
;           tend=t_end.tend11
;          end
;        11:begin
;           tbeg=t_beg.tbeg12
;           tend=t_end.tend12
;          end
;        12:begin
;           tbeg=t_beg.tbeg13
;           tend=t_end.tend13
;          end
;        13:begin
;           tbeg=t_beg.tbeg14
;           tend=t_end.tend14
;          end
;        14:begin
;           tbeg=t_beg.tbeg15
;           tend=t_end.tend15
;          end
;        15:begin
;           tbeg=t_beg.tbeg16
;           tend=t_end.tend16
;          end
;        16:begin
;           tbeg=t_beg.tbeg17
;           tend=t_end.tend17
;          end
;        17:begin
;           tbeg=t_beg.tbeg18
;           tend=t_end.tend18
;          end
;        18:begin
;           tbeg=t_beg.tbeg19
;           tend=t_end.tend19
;          end
;        19:begin
;           tbeg=t_beg.tbeg20
;           tend=t_end.tend20
;          end
;        20:begin
;           tbeg=t_beg.tbeg21
;           tend=t_end.tend21
;          end
;        21:begin
;           tbeg=t_beg.tbeg22
;           tend=t_end.tend22
;          end
;        22:begin
;           tbeg=t_beg.tbeg23
;           tend=t_end.tend23
;          end
;        23:begin
;           tbeg=t_beg.tbeg24
;           tend=t_end.tend24
;          end
;        24:begin
;           tbeg=t_beg.tbeg25
;           tend=t_end.tend25
;          end
;        25:begin
;           tbeg=t_beg.tbeg26
;           tend=t_end.tend26
;          end
;        26:begin
;           tbeg=t_beg.tbeg27
;           tend=t_end.tend27
;          end
;        27:begin
;           tbeg=t_beg.tbeg28
;           tend=t_end.tend28
;          end
;        28:begin
;           tbeg=t_beg.tbeg29
;           tend=t_end.tend29
;          end
;        29:begin
;           tbeg=t_beg.tbeg30
;           tend=t_end.tend30
;          end
;      endcase
;    names=['_BZgt0_5_15','_BZgt0_15_25','_BZgt0_25_35','_BZgt0_35_45','_BZgt0_45_55','_BZgt0_55_65',$
;          '_BZgt0_65_75','_BZgt0_75_85','_BZgt0_85_95','_BZgt0_95_105','_BZgt0_105_115','_BZgt0_115_125',$
;          '_BZgt0_125_135','_BZgt0_135_145','_BZgt0_gt_145', $
;           '_BZle0_5_15','_BZle0_15_25','_BZle0_25_35','_BZle0_35_45','_BZle0_45_55','_BZle0_55_65',$
;          '_BZle0_65_75','_BZle0_75_85','_BZle0_85_95','_BZle0_95_105','_BZle0_105_115','_BZle0_115_125',$
;          '_BZle0_125_135','_BZle0_135_145','_BZle0_gt_145']
;  
;  
;    for ii=0,8 do begin   ;0-8
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
;;    save_time_c3fgmcis=(systime(1)-start)/3600.0
;;    print,'save_time ',save_time_c3fgmcis,' hour'
;;    save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'
;  
;    save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,$
;      filename=root_dir+'c3_fgmcis_data_selected_'+names[kk]+'.sav'
;  
;    undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1
;  endfor
;  save_time_c3fgmcis=(systime(1)-start)/3600.0
;  print,'save_time ',save_time_c3fgmcis,' hour'
;  
;  stop
  
  ;________________________________part3_______________________
  
  
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'+'_mean'
  root_dir='C:\__Data\Datasave\2001_2009_median_new_5\'
  filename=file_search(root_dir+'*.sav')
  counts=make_array(30)
  for i=0,29 do begin
    restore,filename[i]
    counts[i]=n_elements(t_c3cis1)
  endfor
  

; 
;  pos_gsm=create_struct(                     $
;     'pos_gsm_1',make_array(counts[0],3),'pos_gsm_2',make_array(counts[1],3),'pos_gsm_3',make_array(counts[2],3), $
;     'pos_gsm_4',make_array(counts[3],3),'pos_gsm_5',make_array(counts[4],3),'pos_gsm_6',make_array(counts[5],3), $                                                                                            
;     'pos_gsm_7',make_array(counts[6],3),'pos_gsm_8',make_array(counts[7],3),'pos_gsm_9',make_array(counts[8],3), $                                                                                             
;     'pos_gsm_10',make_array(counts[9],3),'pos_gsm_11',make_array(counts[10],3),'pos_gsm_12',make_array(counts[11],3), $                                                                                            
;     'pos_gsm_13',make_array(counts[12],3),'pos_gsm_14',make_array(counts[13],3),'pos_gsm_15',make_array(counts[14],3))                                                                                              
;  velocity_gsm=create_struct(                     $
;     'velocity_gsm_1',make_array(counts[0],3),'velocity_gsm_2',make_array(counts[1],3),'velocity_gsm_3',make_array(counts[2],3), $
;     'velocity_gsm_4',make_array(counts[3],3),'velocity_gsm_5',make_array(counts[4],3),'velocity_gsm_6',make_array(counts[5],3), $
;     'velocity_gsm_7',make_array(counts[6],3),'velocity_gsm_8',make_array(counts[7],3),'velocity_gsm_9',make_array(counts[8],3), $
;     'velocity_gsm_10',make_array(counts[9],3),'velocity_gsm_11',make_array(counts[10],3),'velocity_gsm_12',make_array(counts[11],3), $
;     'velocity_gsm_13',make_array(counts[12],3),'velocity_gsm_14',make_array(counts[13],3),'velocity_gsm_15',make_array(counts[14],3))
;  t_c3cis=create_struct(                     $
;     't_c3cis_1',make_array(counts[0]),'t_c3cis_2',make_array(counts[1]),'t_c3cis_3',make_array(counts[2]), $
;     't_c3cis_4',make_array(counts[3]),'t_c3cis_5',make_array(counts[4]),'t_c3cis_6',make_array(counts[5]), $
;     't_c3cis_7',make_array(counts[6]),'t_c3cis_8',make_array(counts[7]),'t_c3cis_9',make_array(counts[8]), $
;     't_c3cis_10',make_array(counts[9]),'t_c3cis_11',make_array(counts[10]),'t_c3cis_12',make_array(counts[11]), $
;     't_c3cis_13',make_array(counts[12]),'t_c3cis_14',make_array(counts[13]),'t_c3cis_15',make_array(counts[14]))                                                                                                
;  density=create_struct(                     $
;     'density_1',make_array(counts[0]),'density_2',make_array(counts[1]),'density_3',make_array(counts[2]), $
;     'density_4',make_array(counts[3]),'density_5',make_array(counts[4]),'density_6',make_array(counts[5]), $
;     'density_7',make_array(counts[6]),'density_8',make_array(counts[7]),'density_9',make_array(counts[8]), $
;     'density_10',make_array(counts[9]),'density_11',make_array(counts[10]),'density_12',make_array(counts[11]), $
;     'density_13',make_array(counts[12]),'density_14',make_array(counts[13]),'density_15',make_array(counts[14]))
;  temperature=create_struct(                     $
;     'temperature_1',make_array(counts[0]),'temperature_2',make_array(counts[1]),'temperature_3',make_array(counts[2]), $
;     'temperature_4',make_array(counts[3]),'temperature_5',make_array(counts[4]),'temperature_6',make_array(counts[5]), $
;     'temperature_7',make_array(counts[6]),'temperature_8',make_array(counts[7]),'temperature_9',make_array(counts[8]), $
;     'temperature_10',make_array(counts[9]),'temperature_11',make_array(counts[10]),'temperature_12',make_array(counts[11]), $
;     'temperature_13',make_array(counts[12]),'temperature_14',make_array(counts[13]),'temperature_15',make_array(counts[14]))
;  pressure=create_struct(                     $
;     'pressure_1',make_array(counts[0]),'pressure_2',make_array(counts[1]),'pressure_3',make_array(counts[2]), $
;     'pressure_4',make_array(counts[3]),'pressure_5',make_array(counts[4]),'pressure_6',make_array(counts[5]), $
;     'pressure_7',make_array(counts[6]),'pressure_8',make_array(counts[7]),'pressure_9',make_array(counts[8]), $
;     'pressure_10',make_array(counts[9]),'pressure_11',make_array(counts[10]),'pressure_12',make_array(counts[11]), $
;     'pressure_13',make_array(counts[12]),'pressure_14',make_array(counts[13]),'pressure_15',make_array(counts[14]))
;
;  for i=0,14 do begin
;      restore,filename[i]
;      pos_gsm.(i)=pos_gsm1
;      velocity_gsm.(i)=velocity_gsm1
;      t_c3cis.(i)=t_c3cis1
;      density.(i)=density1
;      temperature.(i)=temperature1
;      pressure.(i)=pressure1
;  endfor
 
  eventimes=create_struct(                     $
    'eventimes_1',make_array(10,30),'eventimes_2',make_array(10,30),'eventimes_3',make_array(10,30), $
    'eventimes_4',make_array(10,30),'eventimes_5',make_array(10,30),'eventimes_6',make_array(10,30), $
    'eventimes_7',make_array(10,30),'eventimes_8',make_array(10,30),'eventimes_9',make_array(10,30), $
    'eventimes_10',make_array(10,30),'eventimes_11',make_array(10,30),'eventimes_12',make_array(10,30), $
    'eventimes_13',make_array(10,30),'eventimes_14',make_array(10,30),'eventimes_15',make_array(10,30), $
    'eventimes_16',make_array(10,30),'eventimes_17',make_array(10,30),'eventimes_18',make_array(10,30), $
    'eventimes_19',make_array(10,30),'eventimes_20',make_array(10,30),'eventimes_21',make_array(10,30), $
    'eventimes_22',make_array(10,30),'eventimes_23',make_array(10,30),'eventimes_24',make_array(10,30), $
    'eventimes_25',make_array(10,30),'eventimes_26',make_array(10,30),'eventimes_27',make_array(10,30), $
    'eventimes_28',make_array(10,30),'eventimes_29',make_array(10,30),'eventimes_30',make_array(10,30) )

  event_n=create_struct(                     $
    'event_n_1',make_array(10,30),'event_n_2',make_array(10,30),'event_n_3',make_array(10,30), $
    'event_n_4',make_array(10,30),'event_n_5',make_array(10,30),'event_n_6',make_array(10,30), $
    'event_n_7',make_array(10,30),'event_n_8',make_array(10,30),'event_n_9',make_array(10,30), $
    'event_n_10',make_array(10,30),'event_n_11',make_array(10,30),'event_n_12',make_array(10,30), $
    'event_n_13',make_array(10,30),'event_n_14',make_array(10,30),'event_n_15',make_array(10,30), $
    'event_n_16',make_array(10,30),'event_n_17',make_array(10,30),'event_n_18',make_array(10,30), $
    'event_n_19',make_array(10,30),'event_n_20',make_array(10,30),'event_n_21',make_array(10,30), $
    'event_n_22',make_array(10,30),'event_n_23',make_array(10,30),'event_n_24',make_array(10,30), $
    'event_n_25',make_array(10,30),'event_n_26',make_array(10,30),'event_n_27',make_array(10,30), $
    'event_n_28',make_array(10,30),'event_n_29',make_array(10,30),'event_n_30',make_array(10,30) )
 
  event_t=create_struct(                     $
    'event_t_1',make_array(10,30),'event_t_2',make_array(10,30),'event_t_3',make_array(10,30), $
    'event_t_4',make_array(10,30),'event_t_5',make_array(10,30),'event_t_6',make_array(10,30), $
    'event_t_7',make_array(10,30),'event_t_8',make_array(10,30),'event_t_9',make_array(10,30), $
    'event_t_10',make_array(10,30),'event_t_11',make_array(10,30),'event_t_12',make_array(10,30), $
    'event_t_13',make_array(10,30),'event_t_14',make_array(10,30),'event_t_15',make_array(10,30), $
    'event_t_16',make_array(10,30),'event_t_17',make_array(10,30),'event_t_18',make_array(10,30), $
    'event_t_19',make_array(10,30),'event_t_20',make_array(10,30),'event_t_21',make_array(10,30), $
    'event_t_22',make_array(10,30),'event_t_23',make_array(10,30),'event_t_24',make_array(10,30), $
    'event_t_25',make_array(10,30),'event_t_26',make_array(10,30),'event_t_27',make_array(10,30), $
    'event_t_28',make_array(10,30),'event_t_29',make_array(10,30),'event_t_30',make_array(10,30) )
  
  event_p=create_struct(                     $
    'event_p_1',make_array(10,30),'event_p_2',make_array(10,30),'event_p_3',make_array(10,30), $
    'event_p_4',make_array(10,30),'event_p_5',make_array(10,30),'event_p_6',make_array(10,30), $
    'event_p_7',make_array(10,30),'event_p_8',make_array(10,30),'event_p_9',make_array(10,30), $
    'event_p_10',make_array(10,30),'event_p_11',make_array(10,30),'event_p_12',make_array(10,30), $
    'event_p_13',make_array(10,30),'event_p_14',make_array(10,30),'event_p_15',make_array(10,30), $
    'event_p_16',make_array(10,30),'event_p_17',make_array(10,30),'event_p_18',make_array(10,30), $
    'event_p_19',make_array(10,30),'event_p_20',make_array(10,30),'event_p_21',make_array(10,30), $
    'event_p_22',make_array(10,30),'event_p_23',make_array(10,30),'event_p_24',make_array(10,30), $
    'event_p_25',make_array(10,30),'event_p_26',make_array(10,30),'event_p_27',make_array(10,30), $
    'event_p_28',make_array(10,30),'event_p_29',make_array(10,30),'event_p_30',make_array(10,30) )
 
  event_vx=create_struct(                     $
    'event_vx_1',make_array(10,30),'event_vx_2',make_array(10,30),'event_vx_3',make_array(10,30), $
    'event_vx_4',make_array(10,30),'event_vx_5',make_array(10,30),'event_vx_6',make_array(10,30), $
    'event_vx_7',make_array(10,30),'event_vx_8',make_array(10,30),'event_vx_9',make_array(10,30), $
    'event_vx_10',make_array(10,30),'event_vx_11',make_array(10,30),'event_vx_12',make_array(10,30), $
    'event_vx_13',make_array(10,30),'event_vx_14',make_array(10,30),'event_vx_15',make_array(10,30), $
    'event_vx_16',make_array(10,30),'event_vx_17',make_array(10,30),'event_vx_18',make_array(10,30), $
    'event_vx_19',make_array(10,30),'event_vx_20',make_array(10,30),'event_vx_21',make_array(10,30), $
    'event_vx_22',make_array(10,30),'event_vx_23',make_array(10,30),'event_vx_24',make_array(10,30), $
    'event_vx_25',make_array(10,30),'event_vx_26',make_array(10,30),'event_vx_27',make_array(10,30), $
    'event_vx_28',make_array(10,30),'event_vx_29',make_array(10,30),'event_vx_30',make_array(10,30) )
  
  event_vy=create_struct(                     $
    'event_vy_1',make_array(10,30),'event_vy_2',make_array(10,30),'event_vy_3',make_array(10,30), $
    'event_vy_4',make_array(10,30),'event_vy_5',make_array(10,30),'event_vy_6',make_array(10,30), $
    'event_vy_7',make_array(10,30),'event_vy_8',make_array(10,30),'event_vy_9',make_array(10,30), $
    'event_vy_10',make_array(10,30),'event_vy_11',make_array(10,30),'event_vy_12',make_array(10,30), $
    'event_vy_13',make_array(10,30),'event_vy_14',make_array(10,30),'event_vy_15',make_array(10,30), $
    'event_vy_16',make_array(10,30),'event_vy_17',make_array(10,30),'event_vy_18',make_array(10,30), $
    'event_vy_19',make_array(10,30),'event_vy_20',make_array(10,30),'event_vy_21',make_array(10,30), $
    'event_vy_22',make_array(10,30),'event_vy_23',make_array(10,30),'event_vy_24',make_array(10,30), $
    'event_vy_25',make_array(10,30),'event_vy_26',make_array(10,30),'event_vy_27',make_array(10,30), $
    'event_vy_28',make_array(10,30),'event_vy_29',make_array(10,30),'event_vy_30',make_array(10,30) )
      
  H_Re_x=create_struct(                     $
    'H_Re_x_1',make_array(10,30),'H_Re_x_2',make_array(10,30),'H_Re_x_3',make_array(10,30), $
    'H_Re_x_4',make_array(10,30),'H_Re_x_5',make_array(10,30),'H_Re_x_6',make_array(10,30), $
    'H_Re_x_7',make_array(10,30),'H_Re_x_8',make_array(10,30),'H_Re_x_9',make_array(10,30), $
    'H_Re_x_10',make_array(10,30),'H_Re_x_11',make_array(10,30),'H_Re_x_12',make_array(10,30), $
    'H_Re_x_13',make_array(10,30),'H_Re_x_14',make_array(10,30),'H_Re_x_15',make_array(10,30), $
    'H_Re_x_16',make_array(10,30),'H_Re_x_17',make_array(10,30),'H_Re_x_18',make_array(10,30), $
    'H_Re_x_19',make_array(10,30),'H_Re_x_20',make_array(10,30),'H_Re_x_21',make_array(10,30), $
    'H_Re_x_22',make_array(10,30),'H_Re_x_23',make_array(10,30),'H_Re_x_24',make_array(10,30), $
    'H_Re_x_25',make_array(10,30),'H_Re_x_26',make_array(10,30),'H_Re_x_27',make_array(10,30), $
    'H_Re_x_28',make_array(10,30),'H_Re_x_29',make_array(10,30),'H_Re_x_30',make_array(10,30) )

  H_Re_y=create_struct(                     $
    'H_Re_y_1',make_array(10,30),'H_Re_y_2',make_array(10,30),'H_Re_y_3',make_array(10,30), $
    'H_Re_y_4',make_array(10,30),'H_Re_y_5',make_array(10,30),'H_Re_y_6',make_array(10,30), $
    'H_Re_y_7',make_array(10,30),'H_Re_y_8',make_array(10,30),'H_Re_y_9',make_array(10,30), $
    'H_Re_y_10',make_array(10,30),'H_Re_y_11',make_array(10,30),'H_Re_y_12',make_array(10,30), $
    'H_Re_y_13',make_array(10,30),'H_Re_y_14',make_array(10,30),'H_Re_y_15',make_array(10,30), $
    'H_Re_y_16',make_array(10,30),'H_Re_y_17',make_array(10,30),'H_Re_y_18',make_array(10,30), $
    'H_Re_y_19',make_array(10,30),'H_Re_y_20',make_array(10,30),'H_Re_y_21',make_array(10,30), $
    'H_Re_y_22',make_array(10,30),'H_Re_y_23',make_array(10,30),'H_Re_y_24',make_array(10,30), $
    'H_Re_y_25',make_array(10,30),'H_Re_y_26',make_array(10,30),'H_Re_y_27',make_array(10,30), $
    'H_Re_y_28',make_array(10,30),'H_Re_y_29',make_array(10,30),'H_Re_y_30',make_array(10,30) )

  K_Re_x=create_struct(                     $
    'K_Re_x_1',make_array(10,30),'K_Re_x_2',make_array(10,30),'K_Re_x_3',make_array(10,30), $
    'K_Re_x_4',make_array(10,30),'K_Re_x_5',make_array(10,30),'K_Re_x_6',make_array(10,30), $
    'K_Re_x_7',make_array(10,30),'K_Re_x_8',make_array(10,30),'K_Re_x_9',make_array(10,30), $
    'K_Re_x_10',make_array(10,30),'K_Re_x_11',make_array(10,30),'K_Re_x_12',make_array(10,30), $
    'K_Re_x_13',make_array(10,30),'K_Re_x_14',make_array(10,30),'K_Re_x_15',make_array(10,30), $
    'K_Re_x_16',make_array(10,30),'K_Re_x_17',make_array(10,30),'K_Re_x_18',make_array(10,30), $
    'K_Re_x_19',make_array(10,30),'K_Re_x_20',make_array(10,30),'K_Re_x_21',make_array(10,30), $
    'K_Re_x_22',make_array(10,30),'K_Re_x_23',make_array(10,30),'K_Re_x_24',make_array(10,30), $
    'K_Re_x_25',make_array(10,30),'K_Re_x_26',make_array(10,30),'K_Re_x_27',make_array(10,30), $
    'K_Re_x_28',make_array(10,30),'K_Re_x_29',make_array(10,30),'K_Re_x_30',make_array(10,30) )
    
  K_Re_y=create_struct(                     $
    'K_Re_y_1',make_array(10,30),'K_Re_y_2',make_array(10,30),'K_Re_y_3',make_array(10,30), $
    'K_Re_y_4',make_array(10,30),'K_Re_y_5',make_array(10,30),'K_Re_y_6',make_array(10,30), $
    'K_Re_y_7',make_array(10,30),'K_Re_y_8',make_array(10,30),'K_Re_y_9',make_array(10,30), $
    'K_Re_y_10',make_array(10,30),'K_Re_y_11',make_array(10,30),'K_Re_y_12',make_array(10,30), $
    'K_Re_y_13',make_array(10,30),'K_Re_y_14',make_array(10,30),'K_Re_y_15',make_array(10,30), $
    'K_Re_y_16',make_array(10,30),'K_Re_y_17',make_array(10,30),'K_Re_y_18',make_array(10,30), $
    'K_Re_y_19',make_array(10,30),'K_Re_y_20',make_array(10,30),'K_Re_y_21',make_array(10,30), $
    'K_Re_y_22',make_array(10,30),'K_Re_y_23',make_array(10,30),'K_Re_y_24',make_array(10,30), $
    'K_Re_y_25',make_array(10,30),'K_Re_y_26',make_array(10,30),'K_Re_y_27',make_array(10,30), $
    'K_Re_y_28',make_array(10,30),'K_Re_y_29',make_array(10,30),'K_Re_y_30',make_array(10,30) )
  
  H_Re=create_struct(                     $
    'H_Re_1',make_array(counts[0],3),'H_Re_2',make_array(counts[1],3),'H_Re_3',make_array(counts[2],3), $
    'H_Re_4',make_array(counts[3],3),'H_Re_5',make_array(counts[4],3),'H_Re_6',make_array(counts[5],3), $
    'H_Re_7',make_array(counts[6],3),'H_Re_8',make_array(counts[7],3),'H_Re_9',make_array(counts[8],3), $
    'H_Re_10',make_array(counts[9],3),'H_Re_11',make_array(counts[10],3),'H_Re_12',make_array(counts[11],3), $
    'H_Re_13',make_array(counts[12],3),'H_Re_14',make_array(counts[13],3),'H_Re_15',make_array(counts[14],3), $
    'H_Re_16',make_array(counts[15],3),'H_Re_17',make_array(counts[16],3),'H_Re_18',make_array(counts[17],3), $
    'H_Re_19',make_array(counts[18],3),'H_Re_20',make_array(counts[19],3),'H_Re_21',make_array(counts[20],3), $
    'H_Re_22',make_array(counts[21],3),'H_Re_23',make_array(counts[22],3),'H_Re_24',make_array(counts[23],3), $
    'H_Re_25',make_array(counts[24],3),'H_Re_26',make_array(counts[25],3),'H_Re_27',make_array(counts[26],3), $
    'H_Re_28',make_array(counts[27],3),'H_Re_29',make_array(counts[28],3),'H_Re_30',make_array(counts[29],3) )
  
  K_Re=create_struct(                     $
    'K_Re_1',make_array(counts[0],3),'K_Re_2',make_array(counts[1],3),'K_Re_3',make_array(counts[2],3), $
    'K_Re_4',make_array(counts[3],3),'K_Re_5',make_array(counts[4],3),'K_Re_6',make_array(counts[5],3), $
    'K_Re_7',make_array(counts[6],3),'K_Re_8',make_array(counts[7],3),'K_Re_9',make_array(counts[8],3), $
    'K_Re_10',make_array(counts[9],3),'K_Re_11',make_array(counts[10],3),'K_Re_12',make_array(counts[11],3), $
    'K_Re_13',make_array(counts[12],3),'K_Re_14',make_array(counts[13],3),'K_Re_15',make_array(counts[14],3), $
    'K_Re_16',make_array(counts[15],3),'K_Re_17',make_array(counts[16],3),'K_Re_18',make_array(counts[17],3), $
    'K_Re_19',make_array(counts[18],3),'K_Re_20',make_array(counts[19],3),'K_Re_21',make_array(counts[20],3), $
    'K_Re_22',make_array(counts[21],3),'K_Re_23',make_array(counts[22],3),'K_Re_24',make_array(counts[23],3), $
    'K_Re_25',make_array(counts[24],3),'K_Re_26',make_array(counts[25],3),'K_Re_27',make_array(counts[26],3), $
    'K_Re_28',make_array(counts[27],3),'K_Re_29',make_array(counts[28],3),'K_Re_30',make_array(counts[29],3) )
  
  H_K_Re=create_struct(                     $
    'H_K_Re_1',make_array(counts[0],3),'H_K_Re_2',make_array(counts[1],3),'H_K_Re_3',make_array(counts[2],3), $
    'H_K_Re_4',make_array(counts[3],3),'H_K_Re_5',make_array(counts[4],3),'H_K_Re_6',make_array(counts[5],3), $
    'H_K_Re_7',make_array(counts[6],3),'H_K_Re_8',make_array(counts[7],3),'H_K_Re_9',make_array(counts[8],3), $
    'H_K_Re_10',make_array(counts[9],3),'H_K_Re_11',make_array(counts[10],3),'H_K_Re_12',make_array(counts[11],3), $
    'H_K_Re_13',make_array(counts[12],3),'H_K_Re_14',make_array(counts[13],3),'H_K_Re_15',make_array(counts[14],3), $
    'H_K_Re_16',make_array(counts[15],3),'H_K_Re_17',make_array(counts[16],3),'H_K_Re_18',make_array(counts[17],3), $
    'H_K_Re_19',make_array(counts[18],3),'H_K_Re_20',make_array(counts[19],3),'H_K_Re_21',make_array(counts[20],3), $
    'H_K_Re_22',make_array(counts[21],3),'H_K_Re_23',make_array(counts[22],3),'H_K_Re_24',make_array(counts[23],3), $
    'H_K_Re_25',make_array(counts[24],3),'H_K_Re_26',make_array(counts[25],3),'H_K_Re_27',make_array(counts[26],3), $
    'H_K_Re_28',make_array(counts[27],3),'H_K_Re_29',make_array(counts[28],3),'H_K_Re_30',make_array(counts[29],3) )

  H_K_Re_x=create_struct(                     $
    'H_K_Re_x_1',make_array(10,30),'H_K_Re_x_2',make_array(10,30),'H_K_Re_x_3',make_array(10,30), $
    'H_K_Re_x_4',make_array(10,30),'H_K_Re_x_5',make_array(10,30),'H_K_Re_x_6',make_array(10,30), $
    'H_K_Re_x_7',make_array(10,30),'H_K_Re_x_8',make_array(10,30),'H_K_Re_x_9',make_array(10,30), $
    'H_K_Re_x_10',make_array(10,30),'H_K_Re_x_11',make_array(10,30),'H_K_Re_x_12',make_array(10,30), $
    'H_K_Re_x_13',make_array(10,30),'H_K_Re_x_14',make_array(10,30),'H_K_Re_x_15',make_array(10,30), $
    'H_K_Re_x_16',make_array(10,30),'H_K_Re_x_17',make_array(10,30),'H_K_Re_x_18',make_array(10,30), $
    'H_K_Re_x_19',make_array(10,30),'H_K_Re_x_20',make_array(10,30),'H_K_Re_x_21',make_array(10,30), $
    'H_K_Re_x_22',make_array(10,30),'H_K_Re_x_23',make_array(10,30),'H_K_Re_x_24',make_array(10,30), $
    'H_K_Re_x_25',make_array(10,30),'H_K_Re_x_26',make_array(10,30),'H_K_Re_x_27',make_array(10,30), $
    'H_K_Re_x_28',make_array(10,30),'H_K_Re_x_29',make_array(10,30),'H_K_Re_x_30',make_array(10,30) )
  
  
  for i=0,29 do begin
    restore,filename[i]
;    pos_gsm.(i)=pos_gsm1
;    velocity_gsm.(i)=velocity_gsm1
;    t_c3cis.(i)=t_c3cis1
;    density.(i)=density1
;    temperature.(i)=temperature1
;    pressure.(i)=pressure1
    ;cgplot,pressure1,title='p[i]'
    eventimes.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
    event_n.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
    event_t.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
    event_p.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
    event_vx.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,0],reverse_gap)
    event_vy.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,1],reverse_gap)
   
    H_Re.(i)=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
    idxh=where(abs(H_Re.(i)) gt 1000.0)
    H_Re.(i)[idxh]=!values.f_nan
    
    H_Re_x.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re.(i)[*,0],reverse_gap)
    H_Re_y.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re.(i)[*,1],reverse_gap)
    K_Re.(i)=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
    K_Re_x.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re.(i)[*,0],reverse_gap)
    K_Re_y.(i)=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re.(i)[*,1],reverse_gap)
    
    H_K_Re.(i)=H_Re.(i)+K_Re.(i)
    H_K_Re_x.(i)=H_Re_x.(i)+K_Re_x.(i)
    print,i
  endfor
  
  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re,K_Re,H_Re_x,H_Re_y,K_Re_x,K_Re_y,H_K_Re,H_K_Re_x,filename=root_dir+'event_data'+save_str+'.sav'

;  idxp7=where(abs(pressure7) gt 100.0)
;  pressure7[idxp7]=!values.f_nan

  stop
 
  end