pro bz_divided_by_10minutes

  Re=6371.0
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  start=systime(1)
  compile_opt idl2

  filename0=file_search('C:\__Data\OMNI\*.cdf')

;  ;part1.1
;  a=findgen(30)
;  t_beg=list(a,/ex)
;  t_end=list(a,/ex)
;  duration=list(a,/ex)
;  marg=list(a,/ex)
;  error_point=list(a,/ex)
;
;  for jj=0,29 do begin
;    if (jj le 14) then begin
;      maxvalue=1000
;      minvalue=0
;    endif else begin
;      maxvalue=0
;      minvalue=-1000
;    endelse
;
;    if (jj eq 0 or jj eq 15) then duration[jj]=[4,10]*60.0
;    if (jj ge 1) and (jj le 14)  then  duration[jj]=[jj*10,jj*10+10]*60.
;    if (jj ge 16) and (jj le 29) then  duration[jj]=[(jj-15)*10,(jj-15)*10+10]*60.   ;duration
;
;    if (jj eq 0 or jj eq 15) then marg[jj]=0*60.0
;    if (jj eq 1 or jj eq 16) then marg[jj]=1*60.0
;    if ((jj ge 2) and (jj le 14) or (jj ge 17) and (jj le 29)) then marg[jj]=2*60.0  ;marg
;
;    if (jj eq 0 or jj eq 15) then error_point[jj]=2
;    if (jj eq 1 or jj eq 16) then error_point[jj]=3
;    if (jj eq 2 or jj eq 17) then error_point[jj]=5
;    if ((jj ge 3) and (jj le 14) or (jj ge 18) and (jj le 29)) then error_point[jj]=8  ;error_point
;
;    for ii=0,131 do begin             ;divided by year
;      cdf2tplot,filename0[ii],varformat='BZ_GSM'
;      get_data,'BZ_GSM',time0,BZ_GSM0
;      append_array,time,time0
;      append_array,BZ_GSM,BZ_GSM0
;
;      if (((ii+1) mod 12) eq 0) or (ii eq 131) then begin
;        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
;        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=marg[jj],duration=duration[jj],nint=nint,tbeg=tbeg0,tend=tend0
;
;        for i=0,n_elements(tbeg0)-1 do begin
;          tic
;          bz_tmep=tsample('BZ_GSM1',[tbeg0[i],tend0[i]],times=t_omni_temp)
;          if jj le 14 then indices=where(bz_tmep lt 0)
;          if jj gt 15 then indices=where(bz_tmep gt 0)
;
;          if ( N_ELEMENTS(indices) le error_point[jj] ) then begin   ;
;            append_Array,tbeg1,tbeg0[i]
;            append_Array,tend1,tend0[i]
;          endif
;          toc
;        endfor
;        undefine,time,BZ_GSM
;      endif
;    endfor
;    t_beg[jj]=tbeg1
;    t_end[jj]=tend1
;    undefine,tbeg1,tend1
;    print,jj
;  endfor
;
;  savetime_t=(systime(1)-start)/60.0
;
;  save,t_beg,t_end,savetime_t,$
;    filename=root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point.sav'
;


  ;part1.2   add time after 150 minutes
  tt_beg=list(length=2)
  tt_end=list(length=2)

  for jj=0,1 do begin
    if (jj le 0) then begin
      maxvalue=1000
      minvalue=0
    endif else begin
      maxvalue=0
      minvalue=-1000
    endelse

    duration=[150,6666666666]*60.   ;duration

    marg=2*60.0  ;marg

    error_point=8  ;error_point

    for ii=0,131 do begin             ;divided by year
      cdf2tplot,filename0[ii],varformat='BZ_GSM'
      get_data,'BZ_GSM',time0,BZ_GSM0
      append_array,time,time0
      append_array,BZ_GSM,BZ_GSM0

      if (((ii+1) mod 12) eq 0) or (ii eq 131) then begin
        store_Data,'BZ_GSM1',data={x:time,y:BZ_GSM}
        find_conti_intervals,'BZ_GSM1',minvalue,maxvalue,margin=marg,duration=duration,nint=nint,tbeg=tbeg0,tend=tend0

        for i=0,n_elements(tbeg0)-1 do begin
          tic
          bz_tmep=tsample('BZ_GSM1',[tbeg0[i],tend0[i]],times=t_omni_temp)
          if jj eq 0 then indices=where(bz_tmep lt 0)
          if jj eq 1 then indices=where(bz_tmep gt 0)

          if ( N_ELEMENTS(indices) le error_point ) then begin   ;
            append_Array,tbeg1,tbeg0[i]
            append_Array,tend1,tend0[i]
          endif
          toc
        endfor
        undefine,time,BZ_GSM
      endif
    endfor
    tt_beg[jj]=tbeg1
    tt_end[jj]=tend1
    undefine,tbeg1,tend1
    print,jj
  endfor
  save,tt_beg,tt_end,filename=root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point_tt.sav'


  ;part1.3
  restore,root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point.sav'
  restore,root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point_tt.sav'

  t_beg14=t_beg[14]
  t_end14=t_end[14]
  append_array,t_beg14,tt_beg[0]
  append_array,t_end14,tt_beg[0]+150.0*60
  t_beg[14]=t_beg14
  t_end[14]=t_end14

  t_beg29=t_beg[29]
  t_end29=t_end[29]
  append_array,t_beg29,tt_beg[1]
  append_array,t_end29,tt_beg[1]+150.0*60
  t_beg[29]=t_beg29
  t_end[29]=t_end29            ;add time after 150 minutes

  aa=fltarr(30)
  for i=0,29 do begin
    aa[i]=N_ELEMENTS(t_end[i])
  endfor

  time_array=(10*findgen(14)+10)*60.0

  for i=14,4,-1 do begin
    tb1=t_beg[i]
    te1=t_end[i]
    tb2=t_beg[i-1]
    te2=t_end[i-1]
    append_array,tb2,tb1
    append_array,te2,tb1+time_array[i-1]
    t_beg[i-1]=tb2
    t_end[i-1]=te2

    tb11=t_beg[i+15]
    te11=t_end[i+15]
    tb22=t_beg[i+14]
    te22=t_end[i+14]
    append_array,tb22,tb11
    append_array,te22,tb11+time_array[i-1]
    t_beg[i+14]=tb22
    t_end[i+14]=te22

    print,i
  endfor

  ; eliminate error point
  ;    restore,'C:\__Data\Datasave\omni_imf_bz.sav'
  ;    store_data,'BZ_GSM1',time,bz_gsm

  error_p=[2,3,5]
  for i=3,1,-1 do begin

    ;bz_north
    tb1=t_beg[i]
    te1=t_end[i]
    tb2=t_beg[i-1]
    te2=t_end[i-1]

    for j=0,n_elements(tb1)-1 do begin ;
      tic

      tb_str=time_string(tb1[j],precision=-4,format=2)
      te_str=time_string(tb1[j]+time_array[i-1],precision=-4,format=2)
      filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')
      filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
      if ( (filename1 eq filename2) eq 1b) then begin
        filename=filename1
      endif else begin
        filename=[filename1,filename2]
      endelse

      ;        if(n_elements(filename) eq 1) then begin
      ;          loadcdf,filename[0],'Epoch',time
      ;          loadcdf,filename[0],'BZ_GSM',BZ_GSM
      ;        endif else begin
      ;          loadcdf,filename[0],'Epoch',time0
      ;          loadcdf,filename[1],'Epoch',time1
      ;          loadcdf,filename[0],'BZ_GSM',BZ_GSM0
      ;          loadcdf,filename[1],'BZ_GSM',BZ_GSM1
      ;
      ;          time=[time0,time1]
      ;          BZ_GSM=[BZ_GSM0,BZ_GSM1]
      ;        endelse
      ;
      ;        store_data,'BZ_GSM',time,BZ_GSM

      cdf2tplot,filename,varformat=['BZ_GSM']

      bz_temp=tsample('BZ_GSM',[tb1[j],tb1[j]+time_array[i-1]],times=t_omni_temp)
      indices=where(bz_temp lt 0)

      if ( N_ELEMENTS(indices) le error_p[i-1] ) then begin   ;
        append_Array,tb2,tb1[j]
        append_Array,te2,tb1[j]+time_array[i-1]
      endif

      toc
    endfor

    t_beg[i-1]=tb2
    t_end[i-1]=te2


    ;bz south
    tb11=t_beg[i+15]
    te11=t_end[i+15]
    tb22=t_beg[i+14]
    te22=t_end[i+14]
    for j=0,n_elements(tb11)-1 do begin

      tb_str=time_string(tb11[j],precision=-4,format=2)
      te_str=time_string(tb11[j]+time_array[i-1],precision=-4,format=2)
      filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')
      filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
      if ( (filename1 eq filename2) eq 1b) then begin
        filename=filename1
      endif else begin
        filename=[filename1,filename2]
      endelse
      cdf2tplot,filename,varformat=['BZ_GSM']


      bz_temp=tsample('BZ_GSM',[tb11[j],tb11[j]+time_array[i-1]],times=t_omni_temp)
      indices=where(bz_temp gt 0)

      if ( N_ELEMENTS(indices) le error_p[i-1] ) then begin   ;
        append_Array,tb22,tb11[j]
        append_Array,te22,tb11[j]+time_array[i-1]
      endif
    endfor
    t_beg[i+14]=tb22
    t_end[i+14]=te22

    print,i
  endfor


  bb=fltarr(30)
  for i=0,29 do begin
    bb[i]=N_ELEMENTS(t_end[i])
  endfor

  save_time=(systime(1)-start)/60.0
  save,t_beg,t_end,save_time,  $
    filename=root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
  stop

end