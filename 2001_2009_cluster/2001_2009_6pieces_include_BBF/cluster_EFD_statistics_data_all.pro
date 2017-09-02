pro cluster_EFD_statistics_data_all
    start=systime(1)
     ; plus  bbf data and no_bbf data
    
    Re=6371.0
    root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  
  
; ;  ________________________________method1___________bbf plus no_bbf data____________  
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
      eventimes[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap,1) ;type=1,median;type=2,mean
      event_n[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap,1)
      event_t[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap,1)
      event_p[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap,1)
      event_vx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_all1[*,0],reverse_gap,1)
      event_vy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_all1[*,1],reverse_gap,1)
  
      H_Re[i]=return_thermal_energy_flow_density(pressure1,velocity_all1[*,0],velocity_all1[*,1],velocity_all1[*,2],2)
      ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
      ;    H_Re.(i)[idxh]=!values.f_nan
      event_hx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,0],reverse_gap,1)
      event_hy[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(H_Re[i])[*,1],reverse_gap,1)
  
  
      K_Re[i]=return_kinetic_energy_flow_density(density1,velocity_all1[*,0],velocity_all1[*,1],velocity_all1[*,2],2)
      event_kx[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,0],reverse_gap,1)
      event_ky[i]=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],(K_Re[i])[*,1],reverse_gap,1)
  
      H_K_Re[i]=H_Re[i]+K_Re[i]
      event_h_k_x[i]=event_hx[i]+event_kx[i]
      event_h_k_y[i]=event_hy[i]+event_ky[i]
  
    endfor
  
    save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,     $
      event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_all_plus_median.sav'
  
    save,t_c3cis_all,pos_gsm_all,b_gsm_all,density_all,temperature_all,pressure_all,velocity_all,H_Re,K_Re,H_K_Re,    $
      filename=root_dir+'raw_data'+save_str+'_list_all_plus.sav'
    stop 




   ;  ________________________________method2_______________________
    restore,root_dir+'time_interval_divided_by_Bz_yearly_add_former_time.sav'

    for kk=0,5 do begin
     tbeg=t_beg[kk]
     tend=t_end[kk]

     names=['_BZgt0_05_30','_BZgt0_30_90','_BZgt0_gt_90','_BZle0_05_30','_BZle0_30_90','_BZle0_gt_90']
     
      for ii=0,8 do begin   ;0-8
        year='200'+strcompress(ii+1,/remove)

        filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
        cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
        ; newname=['B_mag','B_gse','pos_gse']


        filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
        cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
          'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']

        factor_to_kev=1.0e6/(1000.0*11600)
        calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
        calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
        calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
        cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
        cotrans,'pos_gse','pos_gsm',/gse2gsm
        cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
        calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
        calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'

        ;clean_spikes,'pressure',nsmooth=10

        tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR,/IGNORE_NANS

        beta_fac=1.0e-9/(1.0e-9)^2
        miu0=!pi*4e-7
        calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
        tclip,'Beta',0.3,10000
        tdeflag,'Beta_clip','remove_nan'                 ; beta identified

        tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR,/IGNORE_NANS
        get_data,'pos_gsm_interp',time,pos_gsm_interp

        index_ps=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
        time1=time[index_ps]
        pos_gsm_interp=pos_gsm_interp[index_ps,*]          ;  plasma sheet identified

        store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}

        tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
        tinterpol_mxn,'Beta_clip_deflag','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS



        index_terval=strfilter(time_string(tend,pre=-5),year,count=count,/index)

        for jj=0,count-1 do begin
          tic

          B_total_temp=tsample('B_total_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
          B_gsm_temp=tsample('B_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
          pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
                                     ;attention!!!selcet bbf  change this tplot variable

          if is_array(B_gsm_temp) then begin
            append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
            append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
            append_Array,B_gsm,TEMPORARY(B_gsm_temp)
            append_Array,B_total,TEMPORARY(B_total_temp)
          endif

          density_temp=tsample('density_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
          velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
          temperature_temp=tsample('temperature_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
          pressure_temp=tsample('pressure_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
          Beta_temp=tsample('Beta_clip_deflag_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)


          if is_array(density_temp) then begin
            append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
            append_Array,density,TEMPORARY(density_temp)
            append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
            append_Array,temperature,TEMPORARY(temperature_temp)
            append_Array,pressure,TEMPORARY(pressure_temp)
            append_Array,Beta,TEMPORARY(Beta_temp)
          endif

          print,jj
          toc

        endfor
        print,'break1'
        append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
        append_Array,pos_gsm1,TEMPORARY(pos_gsm)
        append_Array,B_gsm1,TEMPORARY(B_gsm)
        append_Array,B_total1,TEMPORARY(B_total)

        append_Array,t_c3cis1,TEMPORARY(t_c3cis)
        append_Array,density1,TEMPORARY(density)
        append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
        append_Array,temperature1,TEMPORARY(temperature)
        append_Array,pressure1,TEMPORARY(pressure)
        append_Array,Beta1,TEMPORARY(Beta)

        del_data,'*'
        print,ii

      endfor


      save,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,$;$
            filename=root_dir+'c3_fgmcis_data_selected_'+names[kk]+'_all.sav'


      undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1;,tt_bbf_save
    endfor

    save_time_c3fgmcis=(systime(1)-start)/3600.0
    print,'save_time ',save_time_c3fgmcis,' hour'

    stop



end



