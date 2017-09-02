
pro save_data_C3_FGM_CIS_2001_2009
   compile_opt idl2
   
   Re=6371.0
   
  start=systime(1)
  filename0=file_search('C:\__Data\OMNI\*.cdf')
  filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*.cdf')
  filename2=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*.cdf',count=count2)
  
;  filename22=filename0[0]
;  loadcdf,filename22,'Epoch',time1
;  
;  ;__________________________omni____________________________________
;   for j=0,106 do begin
;      print,j
;      filename=filename0[j]
;      loadcdf,filename,'Epoch',time
;      loadcdf,filename,'BZ_GSM',Bz_tmp
;      loadcdf,filename,'Vx',Vx_gse
;      loadcdf,filename,'Vy',Vy_gse
;      loadcdf,filename,'Vz',Vz_gse
;      loadcdf,filename,'Pressure',p_tmp
;      loadcdf,filename,'AE_INDEX',AE_tmp
;      loadcdf,filename,'SYM_H',SYM_tmp
;  
;      row=n_elements(time)
;      V_gsm=dblarr(3,row)
;  
;      for i=0,row-1L do begin
;        if(abs(Bz_tmp[i]) gt 1.0e3)  then Bz_tmp[i]=!values.d_nan
;        if(abs(Vx_gse[i]) gt 2.0e4)  then Vx_gse[i]='nan'
;        if(abs(Vy_gse[i]) gt 2.0e4)  then Vy_gse[i]='nan'
;        if(abs(Vz_gse[i]) gt 2.0e4)  then Vz_gse[i]='nan'
;        if(abs(p_tmp[i]) gt 98.0)    then p_tmp[i]='nan'
;      endfor
;  
;      ;-----------geopack-----------------------------------------------------------------------------------------
;      for i=0L,row-1L do begin
;        CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
;        doy=julday(mo,dy,yr)-julday(01,01,yr)+1
;  
;        geopack_recalc,yr,doy,hr,mn,sc
;        geopack_conv_coord,Vx_gse[i],Vy_gse[i],Vy_gse[i],Vx_gsm,Vy_gsm,Vz_gsm,/from_gse,/to_gsm
;        V_gsm[0,i]=Vx_gsm
;        V_gsm[1,i]=Vy_gsm
;        V_gsm[2,i]=Vz_gsm
;      endfor
;  
;      if (j eq 0) then begin
;        time_omni=time
;        Vx=reform(V_gsm[0,*])
;        Vy=reform(V_gsm[1,*])
;        Vz=reform(V_gsm[2,*])
;        Bz_imf=Bz_tmp
;        p=p_tmp
;        AE_index=AE_tmp
;        SYM_H=SYM_tmp
;      endif else begin
;        time_omni=[time_omni,time]
;        Vx=[Vx,reform(V_gsm[0,*])]
;        Vy=[Vy,reform(V_gsm[1,*])]
;        Vz=[Vz,reform(V_gsm[2,*])]
;        Bz_imf=[Bz_imf,Bz_tmp]
;        p=[p,p_tmp]
;        AE_index=[AE_index,AE_tmp]
;        SYM_H=[SYM_H,SYM_tmp]
;      endelse
;     t_omni=(time-time1[0])/60000.0
;     
;     if(j eq 0) then begin
; 
;     data=divide_bz(t_omni,Bz_tmp,p_tmp,reform(V_gsm[0,*]))
;     bz1=data.bz1
;     bz2=data.bz2
;     bz3=data.bz3 
;     bz4=data.bz4
;     t1_omni=data.t1_omni
;     t2_omni=data.t2_omni
;     t3_omni=data.t3_omni
;     t4_omni=data.t4_omni
;     bzt=reform(data.bzt,24)
;     pt=reform(data.pt,24)
;     vxt=reform(data.vxt,24)
;     
;     
;     endif else begin
;      data_tmp=divide_bz(t_omni,Bz_tmp,p_tmp,reform(V_gsm[0,*]))
;      bz1_tmp=data_tmp.bz1
;      bz2_tmp=data_tmp.bz2
;      bz3_tmp=data_tmp.bz3
;      bz4_tmp=data_tmp.bz4
;      t1_omni_tmp=data_tmp.t1_omni
;      t2_omni_tmp=data_tmp.t2_omni
;      t3_omni_tmp=data_tmp.t3_omni
;      t4_omni_tmp=data_tmp.t4_omni
;      bzt_tmp=reform(data_tmp.bzt,24)
;      pt_tmp=reform(data_tmp.pt,24)
;      vxt_tmp=reform(data_tmp.vxt,24)
;    
;      bz1=[bz1,bz1_tmp]
;      bz2=[bz2,bz2_tmp]
;      bz3=[bz3,bz3_tmp]
;      bz4=[bz4,bz4_tmp]
;      t1_omni=[t1_omni,t1_omni_tmp]
;      t2_omni=[t2_omni,t2_omni_tmp]
;      t3_omni=[t3_omni,t3_omni_tmp]
;      t4_omni=[t4_omni,t4_omni_tmp]
;      bzt=bzt+bzt_tmp
;      pt=pt+pt_tmp
;      vxt=vxt+vxt_tmp   
;     endelse
;     
;
;    endfor
;    bzt=reform(bzt,6,4)
;    pt=reform(pt,6,4)
;    vxt=reform(vxt,6,4)
;    
;    data_divided=create_struct('t1_omni',t1_omni,'t2_omni',t2_omni,'t3_omni',t3_omni,'t4_omni',t4_omni,'Bz1',Bz1,'Bz2',Bz2,'Bz3',Bz3,'Bz4',Bz4,'bzt',bzt,'pt',pt,'vxt',vxt)
;    
;    
;    print,n_elements(data_divided.bz1)+n_elements(data_divided.bz2)+n_elements(data_divided.bz3)+n_elements(data_divided.bz4)
;    print,n_elements(bz_imf[where(finite(bz_imf))])
;    
;
;    
;     savetime_omni=(systime(1)-start)/60.0
;    save,savetime_omni,data_divided,time_omni,Vx,Vy,Vz,Bz_imf,p,SYM_H,AE_index,filename='OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav'

; _________________c3fgm_____________________________
;  for j=0,8 do begin
;    filename=filename1[j]
;    loadcdf,filename,'time_tags__C3_CP_FGM_SPIN',time
;    loadcdf,filename,'B_vec_xyz_gse__C3_CP_FGM_SPIN',B_gse
;    loadcdf,filename,'sc_pos_xyz_gse__C3_CP_FGM_SPIN',position
;
;    
;
;    row=n_elements(time)
;    B_gsm=dblarr(3,row)
;    pos_gsm=dblarr(3,row)
;
;    print,j
;    
;    for i=0L,row-1L do begin
;      CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
;      doy=julday(mo,dy,yr)-julday(01,01,yr)+1
;
;      geopack_recalc,yr,doy,hr,mn,sc
;      geopack_conv_coord,B_gse[i,0],B_gse[i,1],B_gse[i,2],Bx_gsm,By_gsm,Bz_gsm,/from_gse,/to_gsm
;      geopack_conv_coord,position[i,0],position[i,1],position[i,2],x_gsm,y_gsm,z_gsm,/from_gse,/to_gsm
;      B_gsm[0,i]=Bx_gsm
;      B_gsm[1,i]=By_gsm
;      B_gsm[2,i]=Bz_gsm
;      pos_gsm[0,i]=x_gsm 
;      pos_gsm[1,i]=y_gsm
;      pos_gsm[2,i]=z_gsm
;    endfor
;
;    if (j eq 0 ) then begin
;      time_c3fgm=time
;      Bx=reform(B_gsm[0,*])
;      By=reform(B_gsm[1,*])
;      Bz=reform(B_gsm[2,*])
;      x_pos=reform(pos_gsm[0,*])
;      y_pos=reform(pos_gsm[1,*])
;      z_pos=reform(pos_gsm[2,*])
;    endif else begin
;
;      time_c3fgm=[time_c3fgm,time]
;      Bx=[Bx,reform(B_gsm[0,*])]
;      By=[By,reform(B_gsm[1,*])]
;      Bz=[Bz,reform(B_gsm[2,*])]
;      x_pos=[x_pos,reform(pos_gsm[0,*])]
;      y_pos=[y_pos,reform(pos_gsm[1,*])]
;      z_pos=[z_pos,reform(pos_gsm[2,*])]
;
;    endelse
;
;  endfor 
;
;  x_pos=x_pos/Re
;  y_pos=y_pos/Re
;  z_pos=z_pos/Re
;
;  index=identify_plasma_sheet(x_pos,y_pos,z_pos,2); form=1,all the aera; form=2, -0.5Re<z<0.5Re
;  print,size(index)
;  time_c3fgm=time_c3fgm[index]
;  x_pos=x_pos[index]
;  y_pos=y_pos[index]
;  z_pos=z_pos[index]
;  Bx=Bx[index]
;  By=By[index]
;  Bz=Bz[index]
;;  print,size(bx)
;;  print,bx 
;;  print,size(x_pos)
;;  
;;  for i=0,20 do begin
;;  CDF_EPOCH, time_c3fgm[i], yr, mo, dy, hr, mn, sc, milli, /BREAK
;;  print,yr,mo,dy,hr,mn,sc,milli,format='(a,/)'
;;  endfor
;;  
;
;  savetime_c3fgm=(systime(1)-start)/60.0
;  print,(systime(1)-start)/60.0
;  save,savetime_c3fgm,time_C3FGM,Bx,By,Bz,x_pos,y_pos,z_pos,filename='C3_FGM_2001_2009_Bxyz_Positionxyz_-0.5_Z_0.5.sav'

;; _________________c3cis______________________________
;  
;     
;    a=2001
;    for j=2001,3236  do begin
;      ;3236
;      filename=filename2[j]
;      id=cdf_open(filename) 
;      cdf_control,id,variable='time_tags__C3_CP_CIS-HIA_ONBOARD_MOMENTS',get_var_info=variable
;      if (variable.maxrec le 1) then a=a+1
;      if (variable.maxrec le 1) then continue
;  
;      loadcdf,filename,'time_tags__C3_CP_CIS-HIA_ONBOARD_MOMENTS',time
;      loadcdf,filename,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',density_tmp
;      loadcdf,filename,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',velocity_gse
;      loadcdf,filename,'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',temperature_tmp
;      loadcdf,filename,'pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',pressure_tmp
;      
;      factor_to_kev=1.0e6/(1000.0*11600)
;      temperature_tmp=temperature_tmp*factor_to_kev
;      row=n_elements(time)
;      velocity_gsm=dblarr(3,row)
; 
;;      for i=0,row-1L do begin
;;        if(abs(density_tmp[i]) gt 1.0e2)  then density_tmp[i]='nan'
;;        if(abs(velocity_gse[i,0]) gt 1.5e3)  then velocity_gse[i,0]='nan'
;;        if(abs(velocity_gse[i,1]) gt 1.5e3)  then velocity_gse[i,1]='nan'
;;        if(abs(velocity_gse[i,2]) gt 1.5e3)  then velocity_gse[i,2]='nan'
;;        if(abs(temperature_tmp[i]) gt 1.0e5)  then temperature_tmp[i]='nan'
;;        if(abs(pressure_tmp[i]) gt 1.0e5)  then pressure_tmp[i]='nan'
;;      endfor
;  
;      for i=0,row-1L do begin
;        if(abs(density_tmp[i]) eq 1.0e31)  then density_tmp[i]='nan'
;        if(abs(velocity_gse[i,0]) gt 5.0e7)  then velocity_gse[i,0]='nan';
;        if(abs(velocity_gse[i,1]) eq 1.0e7)  then velocity_gse[i,1]='nan'
;        if(abs(velocity_gse[i,2]) eq 2.0e7)  then velocity_gse[i,2]='nan'
;        if(abs(temperature_tmp[i]) gt 1.0e10)  then temperature_tmp[i]='nan'; a bad point at 1.5e15
;        if(abs(pressure_tmp[i]) gt  1.0e7)  then pressure_tmp[i]='nan'  ;a bad point at 9.0e9
;      endfor
;      
;      print,j
;  
;      for i=0L,row-1L do begin
;        CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
;        doy=julday(mo,dy,yr)-julday(01,01,yr)+1
;  
;        geopack_recalc,yr,doy,hr,mn,sc
;        geopack_conv_coord,velocity_gse[i,0],velocity_gse[i,1],velocity_gse[i,2],velocity_xgsm,velocity_ygsm,velocity_zgsm,/from_gse,/to_gsm
;        velocity_gsm[0,i]=velocity_xgsm
;        velocity_gsm[1,i]=velocity_ygsm
;        velocity_gsm[2,i]=velocity_zgsm
;  
;      endfor
;  
;      CATCH, errorStatus
;      IF (errorStatus NE 0) THEN BEGIN
;        CATCH, /CANCEL  
;        ;controlling output error messages
;        PRINT, 'read files errors', !ERROR_STATE.MSG
;        ;release error files
;        
;        ;skip this circle
;        CONTINUE
;      ENDIF
;    
;      if (j eq a ) then begin
;        time_c3cis1=time
;        density1=density_tmp
;        temperature1=temperature_tmp
;        pressure1=pressure_tmp
;        vbx1=reform(velocity_gsm[0,*])
;        vby1=reform(velocity_gsm[1,*])
;        vbz1=reform(velocity_gsm[2,*])
;   
;      endif else begin
;        time_c3cis1=[time_c3cis1,time]
;        density1=[density1,density_tmp]
;        temperature1=[temperature1,temperature_tmp]
;        pressure1=[pressure1,pressure_tmp]
;        vbx1=[vbx1,reform(velocity_gsm[0,*])]
;        vby1=[vby1,reform(velocity_gsm[1,*])]
;        vbz1=[vbz1,reform(velocity_gsm[2,*])]
;      endelse
;   
;    endfor
;    
;    restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_T_part1.sav',root_dir='C:\__Data\Datasave\2001_2009_median')
;    time_c3cis=[time_c3cis,time_c3cis1]
;    density=[density,density1]
;    temperature=[temperature,temperature1]
;    pressure=[pressure,pressure1]
;    vbx=[vbx,vbx1]
;    vby=[vby,vby1]
;    vbz=[vbz,vbz1]
;    
;    savetime_c3cis=savetime_c3cis+(systime(1)-start)/60.0 
;    
;    save,savetime_c3cis,time_c3cis,density,temperature,pressure,vbx,vby,vbz,filename='C3_CIS_2001_2009_n_vbxyz_p_T.sav'
;    print,savetime_c3cis
;      
      
      
     restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave\2001_2009_median')
     restore,filepath('time_need_omni_to_c3fgm_2001_2009.sav',root_dir='C:\__Data\Datasave\2001_2009_median')
     restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave\2001_2009_median')
     restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_T.sav',root_dir='C:\__Data\Datasave\2001_2009_median')
     
     time_c3cis=(time_c3cis-time_omni[0])/60000.0
     time_c3fgm=(time_c3fgm-time_omni[0])/60000.0
     
     time_fgm_need1=time_c3fgm[T_OMNI_TO_FGM1]
     time_fgm_need2=time_c3fgm[T_OMNI_TO_FGM2]
     time_fgm_need3=time_c3fgm[T_OMNI_TO_FGM3]
     time_fgm_need4=time_c3fgm[T_OMNI_TO_FGM4]
     
     print,'time11'
        
     t_fgm_to_cis1=neighbor_time(time_fgm_need1,time_c3cis)   
     print,(systime(1)-start)/60.0,'step11'
     time_cis_need1=time_c3cis[t_fgm_to_cis1]
     t_cis_to_fgm1=neighbor_time(time_cis_need1,time_fgm_need1)
     print,(systime(1)-start)/60.0,'step12'
     index1=identify_plasma_beta((bx[t_omni_to_fgm1])[t_cis_to_fgm1],(by[t_omni_to_fgm1])[t_cis_to_fgm1],(bz[t_omni_to_fgm1])[t_cis_to_fgm1],pressure[t_fgm_to_cis1])
     print,(systime(1)-start)/60.0,'step1'   
     
     t_fgm_to_cis2=neighbor_time(time_fgm_need2,time_c3cis)
     print,'step21',(systime(1)-start)/60.0
     time_cis_need2=time_c3cis[t_fgm_to_cis2]
     t_cis_to_fgm2=neighbor_time(time_cis_need2,time_fgm_need2)
     print,'step22',(systime(1)-start)/60.0
     index2=identify_plasma_beta((bx[t_omni_to_fgm2])[t_cis_to_fgm2],(by[t_omni_to_fgm2])[t_cis_to_fgm2],(bz[t_omni_to_fgm2])[t_cis_to_fgm2],pressure[t_fgm_to_cis2])
     print,(systime(1)-start)/60.0,'step2'   
       
     t_fgm_to_cis3=neighbor_time(time_fgm_need3,time_c3cis)
     time_cis_need3=time_c3cis[t_fgm_to_cis3]  
     t_cis_to_fgm3=neighbor_time(time_cis_need3,time_fgm_need3)
     index3=identify_plasma_beta((bx[t_omni_to_fgm3])[t_cis_to_fgm3],(by[t_omni_to_fgm3])[t_cis_to_fgm3],(bz[t_omni_to_fgm3])[t_cis_to_fgm3],pressure[t_fgm_to_cis3])
     print,(systime(1)-start)/60.0,'step3'

     t_fgm_to_cis4=neighbor_time(time_fgm_need4,time_c3cis)
     time_cis_need4=time_c3cis[t_fgm_to_cis4]
     t_cis_to_fgm4=neighbor_time(time_cis_need4,time_fgm_need4)
     index4=identify_plasma_beta((bx[t_omni_to_fgm4])[t_cis_to_fgm4],(by[t_omni_to_fgm4])[t_cis_to_fgm4],(bz[t_omni_to_fgm4])[t_cis_to_fgm4],pressure[t_fgm_to_cis4])
     print,(systime(1)-start)/60.0,'step4'   


    
     t_omni_to_fgm=create_struct('t_omni_to_fgm1',t_omni_to_fgm1,'t_omni_to_fgm2',t_omni_to_fgm2,'t_omni_to_fgm3',t_omni_to_fgm3,'t_omni_to_fgm4',t_omni_to_fgm4)
     t_fgm_to_cis=create_struct('t_fgm_to_cis1',t_fgm_to_cis1,'t_fgm_to_cis2',t_fgm_to_cis2,'t_fgm_to_cis3',t_fgm_to_cis3,'t_fgm_to_cis4',t_fgm_to_cis4)
     t_cis_to_fgm=create_struct('t_cis_to_fgm1',t_cis_to_fgm1,'t_cis_to_fgm2',t_cis_to_fgm2,'t_cis_to_fgm3',t_cis_to_fgm3,'t_cis_to_fgm4',t_cis_to_fgm4)
     tcis_need=create_struct('index1',index1,'index2',index2,'index3',index3,'index4',index4)
     
   ;  print,index1
    ; print,size(index1[where(index1 ne -1)])
    ; t_index1=t_index[where(t_index ne -1)]
     ; and finite(density) and finite(temperature) and finite(pressure) and finite(vbx) and finite(vby) and finite(vbz))]
     ;print,t_index1
  ;  t_index=neighbor_time(time_c3fgm,time_c3cis,2000.0)
  ;  t_index1=where((t_index ne -1) and (density ne 'Nan') and (temperature ne 'Nan') $
  ;  and (pressure ne 'nan') and (vbx ne 'nan') and (vby ne 'nan') and(vbz ne 'nan'))
 
    
    time_c3cis1=(time_c3cis[t_fgm_to_cis1])[index1]
    time_c3cis2=(time_c3cis[t_fgm_to_cis2])[index2]
    time_c3cis3=(time_c3cis[t_fgm_to_cis3])[index3]
    time_c3cis4=(time_c3cis[t_fgm_to_cis4])[index4]
    time_c3cis=create_struct('time_c3cis',time_c3cis,'time_c3cis1',time_c3cis1,'time_c3cis2',time_c3cis2,'time_c3cis3',time_c3cis3,'time_c3cis4',time_c3cis4)
    
    density1=(density[t_fgm_to_cis1])[index1]
    density2=(density[t_fgm_to_cis2])[index2] ; one bad point at n2 9.0e4
    density3=(density[t_fgm_to_cis3])[index3]
    density4=(density[t_fgm_to_cis4])[index4]
   
    density2[where(density2 gt 4.0e4)]='Nan'
    
    density=create_struct('density',density,'density1',density1,'density2',density2,'density3',density3,'density4',density4)
    
    temperature1=(temperature[t_fgm_to_cis1])[index1]
    temperature2=(temperature[t_fgm_to_cis2])[index2]
    temperature3=(temperature[t_fgm_to_cis3])[index3] 
    temperature4=(temperature[t_fgm_to_cis4])[index4]
    temperature=create_struct('temperature',temperature,'temperature1',temperature1,'temperature2',temperature2,'temperature3',temperature3,'temperature4',temperature4)
    
    pressure1=(pressure[t_fgm_to_cis1])[index1]
    pressure2=(pressure[t_fgm_to_cis2])[index2]  ; one bad point at p2 200
    pressure3=(pressure[t_fgm_to_cis3])[index3]
    pressure4=(pressure[t_fgm_to_cis4])[index4]
    
    pressure2[where(pressure2 gt 150)]='nan'
    pressure=create_struct('pressure',pressure,'pressure1',pressure1,'pressure2',pressure2,'pressure3',pressure3,'pressure4',pressure4)
  
    vbx1=(vbx[t_fgm_to_cis1])[index1]
    vbx2=(vbx[t_fgm_to_cis2])[index2] ; bad point at 3.0e8 and -5.5e8
    vbx3=(vbx[t_fgm_to_cis3])[index3]
    vbx4=(vbx[t_fgm_to_cis4])[index4]
    
    vbx2[where(abs(vbx2) gt 2000)]='Nan'
    vbx=create_struct('vbx',vbx,'vbx1',vbx1,'vbx2',vbx2,'vbx3',vbx3,'vbx4',vbx4)
   
    vby1=(vby[t_fgm_to_cis1])[index1]
    vby2=(vby[t_fgm_to_cis2])[index2]; bad point at 5.0e8
    vby3=(vby[t_fgm_to_cis3])[index3]
    vby4=(vby[t_fgm_to_cis4])[index4]
    vby2[where(abs(vby2) gt 2000)]='Nan'
    vby=create_struct('vby',vby,'vby1',vby1,'vby2',vby2,'vby3',vby3,'vby4',vby4)
    
    vbz1=(vbz[t_fgm_to_cis1])[index1]
    vbz2=(vbz[t_fgm_to_cis2])[index2]
    vbz3=(vbz[t_fgm_to_cis3])[index3]
    vbz4=(vbz[t_fgm_to_cis4])[index4]
    vbz2[where(abs(vbz2) gt 2000)]='Nan'
    vbz=create_struct('vbz',vbz,'vbz1',vbz1,'vbz2',vbz2,'vbz3',vbz3,'vbz4',vbz4)
  
    savetime_c3cis=(systime(1)-start)/60.0
  
    save,savetime_c3cis,time_c3fgm,time_c3cis,t_omni_to_fgm,t_fgm_to_cis,t_cis_to_fgm,tcis_need,density,temperature,pressure,vbx,vby,vbz,filename='C3_CIS_2001_2009_n_vbxyz_p_T_need.sav'
    print,savetime_c3cis
    

end