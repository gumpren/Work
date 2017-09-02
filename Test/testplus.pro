pro testplus
 
;  restore,'C:\__Data\Datasave\2001_2009_median_new_3\raw_data_2001_2009_gap1.000Re_list_median3.sav'
;  b_gsm2=b_gsm
;  density2=density
;  pos_gsm2=pos_gsm
;  pressure2=pressure
;  temperature2=temperature
;  t_c3cis2=t_c3cis
;  velocity2=velocity_gsm
;  h_Re2=h_re
;  k_re2=k_re
;  h_k_re2=h_k_re
;  
;  aa=indgen(6)
;  b=list(aa,/ex)
;  n=list(aa,/ex)
;  t=list(aa,/ex)
;  p=list(aa,/ex)
;  pos=list(aa,/ex)
;  vv=list(aa,/ex)
;  h=list(aa,/ex)
;  k=list(aa,/ex)
;  hk=list(aa,/ex)
;  
;  restore,'C:\__Data\Datasave\2001_2009_median_new_3\raw_data_2001_2009_gap1.000Re_list_median.sav'
;  
;  for i=0,5 do begin
;    b[i]=b_gsm2[i]-b_gsm[i]
;    n[i]=density2[i]-density[i]
;    t[i]=temperature2[i]-temperature[i]
;    p[i]=pressure2[i]-pressure[i]
;    pos[i]=pos_gsm2[i]-pos_gsm[i]
;    vv[i]=velocity2[i]-velocity_gsm[i]
;    h[i]=h_Re2[i]-h_re[i]
;    k[i]=k_re2[i]-k_re[i]
;    hk[i]=h_k_re2[i]-h_k_re[i]
;  endfor
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_3\event_data_2001_2009_gap1.000Re_list_mean.sav'
  hx=event_hx
  kx=event_kx
  hkx=event_h_k_x

  aa=indgen(6)
  h=list(aa,/ex)
  k=list(aa,/ex)
  hk=list(aa,/ex)

  restore,'C:\__Data\Datasave\2001_2009_median_new_3\event_data_2001_2009_gap1.000Re_list_mean3.sav'
  
  for i=0,5 do begin
    h[i]=hx[i]-event_hx[i]
    k[i]=kx[i]-event_kx[i]
    hk[i]=hkx[i]-event_h_k_x[i]
  endfor
  
  
  
  stop


  
  


end