 pro cluster_energy_flux_density_statistics_data_44_pieces_add_Ey
    Re=6371.0
    root_dir='C:\__Data\Datasave\2001_2009_44_pieces\'
    start=systime(1)
;;  ________________________________part1_______________________
;    compile_opt idl2
;    a=findgen(42)
;    t_beg=list(a,/ex)
;    t_end=list(a,/ex)
;    
;    filename0=file_search('C:\__Data\OMNI\*.cdf')
;      
;    for jj=0,41 do begin
;      if (jj le 20) then begin
;        maxvalue=1000
;        minvalue=0
;      endif else begin
;        maxvalue=0
;        minvalue=-1000
;      endelse
;;      if (jj eq 0) or (jj eq 15)  then duration=[5*60.,15*60.]
;;      if (jj eq 14) or (jj eq 29)  then duration=[(10*14+10)*60.,666666.66*60.]
;;      if (jj ge 1) and (jj le 13)  then duration=[10*jj*60.,(10*jj+20)*60.]
;;      if (jj ge 16) and (jj le 28)  then duration=[10*(jj-15)*60.,(10*(jj-15)+20)*60.]
;     ;
;     
;     dura=60*[[05,10],[10,15],[15,20],[20,25],[25,30],[30,35],[35,40],[40,45],[45,50],[50,55],[55,60], $
;              [60,70],[70,80],[80,90],[90,100],[100,110],[110,120],[120,150],[150,180],[180,210],[210,66666666.66],$
;              [05,10],[10,15],[15,20],[20,25],[25,30],[30,35],[35,40],[40,45],[45,50],[50,55],[55,60], $
;              [60,70],[70,80],[80,90],[90,100],[100,110],[110,120],[120,150],[150,180],[180,210],[210,66666666.66]]
;     
;     ;error gap
;     if (jj le 10 or (jj ge 21 and jj le 31)) then begin
;        marg=1*60
;     endif else begin
;        marg=2*60
;     endelse
;
;      for ii=0,106 do begin             ;divided by year
;       cdf2tplot,filename0[ii],varformat='BZ_GSM'
;       get_data,'BZ_GSM',time0,BZ_GSM0
;       append_array,time,time0
;       append_array,BZ_GSM,BZ_GSM0
;      
;       if (((ii+1) mod 12) eq 0) or (ii eq 106) then begin
;        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
;        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=marg,duration=dura[*,jj],nint=nint,tbeg=tbeg0,tend=tend0
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
;   
;
;  save,t_beg,t_end,$
;    filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_42_pieces_1.sav'
;  print,(systime(1)-start)/60.
;   stop
;  
;  
;  ;part_1_later
;  restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_42_pieces_1.sav'
;  t_b=t_beg
;  t_e=t_end
;  
;  aa=fltarr(42)
;  for i=0,41 do begin
;    aa[i]=N_ELEMENTS(t_end[i])
;  endfor
;  
;  time_array=[10,15,20,25,30,35,40,45,50,55,60,70,80,90,100,110,120,150,180,210]*60.
;  for i=20,1,-1 do begin
;    tb1=t_b[i]
;    te1=t_e[i]
;    tb2=t_b[i-1]
;    te2=t_e[i-1]
;    append_array,tb2,tb1
;    append_array,te2,tb1+time_array[i-1]
;    
;    t_beg[i-1]=tb2
;    t_end[i-1]=te2
;    
;    tb11=t_b[i+21]
;    te11=t_e[i+21]
;    tb22=t_b[i+20]
;    te22=t_e[i+20]
;    append_array,tb22,tb11
;    append_array,te22,tb11+time_array[i-1]
;
;    t_beg[i+20]=tb22
;    t_end[i+20]=te22
;    
;
;    print,i 
;  endfor
;    t_beg.add,t_beg[21],21
;    t_end.add,t_beg[21]+5*60.0,21
;    
;    t_beg.add,t_beg[0],0
;    t_end.add,t_beg[0]+5*60.0,0
;    
;    
;    
;  bb=fltarr(44)
;  for i=0,43 do begin
;    bb[i]=N_ELEMENTS(t_end[i])
;  endfor  
;   
;  save,t_beg,t_end,$
;        filename=root_dir+'time_interval_divided_by_Bz_yearly_add_former_time_44_pieces.sav'
;  
;
;  stop
;


 ;  ________________________________part2_______________________
     restore,root_dir+'time_interval_divided_by_Bz_yearly_add_former_time_44_pieces.sav'

     
     for kk=0,43 do begin
     tbeg=t_beg[kk]
     tend=t_end[kk]
    
     names=['_BZgt0_000_05','_BZgt0_005_10','_BZgt0_010_15','_BZgt0_015_20','_BZgt0_020_25','_BZgt0_025_30','_BZgt0_030_35',$
            '_BZgt0_035_40','_BZgt0_040_45','_BZgt0_045_50','_BZgt0_050_55','_BZgt0_055_60','_BZgt0_060_70','_BZgt0_070_80',$
            '_BZgt0_080_90','_BZgt0_090_100','_BZgt0_100_110','_BZgt0_110_120','_BZgt0_120_150','_BZgt0_150_180','_BZgt0_180_210','_BZgt0_gt_210', $
            '_BZle0_000_05','_BZle0_005_10','_BZle0_010_15','_BZle0_015_20','_BZle0_020_25','_BZle0_025_30','_BZle0_030_35',$
            '_BZle0_035_40','_BZle0_040_45','_BZle0_045_50','_BZle0_050_55','_BZle0_055_60','_BZle0_060_70','_BZle0_070_80',$
            '_BZle0_080_90','_BZle0_090_100','_BZle0_100_110','_BZle0_110_120','_BZle0_120_150','_BZle0_150_180','_BZle0_180_210','_BZle0_gt_210']
  

      for ii=0,8 do begin   ;0-8
        year='200'+strcompress(ii+1,/remove)
  
        filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
        cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
        ; newname=['B_mag','B_gse','pos_gse']
  
  
        filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
        cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
          'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
        
        filename3=file_search('C:\__Data\Cluster\EFW\C3_CP_EFW_L3_E3D_GSE\*__'+year+'*.cdf')
        cdf2tplot,filename3,varformat=['E_Vec_xyz_GSE__C3_CP_EFW_L3_E3D_GSE']
        
        factor_to_kev=1.0e6/(1000.0*11600)
        calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
        calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
        calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
        
        cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
        cotrans,'pos_gse','pos_gsm',/gse2gsm
        cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
        cotrans,'E_Vec_xyz_GSE__C3_CP_EFW_L3_E3D_GSE','E_gsm',/gse2gsm
        
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
        tinterpol_mxn,'E_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
  

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
          
          E_gsm_temp=tsample('E_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3efw_temp)
          if is_array(E_gsm_temp) then begin
            append_Array,t_c3efw,TEMPORARY(t_c3efw_temp)
            append_Array,E_gsm,TEMPORARY(E_gsm_temp)
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
        
        append_Array,t_c3efw1,TEMPORARY(t_c3efw)
        append_Array,E_gsm1,TEMPORARY(E_gsm)
        
        del_data,'*'
        print,ii
  
      endfor
  
  
      save,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
            filename=root_dir+'c3_fgmcisefw_data_selected_'+names[kk]+'.sav'

  
      undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
      undefine,E_gsm1;,tt_bbf_save
      
    endfor
    
    save_time_c3fgmcis=(systime(1)-start)/3600.0
    print,'save_time ',save_time_c3fgmcis,' hour'
  
   stop

   
  
  ;________________________________part3________________________
  
  
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  filename=file_search(root_dir+'c3_fgmcis_data_selected__BZ'+'*.sav')
  counts=make_array(32)

   
  a=findgen(32)
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
  
  
  bb=fltarr(32)

  for i=0,31 do begin
    restore,filename[i]
    counts[i]=n_elements(t_c3cis1)
    
    ;raw_data
    indext=where(temperature1 lt 32)    ;T [0.005,32] KeV
    indexv=where(abs((velocity_gsm1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
    indexn=where((density1[indext])[indexv] le 10.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,100]
    index_all1=(([indext])[indexv])[indexn]
    
    index_all=where( pos_gsm1[index_all1,0] gt -15.0 and pos_gsm1[index_all1,0] le -10.0)

    t_c3cis[i]=t_c3cis1[index_all]
    density[i]=density1[index_all]
    temperature[i]=temperature1[index_all]
    pressure[i]=pressure1[index_all]
   
    B_gsm_x=B_gsm1[index_all,0]
    B_gsm_y=B_gsm1[index_all,1]
    B_gsm_z=B_gsm1[index_all,2]
    B_gsm[i]=[[B_gsm_x],[B_gsm_y],[B_gsm_z]]
    
    velocity_x=velocity_gsm1[index_all,0]
    velocity_y=velocity_gsm1[index_all,1]
    velocity_z=velocity_gsm1[index_all,2]
    velocity_gsm[i]=[[velocity_x],[velocity_y],[velocity_z]]

    pos_gsm_x=pos_gsm1[index_all,0]
    pos_gsm_y=pos_gsm1[index_all,1]
    pos_gsm_z=pos_gsm1[index_all,2]
    pos_gsm[i]=[[pos_gsm_x],[pos_gsm_y],[pos_gsm_z]]
    
    bb[i]=n_elements(velocity_x)
    
    ;event_data
    eventimes[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],[],reverse_gap)
    event_n[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],density[i],reverse_gap)
    event_t[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],temperature[i],reverse_gap)
    event_p[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],pressure[i],reverse_gap)
    event_vx[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,0],reverse_gap)
    event_vy[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,1],reverse_gap)

    H_Re[i]=return_thermal_energy_flow_density(pressure[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
    ;    idxh=where(abs(H_Re.(i)) gt 1000.0)
    ;    H_Re.(i)[idxh]=!values.f_nan
    event_hx[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,0],reverse_gap)
    event_hy[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,1],reverse_gap)


    K_Re[i]=return_kinetic_energy_flow_density(density[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
    event_kx[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,0],reverse_gap)
    event_ky[i]=return_vari_event_5_30_near((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,1],reverse_gap)

    H_K_Re[i]=H_Re[i]+K_Re[i]
    event_h_k_x[i]=event_hx[i]+event_kx[i]
    event_h_k_y[i]=event_hy[i]+event_ky[i]

  endfor

  save,counts,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re,K_Re,H_K_Re,     $
    event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'event_data'+save_str+'_list_32_pieces_event_5_30_near.sav'

  save,t_c3cis,density,temperature,pressure,velocity_gsm,B_gsm,pos_gsm,    $
                           filename=root_dir+'raw_data'+save_str+'_list_32_pieces_event_5_30_near.sav'
  stop
  
 
  end