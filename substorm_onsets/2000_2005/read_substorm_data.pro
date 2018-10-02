pro read_substorm_data
  
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  filename=root_Dir+'N.stgaard-2011-sup-2000-2005-modified-timing.txt'
  openr,lun,filepath('N.stgaard-2011-sup-2000-2005-modified-timing.txt',root_dir=root_Dir),/get_lun
  lines=file_lines(filename)
  data_all=strarr(lines)
  readf,lun,data_all
  free_lun,lun
  
  onset_time=dblarr(lines)
  mltime=dblarr(lines)
  maglat=dblarr(lines)
  IMF_clang=dblarr(lines)
  IMF_By=dblarr(lines)
  IMF_Bz=dblarr(lines)
  SPCR=strarr(lines)
  
  for i=0,lines-1 do begin
    strs=strsplit(data_all[i],' ',/EXTRACT)
    str1=strsplit(strs[0],'_',/EXTRACT)
    instru=str1[0]
    onset_time[i]=time_double(str1[1]+'-'+strmid(str1[2],0,2)+'-'+strmid(str1[2],2,2)+'/'+str1[3])
    mltime[i]=double(strs[1])
    maglat[i]=double(strs[2])
    IMF_clang[i]=double(strs[3])
    IMF_By[i]=double(strs[4])
    IMF_Bz[i]=double(strs[5])
    SPCR[i]=strs[6]
  endfor
  

    
  save,onset_time,mltime,maglat,filename=root_Dir+'substorm_onsets_location_modified_timing.sav'
  
  store_Data,'onset_mlt',data={x:onset_time,y:mltime}
  store_Data,'onset_maglat',data={x:onset_time,y:maglat}
  store_Data,'IMF_Bz',data={x:onset_time,y:IMF_Bz}
  
  
  restore,'C:\__Data\Datasave\omni_imf_bz.sav'
  store_data,'All_Bz',data={x:time,y:bz_gsm}
  
  tinterpol_mxn,'All_Bz','IMF_Bz',/NEAREST_NEIGHBOR,/IGNORE_NANS
  
  get_data,'All_Bz_interp',time_interp,All_Bz_interp
  
  
  gap1=time_interp-onset_time
  gap2=IMF_Bz-All_Bz_interp
  
  
  
  
  stop

  

end