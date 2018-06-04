function smooth_hkx_line_data,median_arr,nan_12=nan_12

    median_dawn_N=median_arr[0,0]
    median_dawn_S=median_arr[0,1]
    median_dusk_N=median_arr[1,0]
    median_dusk_S=median_arr[1,1]
    
    ;dawn N
    varii=median_arr[0,0]
    for i=3,13 do begin     ; i begins with 3 not with 1 because we want keep the true value in the IMF turnings  
       median_dawn_N[i]=(varii[i-1]+varii[i]+varii[i+1])/3.0
    endfor
median_dawn_N[14]=(varii[13]+varii[14])/2.0
   
    ;dawn S
    varii=median_arr[0,1]
    for i=3,13 do begin
      median_dawn_S[i]=(varii[i-1]+varii[i]+varii[i+1])/3.0
    endfor
median_dawn_S[14]=(varii[13]+varii[14])/2.0
    
    ;dusk N
    varii=median_arr[1,0]
    for i=3,13 do begin
      median_dusk_N[i]=(varii[i-1]+varii[i]+varii[i+1])/3.0
    endfor
median_dusk_N[14]=(varii[13]+varii[14])/2.0
    
    ;dusk S
    varii=median_arr[1,1]
    for i=3,13 do begin
      median_dusk_S[i]=(varii[i-1]+varii[i]+varii[i+1])/3.0
    endfor
median_dusk_S[14]=(varii[13]+varii[14])/2.0
   
   if keyword_set(nan_12) then median_dusk_S[11]=!values.f_nan
    
    
    median_smooth_arr=hash()
    median_smooth_arr[0,0]=median_dawn_N   &    median_smooth_arr[0,1]=median_dawn_S
    median_smooth_arr[1,0]=median_dusk_N   &    median_smooth_arr[1,1]=median_dusk_S
    
    ;save,median_smooth_arr,filename='smooth hx hash arr.sav'
    
    return,median_smooth_arr
 


end