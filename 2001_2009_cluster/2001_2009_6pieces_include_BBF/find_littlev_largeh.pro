;pro find_littlev_largeh
;  
;   root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
;   restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_all_plus.sav'
;   
;   iii=0
;   time_o=t_c3cis_all[iii]
;   n=density_all[iii]
;   t=temperature_all[iii]
;   p=pressure_all[iii]
;   v=velocity_all[iii]
;   pos=pos_gsm_all[iii]
;   b=b_gsm_all[iii]   
;   h_o=h_re[iii]
;   k_o=k_re[iii]
;   hk_o=h_k_re[iii]
;  ; time_intervals=time_intervals(trange=['2001-01-01','2002-01-01'],/MONTHLY_RES)
;   
;   
;   index=where(abs(v[*,0]) le 80.0  and  h_o[*,0] gt 2.0 )
;   
;   t1=time_o[index]
;   separate_satisfy_interval,t1,start_point,terminal_point   ; get time intervals of V>100km/s
;   
;   indextt=where(terminal_point-start_point ne 0)            ;eliminate isolated points
;   start_point=start_point[indextt]
;   terminal_point=terminal_point[indextt]
; 
;   index_start=dblarr(n_elements(start_point))-1.0e10        ;0 (useless until now   2017.04.25)
;   index_end=dblarr(n_elements(start_point))-1.0e10          ;0
;   j=0
;   for i=0,n_elements(start_point)-1 do begin
;      index_s=where(start_point[i] eq t1)
;      index_e=where(terminal_point[i] eq t1)
;      hx_temp=h_o[index_s:index_e,0]
;      tt_temp=t1[index_s:index_e]
;      if max(hx_temp) ge 6.5  then begin                          ; Hx' peak ge 6.5
;        index_start[j]=index_s                                ;0
;        index_end[j]=index_e                                  ;0
;        if index_s ne 0 then begin
;           append_array,hx,hx_temp
;           append_array,tt,tt_temp
;        endif
;        j=j+1
;      endif
;    endfor
;   
;   index_start=index_start[where(index_start ge 0)]
;   index_end=index_end[where(index_end ge 0)]
;   
;   last=index_end-index_start+1
;   indd=where(last gt 7.5)  ;last time gt 30s 
;   index_start=index_start[indd]
;   index_end=index_end[indd]
;   
;   for kk=2,n_elements(index_start)-1 do begin 
;     index_s=index_start[kk]
;     index_e=index_end[kk]
;     
;     time=(time_o[index])[index_s:index_e]
;     density=(n[index])[index_s:index_e]
;     temperature=(t[index])[index_s:index_e]
;     pressure=(p[index])[index_s:index_e]
;     velocity=(v[index(index_s:index_e),*])
;     pos_gsm=(pos[index(index_s:index_e),*])
;     B_gsm=(b[index(index_s:index_e),*])
;     H=(h_o[index(index_s:index_e),*])
;     K=(k_o[index(index_s:index_e),*])
;     H_K=(hk_o[index(index_s:index_e),*])
;
;     output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_6pieces_include_BBF\littlev_largeh_events\'
;     save_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\littlev_largeh_events'
;     title_char=time_string(time[0],format=2)+'_'+time_string(time[n_elements(time)-1],format=2)+'__'+strcompress(kk)+'__('+strcompress(iii)+')'
;     ; title_char=time_string(time[0],)
;
;     store_Data,'density',data={x:time,y:density}
;     store_Data,'temperature',data={x:time,y:temperature}
;     store_Data,'pressure',data={x:time,y:pressure}
;     store_Data,'velocity',data={x:time,y:[[velocity[*,0]],[velocity[*,1]],[velocity[*,2]]]}
;     store_Data,'pos_gsm',data={x:time,y:[[pos_gsm[*,0]],[pos_gsm[*,1]],[pos_gsm[*,2]]]}
;     store_Data,'B_gsm',data={x:time,y:[[B_gsm[*,0]],[B_gsm[*,1]],[B_gsm[*,2]]]}
;     store_Data,'H',data={x:time,y:[[H[*,0]],[H[*,1]],[H[*,2]]]}
;     store_Data,'K',data={x:time,y:[[K[*,0]],[K[*,1]],[K[*,2]]]}
;
;    ; timespan,time_string(time[0]),time[n_elements(time)-1]-time[0],/seconds
;     init_crib_colors
;
;     popen,output_dir+title_char,xsize=4,ysize=5.0,font=0,units='inches'
;     tplot_options, 'font', 0
;     tplot_options, 'charsize', 0.7
;     tplot_options, 'xticklen', 0.05
;     tplot_options, 'yticklen', 0.015
;     tplot_options, 'zticklen', 0.3
;     tplot_options, 'xgap', 0.3
;     tplot_options, 'ygap', 0.8
;     tplot_options, 'xmargin', [14,10]
;     tplot_options, 'ymargin', [1,1]
;     ;tplot_options, 'tickinterval', 60.*10.
;     tplot_options,'y_no_interp',1
;     time_stamp,/off
;     options,'*',colors=[0,4,6]
;  ;   tlimit, time[0], time[n_elements(time)-1]-time[0], /seconds
;    
;     tstart=time[0]
;     tend=time[n_elements(time)-1]
;     plot_trange=[tstart,tend]
;       
;     options, 'density',ytitle='n(cm^-3)',labflag=-1
;     options, 'temperature',ytitle='T(kev)',labflag=-1
;     options, 'pressure',ytitle='p(nPa)',labflag=-1
;     options, 'velocity',ytitle='V(km/s)',labels=['Vx','Vy','Vz'],labflag=-1
;     options, 'pos_gsm',ytitle='position',labels=['X','Y','Z'],labflag=-1
;     options, 'B_gsm',ytitle='B(nT)',labels=['Bx','By','Bz'],labflag=-1
;     options, 'H',ytitle='H',labels=['Hx','Hy','Hz'],labflag=-1  ;'H(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;     options, 'K',ytitle='K',labels=['Kx','Ky','Kz'],labflag=-1
;     tplot,['density','temperature','pressure','velocity','pos_gsm','B_gsm','H','K'],trange=plot_trange
;     pclose
;     
;     
;     ;del_Data,'*'
;     print,title_char
;     print,kk
;     help    
;   endfor
; 
;   
;   stop
;
;end


pro find_littlev_largeh
  

  root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
  restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_all_plus.sav'
  
  iii=5
  time=t_c3cis_all[iii]
  n=density_all[iii]
  t=temperature_all[iii]
  p=pressure_all[iii]
  v=velocity_all[iii]
  pos=pos_gsm_all[iii]
  b=b_gsm_all[iii]
  h=h_re[iii]
  k=k_re[iii]
  hk=h_k_re[iii]
 ; time_intervals=time_intervals(trange=['2001-01-01','2002-01-01'],/MONTHLY_RES)
  
  idx=sort(time)   ;   make array range  in time series
  time=time[idx]
  n=n[idx]
  t=t[idx]
  p=p[idx]
  v=v[idx,*]
  pos=pos[idx,*]
  b=b[idx,*]
  h=h[idx,*]
  k=k[idx,*]
  hk=hk[idx,*]
  
  store_Data,'density',data={x:time,y:n}
  store_Data,'temperature',data={x:time,y:t}
  store_Data,'pressure',data={x:time,y:p}
  store_Data,'velocity',data={x:time,y:[[v[*,0]],[v[*,1]],[v[*,2]]]}
  store_Data,'pos_gsm',data={x:time,y:[[pos[*,0]],[pos[*,1]],[pos[*,2]]]}
  store_Data,'B_gsm',data={x:time,y:[[b[*,0]],[b[*,1]],[b[*,2]]]}
  store_Data,'H',data={x:time,y:[[h[*,0]],[h[*,1]],[h[*,2]]]}
  store_Data,'K',data={x:time,y:[[k[*,0]],[k[*,1]],[k[*,2]]]}
  store_Data,'HK',data={x:time,y:[[hk[*,0]],[hk[*,1]],[hk[*,2]]]}
  
  
  
  
  index=where(abs(v[*,0]) le 80.0  and  h[*,0] gt 2.0 )  ;
  t1=time[index]
  hx=h[index,0]
  separate_satisfy_interval,t1,start_point,terminal_point   ; get time intervals of V>100km/s
  
  indextt=where(terminal_point-start_point ne 0)            ;eliminate isolated points
  start_point=start_point[indextt]
  terminal_point=terminal_point[indextt]

  index_start=dblarr(n_elements(start_point))-1.0e10        ;0 
  index_end=dblarr(n_elements(start_point))-1.0e10          ;0
  j=0
  for i=0,n_elements(start_point)-1 do begin
    index_ss=where(start_point[i] eq t1)
    index_ee=where(terminal_point[i] eq t1)
    hx_temp=hx[index_ss:index_ee]
    tt_temp=t1[index_ss:index_ee]
    if max(hx_temp) ge 6.5  then begin                          ; Hx' peak ge 6.5
      index_start[j]=index_ss                                ;0
      index_end[j]=index_ee                                 ;0
      if index_ss ne 0 then begin
        append_array,hx,hx_temp
        append_array,tt,tt_temp
      endif
      j=j+1
    endif
    help
  endfor

  index_start=index_start[where(index_start ge 0)]
  index_end=index_end[where(index_end ge 0)]

  last=index_end-index_start+1
;  indd=where(last gt 7.5)  ;last time gt 30s
;  index_start=index_start[indd]
;  index_end=index_end[indd]
  
  

  for kk=0,n_elements(index_start)-1 do begin
    index_s=index_start[kk]
    index_e=index_end[kk]
    
    tstart_shadow=(time[index])[index_start[kk]]
    tend_shadow=(time[index])[index_end[kk]]
    
    tstart=(time[index])[index_s]-1*60.
    tend=(time[index])[index_e]+1*60
    
    plot_trange=[tstart,tend]
    
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_6pieces_include_BBF\littlev_largeh_events\'
    save_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\littlev_largeh_events'
    title_char=time_string(tstart,format=2)+'_'+time_string(tend,format=2)+'__'+strcompress(kk)+'__('+strcompress(iii)+')'
   
    ;timespan,time_string(time[0]),time[n_elements(time)-1]-time[0],/seconds
    init_crib_colors

    popen,output_dir+title_char,xsize=4.5,ysize=6.0,font=0,units='inches'
    tplot_options, 'font', 0
    tplot_options, 'charsize', 0.7
    tplot_options, 'xticklen', 0.05
    tplot_options, 'yticklen', 0.015
    tplot_options, 'zticklen', 0.3
    tplot_options, 'xgap', 0.3
    tplot_options, 'ygap', 0.8
    tplot_options, 'xmargin', [14,10]
    tplot_options, 'ymargin', [1,1]
   ; tplot_options, 'tickinterval', 60.*10.
    tplot_options,'y_no_interp',1
    time_stamp,/off
    options,'*',colors=[0,4,6]
     
     
    tplot_options,'polyfill.tstart',time_string(tstart_shadow)
    tplot_options,'polyfill.tend',time_string(tend_shadow)
    tplot_options,'polyfill.color','grey'
   
    ;   tlimit, time[0], time[n_elements(time)-1]-time[0], /seconds

    options, 'density',ytitle='n(cm^-3)',labflag=-1
    options, 'temperature',ytitle='T(kev)',labflag=-1
    options, 'pressure',ytitle='p(nPa)',labflag=-1
    options, 'velocity',ytitle='V(km/s)',labels=['Vx','Vy','Vz'],labflag=-1
    options, 'pos_gsm',ytitle='position',labels=['X','Y','Z'],labflag=-1
    options, 'B_gsm',ytitle='B(nT)',labels=['Bx','By','Bz'],labflag=-1
    options, 'H',ytitle='H',labels=['Hx','Hy','Hz'],labflag=-1  ;'H(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
    options, 'K',ytitle='K',labels=['Kx','Ky','Kz'],labflag=-1
;    options, 'AE_INDEX',ytitle='AE',labflag=-1
;    options, 'SYM_H',ytitle='SYM_H',labflag=-1
    tplot_new,['density','temperature','pressure','velocity','pos_gsm','B_gsm','H','K'],trange=plot_trange,/polyfill
    
    store_data,'thresh',data={x:[tstart:tend],y:fltarr(n_elements([tstart:tend]))+6.5},dlimits={color:6,linestyles:2}
    store_data,'thresh2',data={x:[tstart:tend],y:fltarr(n_elements([tstart:tend]))+80},dlimits={color:6,linestyles:2}
 
    tplot_panel,oplotvar='thresh',panel=6
    tplot_panel,oplotvar='thresh2',panel=3
   
    pclose


    ;del_Data,'*'
    print,title_char
    print,kk
    help
  endfor
  
  

  stop

end