;cerated by G.M. Ren   2017.11.23


pro a2001_2012_create_raw_event_data_10minute_per_point_add_time_after_150_minutes
  
   Re=6371.0
   root_dir='C:\__Data\Datasave\2001_2012_10minute_per_point\'
   start=systime(1)
   compile_opt idl2    
    
; ;  ________________________________part1_______________________
    
    
    filename0=file_search('C:\__Data\OMNI\*.cdf') 
    
;    ;part1.1
;    a=findgen(30)
;    t_beg=list(a,/ex)
;    t_end=list(a,/ex)
;    duration=list(a,/ex)
;    marg=list(a,/ex)
;    error_point=list(a,/ex)
;
;    for jj=0,29 do begin
;      if (jj le 14) then begin
;        maxvalue=1000
;        minvalue=0
;      endif else begin
;        maxvalue=0  
;        minvalue=-1000
;      endelse
;      
;      if (jj eq 0 or jj eq 15) then duration[jj]=[4,10]*60.0
;      if (jj ge 1) and (jj le 14)  then  duration[jj]=[jj*10,jj*10+10]*60.
;      if (jj ge 16) and (jj le 29) then  duration[jj]=[(jj-15)*10,(jj-15)*10+10]*60.   ;duration
;      
;      if (jj eq 0 or jj eq 15) then marg[jj]=0*60.0
;      if (jj eq 1 or jj eq 16) then marg[jj]=1*60.0
;      if ((jj ge 2) and (jj le 14) or (jj ge 17) and (jj le 29)) then marg[jj]=2*60.0  ;marg
;      
;      if (jj eq 0 or jj eq 15) then error_point[jj]=2
;      if (jj eq 1 or jj eq 16) then error_point[jj]=3
;      if (jj eq 2 or jj eq 17) then error_point[jj]=5
;      if ((jj ge 3) and (jj le 14) or (jj ge 18) and (jj le 29)) then error_point[jj]=8  ;error_point
;       
;     for ii=0,143 do begin             ;divided by year
;       cdf2tplot,filename0[ii],varformat='BZ_GSM'
;       get_data,'BZ_GSM',time0,BZ_GSM0
;       append_array,time,time0
;       append_array,BZ_GSM,BZ_GSM0
;
;       if (((ii+1) mod 12) eq 0) or (ii eq 143) then begin
;        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
;        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=marg[jj],duration=duration[jj],nint=nint,tbeg=tbeg0,tend=tend0
;                
;        for i=0,n_elements(tbeg0)-1 do begin
;          tic
;          bz_tmep=tsample('BZ_GSM1',[tbeg0[i],tend0[i]],times=t_omni_temp)
;          if jj le 14 then indices=where(bz_tmep lt 0)
;          if jj gt 15 then indices=where(bz_tmep gt 0)
;        
;          if ( N_ELEMENTS(indices) le error_point[jj] ) then begin   ; 
;            append_Array,tbeg1,tbeg0[i]
;            append_Array,tend1,tend0[i]
;          endif
;          toc
;        endfor             
;        undefine,time,BZ_GSM
;       endif
;     endfor
;      t_beg[jj]=tbeg1
;      t_end[jj]=tend1
;      undefine,tbeg1,tend1
;      print,jj
;    endfor   
;    
;      savetime_t=(systime(1)-start)/60.0
;
;      save,t_beg,t_end,savetime_t,$
;      filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point.sav'
;    stop

 
;    ;part1.2   calc time after 150 minutes
;    tt_beg=list(length=2)
;    tt_end=list(length=2) 
; 
;    for jj=0,1 do begin
;      if (jj le 0) then begin
;        maxvalue=1000
;        minvalue=0
;      endif else begin
;        maxvalue=0
;        minvalue=-1000
;      endelse
;
;      duration=[150,6666666666]*60.   ;duration
;
;      marg=2*60.0  ;marg
;
;      error_point=8  ;error_point
;
;      for ii=0,143 do begin             ;divided by year
;        cdf2tplot,filename0[ii],varformat='BZ_GSM'
;        get_data,'BZ_GSM',time0,BZ_GSM0
;        append_array,time,time0
;        append_array,BZ_GSM,BZ_GSM0
;
;        if (((ii+1) mod 12) eq 0) or (ii eq 143) then begin
;          store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
;          find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=marg,duration=duration,nint=nint,tbeg=tbeg0,tend=tend0
;
;          for i=0,n_elements(tbeg0)-1 do begin
;            tic
;            bz_tmep=tsample('BZ_GSM1',[tbeg0[i],tend0[i]],times=t_omni_temp)
;            if jj eq 0 then indices=where(bz_tmep lt 0)
;            if jj eq 1 then indices=where(bz_tmep gt 0)
;
;            if ( N_ELEMENTS(indices) le error_point ) then begin   ;
;              append_Array,tbeg1,tbeg0[i]
;              append_Array,tend1,tend0[i]
;            endif
;            toc
;          endfor
;          undefine,time,BZ_GSM
;        endif
;      endfor
;      tt_beg[jj]=tbeg1
;      tt_end[jj]=tend1
;      undefine,tbeg1,tend1
;      print,jj
;    endfor
;    save,tt_beg,tt_end,filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_tt.sav' 
; 
;    ;part1.3  
;    ;
;    ; (first version I may think it wrong)revised 'append_array,t_end29,tt_beg[1]+150.0*60' remove duplicate points (when tt_beg[1]+150.0*60 eq tend29)
;    ; (2nd version I may think it right)  revised 'find_coti_interval.pro' ss=where(dura ge duration[0] and dura le duration[1],nss)   remove duplicate points (when duration[1] eq another duration[0])
;    restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point.sav' 
;    t_last_end=list(length=30)
;    for jj = 0, 29 do begin
;      if (jj ge 0)  and (jj le 14)  then t_last_end[jj]=((jj+1)*10)
;      if (jj ge 15) and (jj le 29)  then t_last_end[jj]=((jj-15+1)*10)
;    endfor
;    
;    for i=29,0,-1 do begin
;      tbeg=t_beg[i]
;      tend=t_end[i]
;      
;      indexx=where(tend-tbeg ne t_last_end[i]*60)
;      
;      tbeg1=tbeg[indexx]
;      tend1=tend[indexx]
;      
;      t_beg[i]=tbeg1
;      t_end[i]=tend1
;     ; stop
;    endfor
;   
;    save,t_beg,t_end,filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_remove_duplicate_points.sav'
;    
    
;    ;part1.4    add time after 150 minutes
;    restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_remove_duplicate_points.sav'
;    restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_tt.sav'  
;
;    t_beg14=t_beg[14]
;    t_end14=t_end[14]
;    append_array,t_beg14,tt_beg[0]
;    append_array,t_end14,tt_beg[0]+150.0*60
;    t_beg[14]=t_beg14
;    t_end[14]=t_end14
;    
;    t_beg29=t_beg[29]
;    t_end29=t_end[29]
;    append_array,t_beg29,tt_beg[1]
;    append_array,t_end29,tt_beg[1]+150.0*60
;    t_beg[29]=t_beg29
;    t_end[29]=t_end29            ;add time after 150 minutes
;    
;    aa=fltarr(30)
;    for i=0,29 do begin
;      aa[i]=N_ELEMENTS(t_end[i])
;    endfor
;     
;    time_array=(10*findgen(14)+10)*60.0 
;    
;    for i=14,4,-1 do begin
;      tb1=t_beg[i]
;      te1=t_end[i]
;      tb2=t_beg[i-1]
;      te2=t_end[i-1]
;      append_array,tb2,tb1
;      append_array,te2,tb1+time_array[i-1]   
;      t_beg[i-1]=tb2
;      t_end[i-1]=te2
;    
;      tb11=t_beg[i+15]
;      te11=t_end[i+15]
;      tb22=t_beg[i+14]
;      te22=t_end[i+14]
;      append_array,tb22,tb11
;      append_array,te22,tb11+time_array[i-1]
;      t_beg[i+14]=tb22
;      t_end[i+14]=te22
;  
;      print,i
;    endfor
;     
;   ; eliminate error point 
;;    restore,'C:\__Data\Datasave\omni_imf_bz.sav'
;;    store_data,'BZ_GSM1',time,bz_gsm
;     
;    error_p=[2,3,5]  
;    for i=3,1,-1 do begin
;  
;      ;bz_north
;      tb1=t_beg[i]
;      te1=t_end[i]
;      tb2=t_beg[i-1]
;      te2=t_end[i-1]
;      
;      for j=0,n_elements(tb1)-1 do begin ;
;        tic               
;       
;        tb_str=time_string(tb1[j],precision=-4,format=2)             
;        te_str=time_string(tb1[j]+time_array[i-1],precision=-4,format=2)       
;        filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')        
;        filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
;        if ( (filename1 eq filename2) eq 1b) then begin
;          filename=filename1
;        endif else begin
;          filename=[filename1,filename2]
;        endelse  
;                
;;        if(n_elements(filename) eq 1) then begin
;;          loadcdf,filename[0],'Epoch',time
;;          loadcdf,filename[0],'BZ_GSM',BZ_GSM
;;        endif else begin
;;          loadcdf,filename[0],'Epoch',time0
;;          loadcdf,filename[1],'Epoch',time1
;;          loadcdf,filename[0],'BZ_GSM',BZ_GSM0
;;          loadcdf,filename[1],'BZ_GSM',BZ_GSM1
;;          
;;          time=[time0,time1]
;;          BZ_GSM=[BZ_GSM0,BZ_GSM1]
;;        endelse
;;        
;;        store_data,'BZ_GSM',time,BZ_GSM
;                  
;        cdf2tplot,filename,varformat=['BZ_GSM'] 
;                                     
;        bz_temp=tsample('BZ_GSM',[tb1[j],tb1[j]+time_array[i-1]],times=t_omni_temp)
;        indices=where(bz_temp lt 0)
;                
;        if ( N_ELEMENTS(indices) le error_p[i-1] ) then begin   ;
;          append_Array,tb2,tb1[j]
;          append_Array,te2,tb1[j]+time_array[i-1]
;        endif
;        
;        toc
;      endfor
;     
;      t_beg[i-1]=tb2
;      t_end[i-1]=te2
;
;
;      ;bz south
;      tb11=t_beg[i+15]
;      te11=t_end[i+15]
;      tb22=t_beg[i+14]
;      te22=t_end[i+14]      
;      for j=0,n_elements(tb11)-1 do begin
;        
;        tb_str=time_string(tb11[j],precision=-4,format=2)             
;        te_str=time_string(tb11[j]+time_array[i-1],precision=-4,format=2)       
;        filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')        
;        filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
;        if ( (filename1 eq filename2) eq 1b) then begin
;          filename=filename1
;        endif else begin
;          filename=[filename1,filename2]
;        endelse
;        cdf2tplot,filename,varformat=['BZ_GSM']
;
;        
;        bz_temp=tsample('BZ_GSM',[tb11[j],tb11[j]+time_array[i-1]],times=t_omni_temp)
;        indices=where(bz_temp gt 0)
;
;        if ( N_ELEMENTS(indices) le error_p[i-1] ) then begin   ;
;          append_Array,tb22,tb11[j]
;          append_Array,te22,tb11[j]+time_array[i-1]
;        endif
;      endfor
;      t_beg[i+14]=tb22
;      t_end[i+14]=te22
;
;      print,i
;    endfor      
;      
;      
;    bb=fltarr(30)
;    for i=0,29 do begin
;      bb[i]=N_ELEMENTS(t_end[i])
;    endfor
;    
;    save_time=(systime(1)-start)/60.0
;    save,t_beg,t_end,save_time,  $
;          filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes_remove_duplicate_points.sav'
    
            
;    ;part 1.5    revised t_beg[0]
;    restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes_remove_duplicate_points.sav'
;    
;    maxn=[64221,63818]
;    for j=0,1 do begin
;      tbeg=t_beg[15*j]
;      tend=t_end[15*j]
;      a=0
;      tic
;      for i=0,n_elements(tbeg)-1 do begin
;        if i eq maxn[j] then break
;        toc
;        indexx=where(tbeg[i] eq tbeg)
;        if n_elements(indexx) gt 1  then begin                                      ; b eq duplicate begin
;          if is_equal(tend[indexx[0]],tend[indexx[1]]) then begin
;            a=a+1
;            cc=indgen(n_elements(tbeg),/long)-indexx[0]
;            indexw=where(cc ne 0)
;            tbeg=tbeg[indexw]
;            tend=tend[indexw]
;            i=i-1
;            print,'i', i
;          endif
;        endif
;      endfor
;      ;stop
;      t_beg[15*j]=tbeg
;      t_end[15*j]=tend
;    endfor
;
;    save,t_beg,t_end,  $
;          filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0.sav'
;    stop
;  
  ; ________________________________part2________________________________________
     
    
     ;part2.1
     for ii=9,10 do begin
       year='20'+strcompress(ii+1,/remove)
    
       filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
       cdf2tplot,filename1,varformat='*';['B_mag__C1_CP_FGM_SPIN','B_vec_xyz_gse__C1_CP_FGM_SPIN','sc_pos_xyz_gse__C1_CP_FGM_SPIN']
       ; newname=['B_mag','B_gse','pos_gse']
    
    
       filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
       cdf2tplot,filename2,varformat='*';['density__C1_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C1_CP_CIS-HIA_ONBOARD_MOMENTS',$
        ; 'temperature__C1_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C1_CP_CIS-HIA_ONBOARD_MOMENTS']
    
       filename3=file_search('C:\__Data\Cluster\EFW\C3_CP_EFW_L3_E3D_GSE\*__'+year+'*.cdf')
       cdf2tplot,filename3,varformat='*';['E_Vec_xyz_GSE__C3_CP_EFW_L3_E3D_GSE']
    
       factor_to_kev=1.0e6/(1000.0*11600)
       calc,'"temperature"="temperature__C1_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
       calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
       calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
    
       cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
       cotrans,'pos_gse','pos_gsm',/gse2gsm
       cotrans,'velocity_gse__C1_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
       cotrans,'E_Vec_xyz_GSE__C3_CP_EFW_L3_E3D_GSE','E_gsm',/gse2gsm
    
       calc,'"density"="density__C1_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
       calc,'"pressure"="pressure__C1_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
    
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
    
       get_Data,'pos_gsm_interp',time_all,pos_gsm_interp
       get_Data,'velocity_gsm_interp',time_all,velocity_gsm_interp
       get_Data,'B_total_interp',time_all,B_total_interp
       get_Data,'B_gsm_interp',time_all,B_gsm_interp
       get_Data,'density_interp',time_all,density_interp
       get_Data,'temperature_interp',time_all,temperature_interp
       get_Data,'pressure_interp',time_all,pressure_interp
       get_Data,'Beta_clip_deflag_interp',time_all,Beta_clip_deflag_interp
       get_Data,'E_gsm_interp',time_all,E_gsm_interp
    
       save,time_all,pos_gsm_interp,velocity_gsm_interp,B_total_interp,B_gsm_interp,density_interp,$
         temperature_interp,pressure_interp,Beta_clip_deflag_interp,E_gsm_interp,$
         filename='C:\__Data\Datasave\variables_fgm_cis_efw'+year+'.sav'
       del_data,'*'
       help,a
     endfor
     print,(systime(1)-start)/60.0
     
     stop

    
;     ;part2.2
;     restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0.sav'
;     
;     tic            
;     names=strarr(30)
;     for kk=0,29 do begin
;       if kk le 14 then begin
;         bz='_BZgt0_'
;         te=strcompress((kk+1)*10,/remove)
;       endif else begin
;         bz='_BZle0_'
;         te=strcompress((kk+1-15)*10,/remove)
;       endelse
;    
;       if kk lt 1 then tb='00'+strcompress(kk*10,/remove)
;       if kk ge 1 and kk lt 10 then tb='0'+strcompress(kk*10,/remove)
;       if kk ge 10 and kk le 14  then tb=strcompress(kk*10,/remove)
;    
;       if kk ge 15 and kk lt 15+1 then tb='00'+strcompress((kk-15)*10,/remove)
;       if kk ge 15+1 and kk lt 15+10 then tb='0'+strcompress((kk-15)*10,/remove)
;       if kk ge 15+10 and kk le 15+14 then tb=strcompress((kk-15)*10,/remove)
;    
;       names[kk]=bz+tb+'_'+te
;     endfor
;    
;    
;     for kk=15,15 do begin     ;
;       tbeg=t_beg[kk]
;       tend=t_end[kk]
;    
;       for ii=0,8 do begin   ;0-8
;         year='200'+strcompress(ii+1,/remove)
;    
;         restore,filename='C:\__Data\Datasave\variables_fgm_cis_efw'+year+'.sav'      ;if using tplot_restore, the efficiency of code runnig is too low because of too many superfluous variables
;         store_Data,'pos_gsm_interp',data={x:time_all,y:pos_gsm_interp}
;         store_Data,'velocity_gsm_interp',data={x:time_all,y:velocity_gsm_interp}
;         store_Data,'B_total_interp',data={x:time_all,y:B_total_interp}
;         store_Data,'B_gsm_interp',data={x:time_all,y:B_gsm_interp}
;         store_Data,'density_interp',data={x:time_all,y:density_interp}
;         store_Data,'temperature_interp',data={x:time_all,y:temperature_interp}
;         store_Data,'pressure_interp',data={x:time_all,y:pressure_interp}
;         store_Data,'Beta_clip_deflag_interp',data={x:time_all,y:Beta_clip_deflag_interp}
;         store_Data,'E_gsm_interp',data={x:time_all,y:E_gsm_interp}
;    
;         index_terval=strfilter(time_string(tend,pre=-5),year,count=count,/index)
;    
;         for jj=0,count-1 do begin
;           tic
;    
;           B_total_temp=tsample('B_total_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;           B_gsm_temp=tsample('B_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;           pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
;           ;attention!!!selcet bbf  change this tplot variable
;    
;    
;           if is_array(B_gsm_temp) then begin
;             t_last_temp=(t_c3fgm_temp-tbeg[(index_terval[jj])])/60.0;+last_time_beg[kk]
;             append_Array,t_last,TEMPORARY(t_last_temp)
;             append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
;             append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
;             append_Array,B_gsm,TEMPORARY(B_gsm_temp)
;             append_Array,B_total,TEMPORARY(B_total_temp)
;          
;           endif
;           
;              
;           density_temp=tsample('density_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;           velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;           temperature_temp=tsample('temperature_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;           pressure_temp=tsample('pressure_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;           Beta_temp=tsample('Beta_clip_deflag_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
;    
;           if is_array(density_temp) then begin
;             append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
;             append_Array,density,TEMPORARY(density_temp)
;             append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
;             append_Array,temperature,TEMPORARY(temperature_temp)
;             append_Array,pressure,TEMPORARY(pressure_temp)
;             append_Array,Beta,TEMPORARY(Beta_temp)
;           endif
;    
;           E_gsm_temp=tsample('E_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3efw_temp)
;           if is_array(E_gsm_temp) then begin
;             append_Array,t_c3efw,TEMPORARY(t_c3efw_temp)
;             append_Array,E_gsm,TEMPORARY(E_gsm_temp)
;           endif
;    
;           print,jj
;           toc
;    
;         endfor
;    
;         print,(systime(1)-start)/60.
;         print,'break1'
;    
;         if is_array(t_last) then begin
;    
;           append_Array,t_last1,TEMPORARY(t_last)
;           append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
;           append_Array,pos_gsm1,TEMPORARY(pos_gsm)
;           append_Array,B_gsm1,TEMPORARY(B_gsm)
;           append_Array,B_total1,TEMPORARY(B_total)
;    
;           append_Array,t_c3cis1,TEMPORARY(t_c3cis)
;           append_Array,density1,TEMPORARY(density)
;           append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
;           append_Array,temperature1,TEMPORARY(temperature)
;           append_Array,pressure1,TEMPORARY(pressure)
;           append_Array,Beta1,TEMPORARY(Beta)
;    
;           append_Array,t_c3efw1,TEMPORARY(t_c3efw)
;           append_Array,E_gsm1,TEMPORARY(E_gsm)
;           
;         endif
;         del_data,'*'
;         print,ii
;    
;       endfor
;    
;       if is_array(t_c3cis1) then begin
;         save,t_c3cis1,t_last1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
;           filename=root_dir+'remove_duplicate_points_c3_fgmcisefw_data_selected_10minute_per_point_add_time_after_150_minutes'+names[kk]+'_revised_tbeg0.sav'
;         ; only tbeg[0] and tbeg[15] need to be revised
;         undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
;         undefine,E_gsm1,t_last1,t_last_ture1;,tt_bbf_save
;       endif
;        print,(systime(1)-start)/60.
;       print,jj
;     endfor
;    
;     save_time_c3fgmcis=(systime(1)-start)/3600.0
;     print,'save_time ',save_time_c3fgmcis,' hour'
;     
;     toc
;     stop


; ; ________________________________part3_______________________


    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
    filename=file_search(root_dir+'remove_duplicate_points_c3_fgmcisefw_data_selected'+'*.sav')
    counts=n_elements(filename)
         
    a=findgen(counts)
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
    
    E_gsm_y=list(a,/ex)
    event_ey=list(a,/ex)
    v_X_b_y=list(a,/ex)
    event_evy=list(a,/ex)
    
    t_c3cis=list(a,/ex)
    B_gsm=list(a,/ex)
    pos_gsm=list(a,/ex)
    density=list(a,/ex)
    temperature=list(a,/ex)
    pressure=list(a,/ex)
    velocity_gsm=list(a,/ex) 
    t_last=list(a,/ex)
    
        
    t_last_beg=list(a,/ex)
    for jj = 0, 29 do begin
      if (jj ge 0) and (jj le 14)  then t_last_beg[jj]=(jj*10)
      if (jj ge 15) and (jj le 29)  then t_last_beg[jj]=((jj-15)*10)
    endfor
    
    bb=fltarr(counts)
    
    for i=0,counts-1 do begin
      restore,filename[i]
     
      indext=where(temperature1 lt 32)    ;T [0.005,32] KeV    ( gt 0.52kev hot) 
      indexv=where(abs((velocity_gsm1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
      indexn=where((density1[indext])[indexv] le 10.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,100]
      ;indexey=where(E_gsm1[(([indext])[indexv])[indexn],1] gt 0)     ;ey gt 0
      index_all=((([indext])[indexv])[indexn]);[indexey]
    
      indextl=where(t_last1[index_all] ge  t_last_beg[i] )
      index_all=(index_all)[indextl]
      region_Str=''

;      index_pos=where(pos_gsm1[index_all,1] gt 0.0 ) & region_str='_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  ) & region_str='_dawnflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  and pos_gsm1[index_all,0] lt -15.0) & region_str='_far_dawnflank'
;      index_pos=where(pos_gsm1[index_all,1] gt 0.0  and pos_gsm1[index_all,0] lt -15.0) & region_str='_far_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] gt 0.0  and pos_gsm1[index_all,0] ge -15.0) & region_str='_near_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  and pos_gsm1[index_all,0] ge -15.0) & region_str='_near_dawnflank'
;      index_pos=where(pos_gsm1[index_all,0] gt -19.0 and pos_gsm1[index_all,0] le -16.0 $
;                  and pos_gsm1[index_all,1] gt  3.0  and pos_gsm1[index_all,1] le 6.0) & region_str='_dusk_3_3re'
      index_pos=where(pos_gsm1[index_all,0] gt -19.0 and pos_gsm1[index_all,0] le -16.0 $
                   and pos_gsm1[index_all,1] gt -6.0  and pos_gsm1[index_all,1] le -3.0) & region_str='_dawn_3_3re'
      index_all=(index_all)[index_pos]
    
      t_c3cis[i]=t_c3cis1[index_all]
      t_last[i]=t_last1[index_all]
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
    
      E_gsm_y[i]=E_gsm1[index_all,1]
      v_X_b_y[i]=1.0e-3*(velocity_x*B_gsm_z-B_gsm_x*velocity_z)
      
      H_Re[i]=return_thermal_energy_flow_density(pressure[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
      K_Re[i]=return_kinetic_energy_flow_density(density[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
      H_K_Re[i]=H_Re[i]+K_Re[i]

      bb[i]=n_elements(density[i])
    
      ;event_data
      eventimes[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],[],reverse_gap)
      event_n[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],density[i],reverse_gap)
      event_t[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],temperature[i],reverse_gap)
      event_p[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],pressure[i],reverse_gap)
      event_vx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,0],reverse_gap)
      event_vy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,1],reverse_gap)
      event_ey[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],E_gsm_y[i],reverse_gap)
      event_evy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],v_X_b_y[i],reverse_gap)

      event_hx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,0],reverse_gap)
      event_hy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,1],reverse_gap)
     
      event_kx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,0],reverse_gap)
      event_ky[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,1],reverse_gap)
    
      event_h_k_x[i]=event_hx[i]+event_kx[i]
      event_h_k_y[i]=event_hy[i]+event_ky[i]
      
      print,i
    endfor
    
;    save,t_last,eventimes,event_n,event_t,event_p,event_vx,event_vy,event_ey,event_evy,     $
;      event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'remove_duplicate_points_event_data'+save_str+'_list_10minute_per_point'+region_str+'.sav'
   
     save,t_c3cis,t_last,density,temperature,pressure,velocity_gsm,B_gsm,pos_gsm,E_gsm_y,v_X_b_y,H_Re,K_Re,H_K_Re,    $
      filename=root_dir+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_str+'.sav'
    stop
      
  
end