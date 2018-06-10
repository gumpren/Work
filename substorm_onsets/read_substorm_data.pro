pro read_substorm_data
  
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  filename=root_Dir+'N.stgaard-2011-sup-2000-2005.txt'
  openr,lun,filepath('N.stgaard-2011-sup-2000-2005.txt',root_dir=root_Dir),/get_lun
  lines=file_lines(filename)
  data_all=strarr(lines)
  readf,lun,data_all
  free_lun,lun
  
  time=dblarr(lines)
  mlt=dblarr(lines)
  maglat=dblarr(lines)
  IMF_clang=dblarr(lines)
  IMF_By=dblarr(lines)
  IMF_Bz=dblarr(lines)
  SPCR=strarr(lines)
  
  for i=0,lines-1 do begin
    strs=strsplit(data_all[i],' ',/EXTRACT)
    str1=strsplit(strs[0],'_',/EXTRACT)
    instru=str1[0]
    time[i]=str1[1]+'-'+strmid(str1[2],0,2)+'-'+strmid(str1[2],2,2)+'/'+str1[3]
    mlt[i]=double(strs[1])
    maglat[i]=double(strs[2])
    IMF_clang[i]=double(strs[3])
    IMF_By[i]=double(strs[4])
    IMF_Bz[i]=double(strs[5])
    SPCR[i]=strs[6]
  endfor
  
  
  
  store_Data,'onset_bz',data={x:t,y:density}


  stop



end