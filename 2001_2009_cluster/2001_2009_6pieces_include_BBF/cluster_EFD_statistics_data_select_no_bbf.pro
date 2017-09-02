 pro cluster_EFD_statistics_data_select_no_bbf
    Re=6371.0
    root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
    start=systime(1)
;;  ________________________________part1_______________________
;    compile_opt idl2
;    a=findgen(30)
;    t_beg=list(a,/ex)
;    t_end=list(a,/ex)
;    
;    filename0=file_search('C:\__Data\OMNI\*.cdf')
;      
;    for jj=0,5 do begin
;      if (jj le 2) then begin
;        maxvalue=1000
;        minvalue=0
;      endif else begin
;        maxvalue=0
;        minvalue=-1000
;      endelse
;      if (jj eq 0) or (jj eq 3)  then duration=[5*60.,30*60.]
;      if (jj eq 1) or (jj eq 4)  then duration=[30*60.,90*60.]
;      if (jj eq 2) or (jj eq 5)  then duration=[90*60,666666.*60.]
;     
;      for ii=0,106 do begin             ;divided by year
;       cdf2tplot,filename0[ii],varformat='BZ_GSM'
;       get_data,'BZ_GSM',time0,BZ_GSM0
;       append_array,time,time0
;       append_array,BZ_GSM,BZ_GSM0
;      
;       if (((ii+1) mod 12) eq 0) or (ii eq 106) then begin
;        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
;        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=2*60,duration=duration,nint=nint,tbeg=tbeg0,tend=tend0
;        append_Array,tbeg1,tbeg0
;        append_Array,tend1,tend0
;        undefine,time,BZ_GSM
;       endif
;      endfor
;      t_beg[jj]=tbeg1
;      t_end[jj]=tend1
;      undefine,tbeg1,tend1
;    endfor
;   
;    save,t_beg,t_end,$
;      filename=root_dir+'time_interval_divided_by_Bz_yearly.sav'
;    
;    restore,root_dir+'time_interval_divided_by_Bz_yearly.sav'
;    
;    tbeg4=t_beg[4]
;    tend4=t_end[4]
;    tbeg3=t_beg[3]
;    tend3=t_end[3]
;    tbeg1=t_beg[1]
;    tend1=t_end[1]
;    tbeg0=t_beg[0]
;    tend0=t_end[0]
;    
;    for ii=0,n_elements(t_end[5])-1 do begin
;      append_array,tbeg4,(t_beg[5])[ii]
;      append_array,tend4,(t_beg[5])[ii]+89*60
;    endfor
;    for ii=0,n_elements(tend4)-1 do begin
;      append_array,tbeg3,tbeg4[ii]
;      append_array,tend3,tbeg4[ii]+29*60
;    endfor
;  
;   
;    for ii=0,n_elements(t_end[2])-1 do begin
;      append_array,tbeg1,(t_beg[2])[ii]
;      append_array,tend1,(t_beg[2])[ii]+89*60
;    endfor
;    for ii=0,n_elements(tend1)-1 do begin
;      append_array,tbeg0,tbeg1[ii]
;      append_array,tend0,tbeg1[ii]+29*60
;    endfor  
;    
;    t_beg[4]=tbeg4
;    t_end[4]=tend4
;    t_beg[3]=tbeg3
;    t_end[3]=tend3
;    t_beg[1]=tbeg1
;    t_end[1]=tend1
;    t_beg[0]=tbeg0
;    t_end[0]=tend0
;
;
;
;  save,t_beg,t_end,$
;    filename=root_dir+'time_interval_divided_by_Bz_yearly_add_former_time.sav'
;  print,(systime(1)-start)/60.
;  stop

;;  ________________________________part2_______________________
;   restore,root_dir+'time_interval_divided_by_Bz_yearly_add_former_time.sav'
;   for kk=0,5  do begin 
;   tbeg=t_beg[kk]
;   tend=t_end[kk] 
;
;   names=['_BZgt0_05_30','_BZgt0_30_90','_BZgt0_gt_90','_BZle0_05_30','_BZle0_30_90','_BZle0_gt_90']
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
;      index_ps=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
;      time1=time[index_ps]
;      pos_gsm_interp=pos_gsm_interp[index_ps,*]          ;  plasma sheet identified
;  
;      store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
;  
;      tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS 
;;      tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;  
;
;      
;      ;select BBF
;      get_Data,'velocity_gsm_interp',time_v,v_gsm
;      velocity_all=sqrt(v_gsm[*,0]^2+v_gsm[*,1]^1+v_gsm[*,2]^2)
;      
;      store_data,'velocity_all',data={x:time_v,y:velocity_all}
;      
;      tclip,'velocity_all',100,3000 
;      tdeflag,'velocity_all_clip','remove_nan'
;      get_Data, 'velocity_all_clip_deflag',t1,v1
;       
;      separate_satisfy_interval,t1,start_point,terminal_point   ; get time intervals of V>100km/s 
;      
;      indextt=where(terminal_point-start_point ne 0)            ;eliminate isolated points
;      start_point=start_point[indextt]
;      terminal_point=terminal_point[indextt]
;       
;      index_start=dblarr(n_elements(start_point))-1.0e10        ;0 (useless until now   2017.04.25)       
;      index_end=dblarr(n_elements(start_point))-1.0e10          ;0
;      j=0
;      for i=0,n_elements(start_point)-1 do begin
;         index_s=where(start_point[i] eq t1)
;         index_e=where(terminal_point[i] eq t1)
;         vv=v1[index_s:index_e]
;         tt=t1[index_s:index_e]
;         if max(vv) ge 250  then begin                          ; bbfs' peak ge 250km/s 
;          index_start[j]=index_s                                ;0
;          index_end[j]=index_e                                  ;0
;          if index_s ne 0 then begin
;;            append_array,vv_bbf,vv
;            append_array,tt_bbf,tt
;            append_array,tt_bbf_save,tt
;          endif
;          j=j+1
;         endif
;      endfor
;      
;      index_bbf_start=index_Start[where(index_start gt 0)]      ;0
;      index_bbf_end=index_end[where(index_end gt 0)]            ;0
;      
;;      
;;      ;bbf_Data
;;      for k=0,n_elements(tt_bbf)-1 do begin
;;        indexb=where(tt_bbf[k] eq time_v)
;;        append_array,index_bbf,indexb
;;      endfor
;;      
;;;      t_save=time_v[index_bbf]
;;      vx_bbf=v_gsm[index_bbf,0]
;;      vy_bbf=v_gsm[index_bbf,1]
;;      vz_bbf=v_gsm[index_bbf,2]
;;      vv_bbf=[[vx_bbf],[vy_bbf],[vz_bbf]]
;;      store_data,'velocity_bbf',data={x:tt_bbf,y:vv_bbf}
;;      undefine,tt_bbf,index_bbf
;;      
;;      tinterpol_mxn,'B_total','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'B_gsm','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'density','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'temperature','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'pressure','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      tinterpol_mxn,'pos_gsm_interp','velocity_bbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;;      
;;      
;      
;      ; no bbf data
;      for k=0,n_elements(tt_bbf)-1 do begin
;        indexb=where(tt_bbf[k] eq time_v)
;        append_array,index_bbf,indexb
;      endfor   
;      
;      time_v[index_bbf]=!values.f_nan
;      v_gsm[index_bbf,0]=!values.f_nan
;      v_gsm[index_bbf,1]=!values.f_nan
;      v_gsm[index_bbf,2]=!values.f_nan
;      
;      undefine,index_bbf,tt_bbf
;      
;      t_no_bbf=time_v[where(finite(time_v))]
;      vcx=(v_gsm[*,0])[where(finite(v_gsm[*,0]))]
;      vcy=(v_gsm[*,1])[where(finite(v_gsm[*,1]))]
;      vcz=(v_gsm[*,2])[where(finite(v_gsm[*,2]))]
;      velocity_nobbf_sav=[[vcx],[vcy],[vcz]]
;       
;      store_data,'velocity_nobbf',data={x:t_no_bbf,y:velocity_nobbf_sav}
;
;      tinterpol_mxn,'B_total','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'B_gsm','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'density','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'temperature','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'pressure','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      tinterpol_mxn,'pos_gsm_interp','velocity_nobbf',/NEAREST_NEIGHBOR,/IGNORE_NANS
;      
;      
;      
;      
;      index_terval=strfilter(time_string(tend,pre=-5),year,count=count,/index)
;  
;      for jj=0,count-1 do begin
;        tic 
;        
;        B_total_temp=tsample('B_total_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;        B_gsm_temp=tsample('B_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;        pos_gsm_temp=tsample('pos_gsm_interp_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;                                   ;attention!!!selcet bbf  change this tplot variable
;                                   
;        if is_array(B_gsm_temp) then begin
;          append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
;          append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
;          append_Array,B_gsm,TEMPORARY(B_gsm_temp)
;          append_Array,B_total,TEMPORARY(B_total_temp)
;        endif
;  
;        density_temp=tsample('density_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;        velocity_nobbf_temp=tsample('velocity_nobbf',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;        temperature_temp=tsample('temperature_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;        pressure_temp=tsample('pressure_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;  
;        if is_array(density_temp) then begin
;          append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
;          append_Array,density,TEMPORARY(density_temp)
;          append_Array,velocity_nobbf,TEMPORARY(velocity_nobbf_temp)
;          append_Array,temperature,TEMPORARY(temperature_temp)
;          append_Array,pressure,TEMPORARY(pressure_temp)
;        endif
;  
;        print,jj
;        toc
;  
;      endfor
;      print,'break1'
;      append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
;      append_Array,pos_gsm1,TEMPORARY(pos_gsm)
;      append_Array,B_gsm1,TEMPORARY(B_gsm)
;      append_Array,B_total1,TEMPORARY(B_total)
;  
;      append_Array,t_c3cis1,TEMPORARY(t_c3cis)
;      append_Array,density1,TEMPORARY(density)
;      append_Array,velocity_nobbf1,TEMPORARY(velocity_nobbf)
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
;    save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_nobbf1,temperature1,pressure1,$;tt_bbf_save,$
;      filename=root_dir+'c3_fgmcis_data_selected_'+names[kk]+'_nobbf3.sav'
;  
;    undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_nobbf1,temperature1,pressure1;,tt_bbf_save
;  endfor
;  save_time_c3fgmcis=(systime(1)-start)/3600.0
;  print,'save_time ',save_time_c3fgmcis,' hour'
;  
;      stop
  
  ;;________________________________part3_______________________
  
  
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  filename=file_search(root_dir+'*'+'_nobbf3.sav')

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
  velocity_no_bbf=list(a,/ex)
;  tt_bbf=list(a,/ex)
  
  
  for i=0,5 do begin
    restore,filename[i]
    counts[i]=n_elements(t_c3cis1)
    
    ;raw_data
    indext=where(temperature1 lt 32)    ;T [0.005,32] KeV
    indexv=where(abs((velocity_nobbf1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
    indexn=where((density1[indext])[indexv] le 100.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,10]             
    index_all=(([indext])[indexv])[indexn]
    
    t_c3cis[i]=t_c3cis1[index_all]
    density[i]=density1[index_all]
    temperature[i]=temperature1[index_all]
    pressure[i]=pressure1[index_all]
;    tt_bbf[i]=tt_bbf_save[index_all]
    
    B_gsm_x=B_gsm1[index_all,0]
    B_gsm_y=B_gsm1[index_all,1]
    B_gsm_z=B_gsm1[index_all,2]

    velocity_x=velocity_nobbf1[index_all,0]
    velocity_y=velocity_nobbf1[index_all,1]
    velocity_z=velocity_nobbf1[index_all,2]
    
    pos_gsm_x=pos_gsm1[index_all,0]
    pos_gsm_y=pos_gsm1[index_all,1]
    pos_gsm_z=pos_gsm1[index_all,2]
    
    B_gsm[i]=[[B_gsm_x],[B_gsm_y],[B_gsm_z]]
    velocity_no_bbf[i]=[[velocity_x],[velocity_y],[velocity_z]]
    pos_gsm[i]=[[pos_gsm_x],[pos_gsm_y],[pos_gsm_z]]
 
    ;event_data
    eventimes[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],[],reverse_gap)
    event_n[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],density[i],reverse_gap)
    event_t[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],temperature[i],reverse_gap)
    event_p[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],pressure[i],reverse_gap)
    event_vx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_no_bbf[i])[*,0],reverse_gap)
    event_vy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_no_bbf[i])[*,1],reverse_gap)

    H_Re[i]=return_thermal_energy_flow_density(pressure[i],(velocity_no_bbf[i])[*,0],(velocity_no_bbf[i])[*,1],(velocity_no_bbf[i])[*,2],2)
    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
    ;    H_Re.(i)[idxh]=!values.f_nan
    event_hx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,0],reverse_gap)
    event_hy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,1],reverse_gap)


    K_Re[i]=return_kinetic_energy_flow_density(density[i],(velocity_no_bbf[i])[*,0],(velocity_no_bbf[i])[*,1],(velocity_no_bbf[i])[*,2],2)
    event_kx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,0],reverse_gap)
    event_ky[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,1],reverse_gap)

    H_K_Re[i]=H_Re[i]+K_Re[i]
    event_h_k_x[i]=event_hx[i]+event_kx[i]
    event_h_k_y[i]=event_hy[i]+event_ky[i]

  endfor
  save,t_c3cis,B_gsm,pos_gsm,density,temperature,pressure,velocity_no_bbf,   $ ;tt_bbf_save, 
    filename=root_dir+'raw_data'+save_str+'_list_nobbf_median1.sav'
    
  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re,K_Re,H_K_Re,     $
    event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_nobbf_median1.sav'
      
 
  stop
 



 end