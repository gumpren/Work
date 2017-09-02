 Function divide_Bz,t_omni,Bz_imf,p,Vx
  bzt=fltarr(6,4)
  pt=fltarr(6,4)
  vxt=fltarr(6,4)
  row_=fltarr(4)
;----------Bz>0-----------------------------------------------------------------------------------
  condition0=[0,900]
  judge_satisfy_interval,bz_imf,condition0,start_point,terminal_point,satisfy_number,rrow

  bz_1=fltarr(satisfy_number)-1e31
  bz_2=fltarr(satisfy_number)-1e31
  t1_omni=fltarr(satisfy_number)-1e31
  t2_omni=fltarr(satisfy_number)-1e31
  p_1=fltarr(satisfy_number)-1e31
  p_2=fltarr(satisfy_number)-1e31
  vx_1=fltarr(satisfy_number)-1e31
  vx_2=fltarr(satisfy_number)-1e31

  for i=0,rrow-1 do begin
    if ((terminal_point[i]-start_point[i]) gt 60 ) then begin
      for j1=start_point[i],terminal_point[i]-1  do begin
        Bz_1[row_[0]]=Bz_imf[j1]
        t1_omni[row_[0]]=t_omni[j1]
        p_1[row_[0]]=p[j1]
        vx_1[row_[0]]=Vx[j1]
        row_[0]=row_[0]+1
      endfor
    endif else begin
      if((terminal_point[i]-start_point[i]) gt 10 ) then begin
        for j2=start_point[i],terminal_point[i]-1 do begin
          Bz_2[row_[1]]=Bz_imf[j2]
          t2_omni[row_[1]]=t_omni[j2]
          p_2[row_[1]]=p[j2]
          vx_2[row_[1]]=Vx[j2]
          row_[1]=row_[1]+1
        endfor
      endif
    endelse
  endfor
  
  
  indexz1=where(Bz_1 ne -1e31,/null)
  Bz1=Bz_1[indexz1]
  indexz2=where(Bz_2 ne -1e31,/null)
  Bz2=Bz_2[indexz2]
  indext1=where(t1_omni ne -1e31,/null)
  t1_omni=t1_omni[indext1]
  indext2=where(t2_omni   ne -1e31,/null)
  t2_omni=t2_omni[indext2]
  indexp1=where(p_1 ne -1e31,/null)
  p1=p_1[indexp1]
  indexp2=where(p_2 ne -1e31,/null)
  p2=p_2[indexp2]
  indexv1=where(vx_1 ne -1e31,/null)
  vx1=vx_1[indexv1]
  indexv2=where(vx_2 ne -1e31,/null)
  vx2=vx_2[indexv2]
  
;----------Bz<0-----------------------------------------------------------------------------------

  condition1=[-200,0]
  judge_satisfy_interval,Bz_imf,condition1,start_point,terminal_point,satisfy_number,rrow

  Bz_3=fltarr(satisfy_number)-1e31
  Bz_4=fltarr(satisfy_number)-1e31
  t3_omni=fltarr(satisfy_number)-1e31
  t4_omni=fltarr(satisfy_number)-1e31
  p_3=fltarr(satisfy_number)-1e31
  p_4=fltarr(satisfy_number)-1e31
  vx_3=fltarr(satisfy_number)-1e31
  vx_4=fltarr(satisfy_number)-1e31
  
  for i=0,rrow-1 do begin
    if ((terminal_point[i]-start_point[i]) gt 60 ) then begin
      for j1=start_point[i],terminal_point[i]-1  do begin
        Bz_3[row_[2]]=Bz_imf[j1]
        t3_omni[row_[2]]=t_omni[j1]
        p_3[row_[2]]=p[j1]
        vx_3[row_[2]]=Vx[j1]
        row_[2]=row_[2]+1
      endfor
    endif else begin
      if((terminal_point[i]-start_point[i]) gt 10 ) then begin
        for j2=start_point[i],terminal_point[i]-1 do begin
          Bz_4[row_[3]]=Bz_imf[j2]
          t4_omni[row_[3]]=t_omni[j2]
          p_4[row_[3]]=p[j2]
          vx_4[row_[3]]=Vx[j2]
          row_[3]=row_[3]+1
        endfor
      endif
    endelse
  endfor 
  
  indexz3=where(Bz_3 ne -1e31,/null)
  Bz3=Bz_3[indexz3]
  indexz4=where(Bz_4 ne -1e31,/null)
  Bz4=Bz_4[indexz4]
  indexp3=where(p_3 ne -1e31,/null)
  
  indext3=where(t3_omni ne -1e31,/null)
  t3_omni=t3_omni[indext3]
  indext4=where(t4_omni ne -1e31,/null)
  t4_omni=t4_omni[indext4]
  
  p3=p_3[indexp3]
  indexp4=where(p_4 ne -1e31,/null)
  p4=p_4[indexp4]
  indexv3=where(vx_3 ne -1e31,/null)
  vx3=vx_3[indexv3]
  indexv4=where(vx_4 ne -1e31,/null)
  vx4=vx_4[indexv4]
 
  data=create_struct('Bz1',Bz1,'Bz2',Bz2,'Bz3',Bz3,'Bz4',Bz4)
  data1=create_struct('p1',p1,'p2',p2,'p3',p3,'p4',p4)
  data2=create_struct('vx1',vx1,'vx2',vx2,'vx3',vx3,'vx4',vx4)
 ;----------4 conditions count ----------------------------------------------------------------------------------- 
  
  notag=n_tags(data)
  tagname=tag_names(data)
  for ii=0,notag-1 do begin
      for kk=0,n_elements(data.(ii))-1L do begin
        if (abs(data.(ii)[kk]) gt 0.0 and abs(data.(ii)[kk]) le 2.0)  then bzt[0,ii]++
        if (abs(data.(ii)[kk]) gt 2.0 and abs(data.(ii)[kk]) le 4.0)  then bzt[1,ii]++
        if (abs(data.(ii)[kk]) gt 4.0 and abs(data.(ii)[kk]) le 6.0)  then bzt[2,ii]++
        if (abs(data.(ii)[kk]) gt 6.0 and abs(data.(ii)[kk]) le 8.0)  then bzt[3,ii]++
        if (abs(data.(ii)[kk]) gt 8.0 and abs(data.(ii)[kk]) le 10.0) then bzt[4,ii]++
        if (abs(data.(ii)[kk]) gt 10.0 )  then bzt[5,ii]++
      endfor
  endfor
  
  notag1=n_tags(data1)
  tagname1=tag_names(data1)
  for ii=0,notag1-1 do begin
    for kk=0,n_elements(data1.(ii))-1L do begin
      if (abs(data1.(ii)[kk]) gt 0.0 and abs(data1.(ii)[kk]) le 2.0)  then pt[0,ii]++
      if (abs(data1.(ii)[kk]) gt 2.0 and abs(data1.(ii)[kk]) le 4.0)  then pt[1,ii]++
      if (abs(data1.(ii)[kk]) gt 4.0 and abs(data1.(ii)[kk]) le 6.0)  then pt[2,ii]++
      if (abs(data1.(ii)[kk]) gt 6.0 and abs(data1.(ii)[kk]) le 8.0)  then pt[3,ii]++
      if (abs(data1.(ii)[kk]) gt 8.0 and abs(data1.(ii)[kk]) le 10.0) then pt[4,ii]++
      if (abs(data1.(ii)[kk]) gt 10.0 )  then pt[5,ii]++
    endfor
  endfor
  
  notag2=n_tags(data2)
  tagname2=tag_names(data2)
  for ii=0,notag2-1 do begin
    for kk=0,n_elements(data2.(ii))-1L do begin
      if (abs(data2.(ii)[kk]) gt 200.0 and abs(data2.(ii)[kk]) le 300.0)  then vxt[0,ii]++
      if (abs(data2.(ii)[kk]) gt 300.0 and abs(data2.(ii)[kk]) le 400.0)  then vxt[1,ii]++
      if (abs(data2.(ii)[kk]) gt 400.0 and abs(data2.(ii)[kk]) le 500.0)  then vxt[2,ii]++
      if (abs(data2.(ii)[kk]) gt 500.0 and abs(data2.(ii)[kk]) le 600.0)  then vxt[3,ii]++
      if (abs(data2.(ii)[kk]) gt 600.0 and abs(data2.(ii)[kk]) le 700.0) then vxt[4,ii]++
      if (abs(data2.(ii)[kk]) gt 700.0 )  then vxt[5,ii]++
    endfor
  endfor
  
  data=create_struct('t1_omni',t1_omni,'t2_omni',t2_omni,'t3_omni',t3_omni,'t4_omni',t4_omni,'Bz1',Bz1,'Bz2',Bz2,'Bz3',Bz3,'Bz4',Bz4,'row_',row_,'bzt',bzt,'pt',pt,'vxt',vxt)
  return,data
end

