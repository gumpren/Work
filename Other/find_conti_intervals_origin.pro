;+
  ; :Description:
  ;    Describe the procedure.
  ;
  ; :Params:
  ;    tvar_name
  ;    min: minimum value of tvar_name
  ;    max: maximum value of tvar_name
  ;
  ; :Keywords:
  ;    dt: the nominal time resolution of the data that will be inserted,
  ;      the default is to choose the median of the input time array
  ;    margin: the margin used to determine if a gap is big enough, the
  ;          default is 0.25 seconds
  ;    duration: the shorest time duration
  ;    nint: number of intervals of continuous found in tplot variable
  ;    tbeg, tend: arrays of times to the begin and end of each continuous interval
  ;    
  ;
  ; :Author: dell
  ;-
pro find_conti_intervals_origin,tvar_name,min,max,dt=dt,margin=margin,$
  duration=duration,nint=nint,tbeg=tbeg,tend=tend

  del_data,'*_clip*'
  tplot_rename,tvar_name,'dat_orig'
  calc,'"dat_orig"="dat_orig"/1.0'
  tplot_rename,'dat_orig',tvar_name  
  tclip,tvar_name,min,max
  tdeflag,tvar_name+'_clip','remove_nan'
  tdegap,tvar_name+'_clip_deflag',dt=dt,margin=margin
  if in_set(tvar_name+'_clip_deflag_degap',tnames()) then begin
    get_data,tvar_name+'_clip_deflag_degap',data=data,dl=dl
  endif else begin
    tdegap,tvar_name+'_clip_deflag'
    get_data,tvar_name+'_clip_deflag_degap',data=data,dl=dl    
  endelse
  del_data,'*_clip*'
  y=[!values.f_nan,data.y,!values.f_nan]
  ss=where(finite(y) eq 0,nss)
  if nss gt 1 then begin
    flag=ss[1:nss-1]-ss[0:nss-2]
    gt1=where(flag gt 1,ngt1)
    nint=ngt1
    ibeg=ss[gt1]+1
    iend=ss[gt1]+flag[gt1]-1
    tbeg=data.x[ibeg]
    tend=data.x[iend]
  endif
  if keyword_set(duration) then begin
    dura=tend-tbeg
    ss=where(dura ge duration,nss)
    if nss gt 1 then begin
      nint=nss
      tbeg=tbeg[ss]
      tend=tend[ss]
    endif
  endif
end

