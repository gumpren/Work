pro ren_statistic_analysis

condition0=[-100,0]
condition1=[0,9000]
cdf_file=file_search('H:\rendata\C3*.cdf')
dataC3=loadcdf_all_variable(cdf_file,g_attributes=g_attributes,atts=atts,var_structure=var_structure,_extra=extra_)
loadcdf,cdf_file,'time_tags__C3_CP_FGM_SPIN',epoch
time_tags=dataC3.TIME_TAGS__C3_CP_FGM_SPIN
SC_pos=dataC3.SC_POS_XYZ_GSE__C3_CP_FGM_SPIN/6400.0
x=floor(-SC_pos[*,0]/2.5)
y=floor(SC_pos[*,1]/2.5+10.0)
;store_data,'pos_gse',data={x:}
;date=strcompress(string(yr)+string(mo,format='(i02)'),/remove_all)
nopoints=n_elements(time_tags)
timeC3=fltarr(nopoints)
for ii=0,nopoints-1 do begin
  cdf_epoch,epoch[ii],yr,mo,dy,hr,min,sec,milli,/breakdown_epoch
  doy=date_to_doy(mo,dy,yr)
  timeC3[ii]=(doy-1.0)*24.0*3600.0+hr*3600.0+min*60.0+sec+milli/1000.0  
endfor

numbers=fltarr(12,20,4)
omni_file=file_search('H:\rendata\omni*.cdf')
nofiles=n_elements(omni_file)
for ii=0,nofiles-1 do begin
  data=loadcdf_all_variable(omni_file[ii],g_attributes=g_attributes,atts=atts,var_structure=var_structure,_extra=extra_)
  timeOMNI=(data.day-1.0)*24.0*3600.0+data.epoch
  judge_value=data.BZ_GSM
  judge_satisfy_interval,judge_value,condition0,start_point0,terminal_point0
  duration0=(timeOMNI[terminal_point0]-timeOMNI[start_point0])/3600.0
  t0=where(duration0 ge 0.333)  
  judge_satisfy_interval,judge_value,condition1,start_point1,terminal_point1    
  duration1=(timeOMNI[terminal_point1]-timeOMNI[start_point1])/3600.0
  t1=where(duration1 ge 0.333)
  for xii=0,11 do begin
    for yii=0,19 do begin
      ;;; smaller than zero
      for jj=0,n_elements(t0)-1 do begin
        tt0=where(timeC3 ge timeOMNI[start_point0[t0[jj]]] and timeC3 le timeOMNI[terminal_point0[t0[jj]]-1] and duration0[t0[jj]] lt 1.0)                  
        tt00=where(x[tt0] eq xii and y[tt0] eq yii)
        numbers[xii,yii,0]=numbers[xii,yii,0]+n_elements(tt00)*(tt00[0] ne -1)
        tt1=where(timeC3 ge timeOMNI[start_point0[t0[jj]]] and timeC3 le timeOMNI[terminal_point0[t0[jj]]-1] and duration0[t0[jj]] ge 1.0)
        tt11=where(x[tt1] eq xii and y[tt1] eq yii)
        numbers[xii,yii,1]=numbers[xii,yii,1]+n_elements(tt11)*(tt11[0] ne -1)        
      endfor
      ;;; larger than zero
      for jj=0,n_elements(t1)-1 do begin
        tt2=where(timeC3 ge timeOMNI[start_point1[t1[jj]]] and timeC3 le timeOMNI[terminal_point1[t1[jj]]-1] and duration1[t1[jj]] lt 1.0)
        tt22=where(x[tt2] eq xii and y[tt2] eq yii)
        numbers[xii,yii,2]=numbers[xii,yii,2]+n_elements(tt22)*(tt22[0] ne -1)
        tt3=where(timeC3 ge timeOMNI[start_point1[t1[jj]]] and timeC3 le timeOMNI[terminal_point1[t1[jj]]-1] and duration1[t1[jj]] ge 1.0)
        tt33=where(x[tt3] eq xii and y[tt3] eq yii)
        numbers[xii,yii,3]=numbers[xii,yii,3]+n_elements(tt33)*(tt33[0] ne -1)
      endfor
    endfor
  endfor    
endfor
output_file='H:\rendata\results.cdf'
results=create_struct('time',time_double('2001-01-01/00:00:00'),'numbers',numbers)
makecdf,results,filename=output_file,status=status,/overwrite

end

