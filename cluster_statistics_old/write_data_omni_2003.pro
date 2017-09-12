pro write_data_OMNI_2003

  openw,lun,filepath('Bz_data_OMNI_2003.dat',root_dir='D:\__Data\OMNI'),/get_lun,width=500
 ;'(a4,1x,a5,1x,a3,1x,a4,1x,a6,1x,a6,1x,a4,5x,a2)')
  printf,lun,'time','Bz',format='(a4,28x,a2)'
    
  filename0=file_search('D:\__Data\OMNI\*.cdf')
  for j=0,11 do begin
    filename=filename0[j]
    loadcdf,filename,'Epoch',time
    loadcdf,filename,'BZ_GSM',B_z
    loadcdf,filename,'Vx',Vx_gse
    loadcdf,filename,'Vy',Vy_gse
    loadcdf,filename,'Vz',Vz_gse
    loadcdf,filename,'Pressure',p
    
    row=n_elements(time)
    Vx=dblarr(row)
    hour=dblarr(row)
    minute=dblarr(row)
    second=dblarr(row)
    day=dblarr(row)
    V_gsm=dblarr(3,row)
    Bz_data=dblarr(12,8,row)
    help,B_z
;-----------geopack-----------------------------------------------------------------------------------------

    for i=0L,row-1L do begin
      CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
      day(i)=dy+(hr+mn/60.0+sc/3600.0+milli/3.6e6)/24.0
      hour(i)=hr+mn/60.0+sc/3600.0+milli/3.6e6
      minute(i)=mn+sc/60.0+milli/6.0e4
      second(i)=sc+milli/1.0e3
      doy=julday(mo,dy,yr)-julday(01,01,yr)+1

      geopack_recalc,yr,doy,hr,mn,sc
      geopack_conv_coord,Vx_gse[i],Vy_gse[i],Vy_gse[i],Vx_gsm,Vy_gsm,Vz_gsm,/from_gse,/to_gsm
      V_gsm[0,i]=Vx_gsm
      V_gsm[1,i]=Vy_gsm
      V_gsm[2,i]=Vz_gsm
      
      Bz_data[j,0,i]=yr
      Bz_data[j,1,i]=mo[*]
      Bz_data[j,2,i]=dy[*]
      Bz_data[j,3,i]=hr[*]
      Bz_data[j,4,i]=mn[*]
      Bz_data[j,5,i]=sc[*]
      Bz_data[j,6,i]=milli[*]
  endfor
     
      Vx=V_gsm[0,*]
       

    Bz_data[j,7,*]=B_z[*]
   
    
    printf,lun,Bz_data[j,*,*],format='(i4,1x,i2,1x,i2,1x,i2,1x,i2,1x,i2,1x,i3,5x,f7.2)'
 
  endfor
  
  free_lun,lun
  
end