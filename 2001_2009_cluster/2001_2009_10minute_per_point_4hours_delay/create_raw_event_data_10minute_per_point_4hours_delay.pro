;cerated by G.M. Ren   2017.11.23

pro create_raw_event_data_10minute_per_point_4hours_delay
  
   Re=6371.0
   root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point_4hours_delay\'
   start=systime(1)
   compile_opt idl2    
    
 ;  ________________________________part1_______________________
    
   restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
   
   for i=0,29 do begin
     tbeg=t_beg[i]
     tend=t_end[i]
     
     tbeg=tbeg+4*60*60.0
     tend=tend+4*60*60.0
          
     t_end[i]=tend
     t_beg[i]=tbeg
   endfor
   save,t_beg,t_end,  $
     filename=root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_4hours_delay.sav'

   
  ;; ________________________________part2________________________________________
     
       
                  
     restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_4hours_delay.sav'
    
     names=strarr(30)
     for kk=0,29 do begin
       if kk le 14 then begin
         bz='_BZgt0_'
         te=strcompress((kk+1)*10,/remove)
       endif else begin
         bz='_BZle0_'
         te=strcompress((kk+1-15)*10,/remove)
       endelse
    
       if kk lt 1 then tb='00'+strcompress(kk*10,/remove)
       if kk ge 1 and kk lt 10 then tb='0'+strcompress(kk*10,/remove)
       if kk ge 10 and kk le 14  then tb=strcompress(kk*10,/remove)
    
       if kk ge 15 and kk lt 15+1 then tb='00'+strcompress((kk-15)*10,/remove)
       if kk ge 15+1 and kk lt 15+10 then tb='0'+strcompress((kk-15)*10,/remove)
       if kk ge 15+10 and kk le 15+14 then tb=strcompress((kk-15)*10,/remove)
    
       names[kk]=bz+tb+'_'+te
     endfor
    
    
     for kk=29,0,-1 do begin     ;
       tbeg=t_beg[kk]
       tend=t_end[kk]
    
       for ii=0,8 do begin   ;0-8
         year='200'+strcompress(ii+1,/remove)
    
         restore,filename='C:\__Data\Datasave\variables_fgm_cis_efw'+year+'.sav'      ;if using tplot_restore, the efficiency of code runnig is too low because of too many superfluous variables
         store_Data,'pos_gsm_interp',data={x:time_all,y:pos_gsm_interp}
         store_Data,'velocity_gsm_interp',data={x:time_all,y:velocity_gsm_interp}
         store_Data,'B_total_interp',data={x:time_all,y:B_total_interp}
         store_Data,'B_gsm_interp',data={x:time_all,y:B_gsm_interp}
         store_Data,'density_interp',data={x:time_all,y:density_interp}
         store_Data,'temperature_interp',data={x:time_all,y:temperature_interp}
         store_Data,'pressure_interp',data={x:time_all,y:pressure_interp}
         store_Data,'Beta_clip_deflag_interp',data={x:time_all,y:Beta_clip_deflag_interp}
         store_Data,'E_gsm_interp',data={x:time_all,y:E_gsm_interp}
    
         index_terval=strfilter(time_string(tend,pre=-5),year,count=count,/index)
    
         for jj=0,count-1 do begin
           tic
    
           B_total_temp=tsample('B_total_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
           B_gsm_temp=tsample('B_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
           pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
           ;attention!!!selcet bbf  change this tplot variable
    
    
           if is_array(B_gsm_temp) then begin
             t_last_temp=(t_c3fgm_temp-tbeg[(index_terval[jj])])/60.0;+last_time_beg[kk]
             append_Array,t_last,TEMPORARY(t_last_temp)
             append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
             append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
             append_Array,B_gsm,TEMPORARY(B_gsm_temp)
             append_Array,B_total,TEMPORARY(B_total_temp)
          
           endif
           
              
           density_temp=tsample('density_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
           velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
           temperature_temp=tsample('temperature_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
           pressure_temp=tsample('pressure_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
           Beta_temp=tsample('Beta_clip_deflag_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
    
           if is_array(density_temp) then begin
             append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
             append_Array,density,TEMPORARY(density_temp)
             append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
             append_Array,temperature,TEMPORARY(temperature_temp)
             append_Array,pressure,TEMPORARY(pressure_temp)
             append_Array,Beta,TEMPORARY(Beta_temp)
           endif
    
           E_gsm_temp=tsample('E_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3efw_temp)
           if is_array(E_gsm_temp) then begin
             append_Array,t_c3efw,TEMPORARY(t_c3efw_temp)
             append_Array,E_gsm,TEMPORARY(E_gsm_temp)
           endif
    
           print,jj
           toc
    
         endfor
    
         print,(systime(1)-start)/60.
         print,'break1'
    
         if is_array(t_last) then begin
    
           append_Array,t_last1,TEMPORARY(t_last)
           append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
           append_Array,pos_gsm1,TEMPORARY(pos_gsm)
           append_Array,B_gsm1,TEMPORARY(B_gsm)
           append_Array,B_total1,TEMPORARY(B_total)
    
           append_Array,t_c3cis1,TEMPORARY(t_c3cis)
           append_Array,density1,TEMPORARY(density)
           append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
           append_Array,temperature1,TEMPORARY(temperature)
           append_Array,pressure1,TEMPORARY(pressure)
           append_Array,Beta1,TEMPORARY(Beta)
    
           append_Array,t_c3efw1,TEMPORARY(t_c3efw)
           append_Array,E_gsm1,TEMPORARY(E_gsm)
           
         endif
         del_data,'*'
         print,ii
    
       endfor
    
       if is_array(t_c3cis1) then begin
         save,t_c3cis1,t_last1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
           filename=root_dir+'c3_fgmcisefw_data_selected_10minute_per_point_4hours_delay'+names[kk]+'.sav'
    
         undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
         undefine,E_gsm1,t_last1,t_last_ture1;,tt_bbf_save
       endif
        print,(systime(1)-start)/60.
       print,jj
     endfor
    
     save_time_c3fgmcis=(systime(1)-start)/3600.0
     print,'save_time ',save_time_c3fgmcis,' hour'
    
     stop


; ; ________________________________part3_______________________


    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
    filename=file_search(root_dir+'c3_fgmcisefw_data_selected_10minute_per_point_2hours_delay'+'*.sav')
    counts=n_elements(filename)
         
    a=findgen(counts)
    eventimes=list(a,/ex)
    event_n=list(a,/ex)
    event_t=list(a,/ex)
    event_p=list(a,/ex)
    event_vx=list(a,/ex)
    event_vy=list(a,/ex)
    H_Re=list(a,/ex)
    event_hx=list(a,/ex)
    event_hy=list(a,/ex)
    K_Re=list(a,/ex)
    event_kx=list(a,/ex)
    event_ky=list(a,/ex)
    H_K_Re=list(a,/ex)
    event_h_k_x=list(a,/ex)
    event_h_k_y=list(a,/ex)
    
    E_gsm_y=list(a,/ex)
    event_ey=list(a,/ex)
    
    t_c3cis=list(a,/ex)
    B_gsm=list(a,/ex)
    pos_gsm=list(a,/ex)
    density=list(a,/ex)
    temperature=list(a,/ex)
    pressure=list(a,/ex)
    velocity_gsm=list(a,/ex) 
    t_last=list(a,/ex)
    
        
    t_last_beg=list(a,/ex)
    for jj = 0, 29 do begin
      if (jj ge 0) and (jj le 14)  then t_last_beg[jj]=(jj*10)
      if (jj ge 15) and (jj le 29)  then t_last_beg[jj]=((jj-15)*10)
    endfor
    
    bb=fltarr(counts)
    
    for i=0,counts-1 do begin
      restore,filename[i]
     
      indext=where(temperature1 lt 32)    ;T [0.005,32] KeV
      indexv=where(abs((velocity_gsm1[*,0])[indext]) le 2000.0)    ; V [-2000,2000]
      indexn=where((density1[indext])[indexv] le 10.0 and (density1[indext])[indexv] gt 0.001 )  ;n [0.001,100]
      ;indexey=where(E_gsm1[(([indext])[indexv])[indexn],1] gt 0)     ;ey gt 0
      index_all=((([indext])[indexv])[indexn]);[indexey]
    
      indextl=where(t_last1[index_all] ge  t_last_beg[i] )
      index_all=(index_all)[indextl]
      region_Str=''
      
;      index_pos=where(pos_gsm1[index_all,1] gt 0.0 ) & region_str='_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  ) & region_str='_dawnflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  and pos_gsm1[index_all,0] lt -15.0) & region_str='_far_dawnflank'
;      index_pos=where(pos_gsm1[index_all,1] gt 0.0  and pos_gsm1[index_all,0] lt -15.0) & region_str='_far_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] gt 0.0  and pos_gsm1[index_all,0] ge -15.0) & region_str='_near_duskflank'
;      index_pos=where(pos_gsm1[index_all,1] le 0.0  and pos_gsm1[index_all,0] ge -15.0) & region_str='_near_dawnflank'      
;      index_pos=where(pos_gsm1[index_all,0] gt -19.0 and pos_gsm1[index_all,0] le -16.0 $
;                  and pos_gsm1[index_all,1] gt  3.0  and pos_gsm1[index_all,1] le 6.0) & region_str='_dusk_3_3re'  
;       index_pos=where(pos_gsm1[index_all,0] gt -19.0 and pos_gsm1[index_all,0] le -16.0 $
;                   and pos_gsm1[index_all,1] gt -6.0  and pos_gsm1[index_all,1] le -3.0) & region_str='_dawn_3_3re' 
;      index_all=(index_all)[index_pos]
       
    
      t_c3cis[i]=t_c3cis1[index_all]
      t_last[i]=t_last1[index_all]
      density[i]=density1[index_all]
      temperature[i]=temperature1[index_all]
      pressure[i]=pressure1[index_all]
    
      B_gsm_x=B_gsm1[index_all,0]
      B_gsm_y=B_gsm1[index_all,1]
      B_gsm_z=B_gsm1[index_all,2]
      B_gsm[i]=[[B_gsm_x],[B_gsm_y],[B_gsm_z]]
    
      velocity_x=velocity_gsm1[index_all,0]
      velocity_y=velocity_gsm1[index_all,1]
      velocity_z=velocity_gsm1[index_all,2]
      velocity_gsm[i]=[[velocity_x],[velocity_y],[velocity_z]]
    
      pos_gsm_x=pos_gsm1[index_all,0]
      pos_gsm_y=pos_gsm1[index_all,1]
      pos_gsm_z=pos_gsm1[index_all,2]
      pos_gsm[i]=[[pos_gsm_x],[pos_gsm_y],[pos_gsm_z]]
    
      E_gsm_y[i]=E_gsm1[index_all,1]
      
      H_Re[i]=return_thermal_energy_flow_density(pressure[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
      K_Re[i]=return_kinetic_energy_flow_density(density[i],(velocity_gsm[i])[*,0],(velocity_gsm[i])[*,1],(velocity_gsm[i])[*,2],2)
      H_K_Re[i]=H_Re[i]+K_Re[i]

      bb[i]=n_elements(velocity_x)
    
;      ;event_data
;      eventimes[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],[],reverse_gap)
;      event_n[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],density[i],reverse_gap)
;      event_t[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],temperature[i],reverse_gap)
;      event_p[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],pressure[i],reverse_gap)
;      event_vx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,0],reverse_gap)
;      event_vy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(velocity_gsm[i])[*,1],reverse_gap)
;      event_ey[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],E_gsm_y[i],reverse_gap)
;
;      event_hx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,0],reverse_gap)
;      event_hy[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(H_Re[i])[*,1],reverse_gap)
;     
;      event_kx[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,0],reverse_gap)
;      event_ky[i]=return_vari_event((pos_gsm[i])[*,0],(pos_gsm[i])[*,1],(K_Re[i])[*,1],reverse_gap)
;    
;      event_h_k_x[i]=event_hx[i]+event_kx[i]
;      event_h_k_y[i]=event_hy[i]+event_ky[i]
      
      print,i
    endfor
    
    
;    save,t_last,eventimes,event_n,event_t,event_p,event_vx,event_vy,event_ey,     $
;      event_hx,event_kx,event_h_k_x,event_hy,event_ky,event_h_k_y,filename=root_dir+'full_event_data'+save_str+'_list_10minute_per_point.sav'
   
    save,t_c3cis,t_last,density,temperature,pressure,velocity_gsm,B_gsm,pos_gsm,E_gsm_y,H_Re,K_Re,H_K_Re,    $
      filename=root_dir+'raw_data'+save_str+'_list_10minute_per_point_2hours_delay'+region_str+'.sav'
;    stop
      
  
end