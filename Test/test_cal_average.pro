pro test_cal_average

  restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\raw_data_2001_2009_gap1.000Re_list_10minute_per_point_duskflank.sav'

  dat=(H_re[10])[*,0]
  
  ;1 
  av1=average(dat)
  
  av2=wmean(dat,0.02)
  ;2
  his=histogram(dat,binsize=0.02,locations=locat)
  idmaxhis=where(his eq max(his))
  
  former_num=idmaxhis
  later_num=n_elements(his)-1-idmaxhis
  if(former_num ge later_num) then num=later_num
  if(former_num lt later_num) then num=former_num
  
  for i=0,num-1 do begin
     select_num=total(his[idmaxhis-i:idmaxhis+i])
     
  endfor
  
  


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









  
  dat1=dat[sort(dat)]   ;sorted by the range from min to max
  nums=n_elements(dat)
  his=histogram(dat,binsize=0.02,locations=locat)
  datv=0
  for j=0, n_elements(his)-1 do begin
    datv=datv+his[j]*locat[j]
  endfor
  dat_average2=datv/nums

  stop
end