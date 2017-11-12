;cerated by G.M. Ren   2017.11.09

pro Create_raw_event_data_5minute_per_point_former

  
   Re=6371.0
   root_dir='C:\__Data\Datasave\2001_2009_5minute_per_point\'
   start=systime(1)
   compile_opt idl2

    a=findgen(58)
    t_beg=list(a,/ex)
    t_end=list(a,/ex)
    
    duration=list(a,/ex)
    for jj = 0, 57 do begin
      if (jj ge 0) and (jj le 28)  then duration[jj]=[jj*5+5,jj*5+10]*60.
      if (jj ge 29) and (jj le 57)  then duration[jj]=[(jj-29)*5+5,(jj-29)*5+10]*60.
    endfor
    
    
; ;________________________________part2_______________________    


   restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_5minute_per_point_add_former_time.sav'



   bb=findgen(60)


   names=strarr(60)
   for kk=0,59 do begin
     if kk le 29 then begin
       bz='_BZgt0_'
       te=strcompress((kk+1)*5,/remove)
     endif else begin
       bz='_BZle0_'
       te=strcompress((kk-29)*5,/remove)
     endelse

     if kk lt 2 then tb='00'+strcompress(kk*5,/remove)
     if kk ge 2 and kk lt 20 then tb='0'+strcompress(kk*5,/remove)
     if kk ge 20 and kk lt 29 then tb=strcompress(kk*5,/remove)

     if kk ge 30 and kk lt 30+2 then tb='00'+strcompress((kk-30)*5,/remove)
     if kk ge 30+2 and kk lt 30+20 then tb='0'+strcompress((kk-30)*5,/remove)
     if kk ge 30+20 and kk le 30+29 then tb=strcompress((kk-30)*5,/remove)

     names[kk]=bz+tb+'_'+te
   endfor


   for kk=0,59 do begin     ;
     tbeg=t_beg[kk]
     tend=t_end[kk]

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
           t_last_temp=(t_c3fgm_temp-tbeg[(index_terval[jj])])/60.0;+last_time_beg[kk]
           append_Array,t_last,TEMPORARY(t_last_temp)
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
       print,(systime(1)-start)/60.
       print,'break1'


       if is_array(t_last) then begin

         append_Array,t_last1,TEMPORARY(t_last)
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

       endif
       del_data,'*'
       print,ii

     endfor

     if is_array(t_c3cis1) then begin
       save,t_c3cis1,t_last1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
         filename=root_dir+'c3_fgmcisefw_data_selected_5minute_per_point'+names[kk]+'.sav'

       undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
       undefine,E_gsm1,t_last1,t_last_ture1;,tt_bbf_save
     endif

     print,(systime(1)-start)/60.
     print,ii
   endfor

   save_time_c3fgmcis=(systime(1)-start)/3600.0
   print,'save_time ',save_time_c3fgmcis,' hour'

   stop




      
  
end