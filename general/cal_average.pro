function cal_average,dat,normal_average=normal_average,subsection_average=subsection_average,fix_average=fix_average
  
;  Re=6371.0
;  reverse_gap=5.0/5.0
;  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
;  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
;  root_dir='C:\__Data\Datasave\2001_2009_5minute_per_point\'
;  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_5minute_per_point\'
;  title_char='line_hx_lasttime_5minute_per_point_0_margin_dawnflank';
;
;  restore,filename=root_dir+'raw_data'+save_str+'_list_5minute_per_point_0_margin_full_dawnflank.sav'
; 
;   
;  dat=(H_Re[0])[*,0]

  
  
  dat1=dat[sort(dat)]   ;sorted by the range from min to max
  nums=n_elements(dat)    
  his=histogram(dat1,binsize=0.02,locations=locat)
  
  ; p1  normal average
  dat_average1=average(dat1,/nan)
  
  ; p2  subsection average
  datv=0
  for j=0, n_elements(his)-1 do begin
     datv=datv+his[j]*locat[j] 
  endfor
  dat_average2=datv/nums  
  
 
  ; p3  average except extremly high data records
  idmaxhis=where(his eq max(his))
  
  
  if n_elements(idmaxhis) ge 2 then begin
    
    maxdat=total(his[idmaxhis[0]:idmaxhis[n_elements(idmaxhis)-1]])
   
    for i=1,idmaxhis[n_elements(idmaxhis)-1]-1 do begin
      if idmaxhis[0]-i ge 0 then begin  
        former_dat=his[idmaxhis[0]-i]       
      endif else begin
        former_dat=his[0]                       ;in case of former_Dat out of range
      endelse                   
      
      if (idmaxhis[n_elements(idmaxhis)-1]+i le n_elements(his)-1) then begin
        latter_dat=his[idmaxhis[n_elements(idmaxhis)-1]+i]
      endif else begin
        latter_dat=his[n_elements(his)-1]       ;in case of latter_Dat out of range
      endelse
        
      maxdat=maxdat+former_dat+latter_dat
      if (maxdat ge 0.99*nums ) then break
    endfor    
        
  endif else begin
    
    
    
    
    maxdat=his[idmaxhis]
   
    for i=1,idmaxhis[0]-1 do begin
      if idmaxhis-i ge 0 then begin
        former_dat=his[idmaxhis-i]
      endif else begin
        former_dat=his[0]               ;in case of former_Dat out of range
      endelse

      if (idmaxhis+i le n_elements(his)-1) then begin
        latter_dat=his[idmaxhis+i]
      endif else begin
        latter_dat=his[n_elements(his)-1]               ;in case of latter_Dat out of range
      endelse
      maxdat=maxdat+former_dat+latter_dat
      if (maxdat ge 0.99*nums) then break
    endfor
    
  endelse
  
;   cgdisplay
;   plot,his
;   window,2,
;   plot,locat

  dat_range=[locat[idmaxhis-i],locat[idmaxhis+i]]
  dat_index=where(dat1 ge dat_range[0] and dat1 le dat_range[1])
  dat_average3=average(dat1[dat_index])
  
  
  if keyword_Set(normal_average) then return,dat_average1
  if keyword_Set(subsection_average) then return,dat_average2
  if keyword_Set(fix_average) then return,dat_average3


end