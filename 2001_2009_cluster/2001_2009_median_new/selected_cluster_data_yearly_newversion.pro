pro selected_cluster_data_yearly_newversion
  
  Re=6371.0
  jj=0
  restore,'C:\__Data\Datasave\2001_2009_median_new\time_interval_divided_by_Bz.sav'

  for kk=0 ,3 do begin
    start=systime(1)
    case kk  of
      0:begin
         tbeg=t_beg.tbeg1
         tend=t_end.tend1
        end
      1:begin
         tbeg=t_beg.tbeg2
         tend=t_end.tend2
        end
      2:begin
         tbeg=t_beg.tbeg3
         tend=t_end.tend3
        end
      3:begin
         tbeg=t_beg.tbeg4
         tend=t_end.tend4
        end
    endcase
    names=['_BZgt0_duragt1hr','_BZgt0_durale1hr','_BZle0_duragt1hr','_BZle0_durale1hr']


    for ii=0,8 do begin
      year='200'+strcompress(ii+1,/remove)

      filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
      cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
       ; newname=['B_mag','B_gse','pos_gse']


      filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
      cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
        'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
      
      factor_to_kev=1.0;e6/(1000.0*11600)
      calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
      calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
      calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'           
      cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
      cotrans,'pos_gse','pos_gsm',/gse2gsm
      cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
      calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'    
      calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'  
      
      ;clean_spikes,'pressure',nsmooth=10
                
     ; interp(     
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

      index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
      time1=time[index]
      pos_gsm_interp=pos_gsm_interp[index,*]          ;  plasma sheet identified

      store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
      
      tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
      tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
      tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
      tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
      tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
      tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS   
                                                         
                                                      ;some removed bad points will come back when doing interpol   
;      rbsp_remove_spikes,'pressure_interp',/samename
;      rbsp_remove_spikes,'temperature_interp',/samename
;      rbsp_remove_spikes,'velocity_gsm_interp',/samename
;      rbsp_remove_spikes,'density_interp',/samename            ;remove bad points
;
;      tdeflag,'pressure_interp','remove_nan',/overwrite
;      tdeflag,'temperature_interp','remove_nan',/overwrite
;      tdeflag,'velocity_gsm_interp','remove_nan',/overwrite
;      tdeflag,'density_interp','remove_nan',/overwrite      
;                                                    ; bad points in different variables are located in different positions in array list       
      
      index=strfilter(time_string(tend,pre=-5),year,count=count,/index)
         

      for jj=index[0],index[count-1] do begin
        tic
        B_total_temp=tsample('B_total_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
        B_gsm_temp=tsample('B_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
        pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)

        if is_array(B_gsm_temp) then begin
          append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
          append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
          append_Array,B_gsm,TEMPORARY(B_gsm_temp)
          append_Array,B_total,TEMPORARY(B_total_temp)
        endif

        density_temp=tsample('density_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
        velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
        temperature_temp=tsample('temperature_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
        pressure_temp=tsample('pressure_interp',[tbeg[jj],tend[jj]],times=t_c3cis_temp)

        if is_array(density_temp) then begin
          append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
          append_Array,density,TEMPORARY(density_temp)
          append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
          append_Array,temperature,TEMPORARY(temperature_temp)
          append_Array,pressure,TEMPORARY(pressure_temp)
        endif
       
       print,jj
       toc
      
      endfor

      append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
      append_Array,pos_gsm1,TEMPORARY(pos_gsm)
      append_Array,B_gsm1,TEMPORARY(B_gsm)
      append_Array,B_total1,TEMPORARY(B_total)

      append_Array,t_c3cis1,TEMPORARY(t_c3cis)
      append_Array,density1,TEMPORARY(density)
      append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
      append_Array,temperature1,TEMPORARY(temperature)
      append_Array,pressure1,TEMPORARY(pressure)

      del_data,'*'
      print,ii

    endfor
    
    
    save_time_c3fgmcis=(systime(1)-start)/3600.0
    print,'save_time ',save_time_c3fgmcis,' hour'
    save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'

    save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,$
      filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected_'+names[kk]+'_yearly_newversion.sav'

    undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1
  endfor

   stop
end

