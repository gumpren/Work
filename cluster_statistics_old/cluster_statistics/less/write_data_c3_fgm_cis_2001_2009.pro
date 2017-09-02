pro save_data_C3_FGM_CIS_2001_2009

  filename1=file_search('D:\__Data\Cluster\CP_FGM_SPIN\*.cdf')
  filename2=file_search('D:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*.cdf')

  
  for j=0,9 do begin
    
;    openw,lun,filepath('C3_FGM_CIS_data_2001.dat',root_dir='D:\__Data\Cluster'),/get_lun,width=500
;    ;'(a4,1x,a5,1x,a3,1x,a4,1x,a6,1x,a6,1x,a4,5x,a2)')
;    printf,lun,'time','Bx','By','Bz','x','y','z',format='( a4,28x,a2,10x,a2,10x,a2,8x,a1,12x,a1,12x,a1)'

   
    
    filename=filename1[j]
    loadcdf,filename,'time_tags__C3_CP_FGM_SPIN',time
    loadcdf,filename,'B_vec_xyz_gse__C3_CP_FGM_SPIN',B_gse
    loadcdf,filename,'sc_pos_xyz_gse__C3_CP_FGM_SPIN',position
        
    row=n_elements(time)  
    hour=dblarr(row)
    minute=dblarr(row)
    second=dblarr(row)
    day=dblarr(row)
    B_gsm=dblarr(3,row)
    B_gsm_sav=dblarr(3,row)
    position_sav=dblarr(3,row)
;-----------geopack-----------------------------------------------------------------------------------------
  
    for i=0L,row-1L do begin
      CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
      day(i)=dy+(hr+mn/60.0+sc/3600.0+milli/3.6e6)/24.0
      hour(i)=hr+mn/60.0+sc/3600.0+milli/3.6e6
      minute(i)=mn+sc/60.0+milli/6.0e4
      second(i)=sc+milli/1.0e3
      doy=julday(mo,dy,yr)-julday(01,01,yr)+1

      geopack_recalc,yr,doy,hr,mn,sc
      geopack_conv_coord,B_gse[i,0],B_gse[i,1],B_gse[i,2],Bx_gsm,By_gsm,Bz_gsm,/from_gse,/to_gsm
      geopack_conv_coord,position[i,0],position[i,1],position[i,2],x_gsm,y_gsm,z_gsm,/from_gse,/to_gsm
      B_gsm[0,i]=Bx_gsm
      B_gsm[1,i]=By_gsm
      B_gsm[2,i]=Bz_gsm

    endfor
       
    if (j eq 0 ) then begin
     time_sav=time
     B_gsm_sav[0,*]=B_gsm[0,*]
     B_gsm_sav[1,*]=B_gsm[1,*]
     B_gsm_sav[2,*]=B_gsm[2,*]  
     position_sav[0,*]=position[0,*]
     position_sav[1,*]=position[1,*]
     position_sav[2,*]=position[2,*]    
    endif
      
    time_sav=[time_sav,time]
    B_gsm_sav[0,*]=[B_gsm_sav[0,*],B_gsm[0,*]]
    B_gsm_sav[1,*]=[B_gsm_sav[1,*],B_gsm[1,*]]
    B_gsm_sav[2,*]=[B_gsm_sav[2,*],B_gsm[2,*]]
    position_sav[0,*]=[position_sav[0,*],position[0,*]]
    position_sav[1,*]=[position_sav[1,*],position[1,*]]
    position_sav[2,*]=[position_sav[2,*],position[2,*]]

    save,time_sav,B_gsm_sav,position_sav,filename='C3_FGM_2001_2010.sav'


  endfor
end