PRO timebar_shadow,pos,t1,t2,trange,color=color,bx_linestyle=bx_linestyle,bx_thick=bx_thick,verbose=verbose,$
  varname=varname,between=between,transient=transient,bx_color=bx_color,box=box
  ;+
  ;NAME:                  timebar_shadow
  ;PURPOSE:
  ;                       plot vertical shadows on TPLOTs at specified times (or values)
  ;CALLING SEQUENCE:      timebar_shadow,t1,t2
  ;INPUTS:                t1: string of start times at which to draw vertical shadows,
  ;                       seconds since Jan, 1, 1970.
  ;                       t2: string of end times at which to draw vertical shadows,
  ;                       seconds since Jan, 1, 1970.
  ;KEYWORD PARAMETERS:
  ;      COLOR:      byte or bytarr of color values
  ;      BX_LINESTYLE:  int or intarr of box linestyles
  ;      BX_THICK:      int or intarr of box line thicknesses
  ;      BOX:        in, optional, type=boolean, default=0
  ;        Set this keyword to draw a box around shadows
  ;        
  ;   for any of the above keywords, a scalar input will apply to all times
  ;      VERBOSE: print more error messages; useful for debugging
  ;      VARNAME: TPLOT variable name or index indicating panel in which to plot bar
  ;      BETWEEN: array of two TPLOT variable names indicating
  ;           between which two panels to plot timebar_shadow
  ;      TRANSIENT:  timebar_shadow,t,/transient called once plots a
  ;           timebar_shadow. Called twice, it deletes the timebar_shadow.
  ;                                Note:  1) all other keywords except VERBOSE
  ;                                be the same for both calls. 2) COLOR will most
  ;                                likely not come out what you ask for, but
  ;                                since it's transient anyway, shouldn't matter.
  ;OUTPUTS:
  ;OPTIONAL OUTPUTS:
  ;COMMON BLOCKS:         tplot_com
  ;SEE ALSO:
  ;  "CTIME","TPLOT"
  ;CREATED BY:            Jiang Yu
  ;LAST MODIFICATION:     2016/10/24
  ;FILE:                  timebar_shadow.pro
  ;VERSION:               1.11
  ;-
  @tplot_com

  ; Validate parameter according to whether it is a timebar or a databar:
  ;
  if undefined(t1 or t2) then begin
    read, prompt = 'Please provide start time for timebar_shadow: ', t1
    read, prompt = 'Please provide end time for timebar_shadow: ', t2
  endif else begin
    if n_elements(t1) ne n_elements(t2) then begin
      print,'error:the number of start time and end time is not equal'
      return
    endif else begin
      t1_double = time_double(t1)
      t2_double = time_double(t2)      
    endelse
  endelse

  nt_inter = n_elements(t1_double)
  if not keyword_set(color) then begin
    if !p.background eq 0 then color = !d.n_colors-1 else color = 0
  endif
  if n_elements(color) ne nt_inter then color = make_array(nt_inter,value=color)
  if not keyword_set(bx_linestyle) then bx_linestyle = 2
  if n_elements(bx_linestyle) ne nt_inter then bx_linestyle = make_array(nt_inter,value=bx_linestyle)
  if not keyword_set(bx_thick) then bx_thick = 1
  if n_elements(bx_thick) ne nt_inter then bx_thick = make_array(nt_inter,value=bx_thick)
  if not keyword_set(bx_color) then bx_color = 0
  if n_elements(bx_color) ne nt_inter then bx_color = make_array(nt_inter,value=bx_color)

  if !d.name eq 'X' or !d.name eq 'WIN' then begin
    current_window= !d.window > 0
    wset,tplot_vars.settings.window
    ;    wshow,icon=0
  endif

  nd1 = n_elements(datanames)-1
  nd0 = 0
  if keyword_set(varname) then begin
    nd = where( tnames(varname[0]) eq  tplot_vars.options.varnames)
    nd0=nd[0]
    nd1=nd[0]
  endif
  yp = fltarr(2)
  yr = fltarr(2)

  if keyword_set(between) eq 0 then begin
    yp[0] = pos[3,nd0]
    yp[1] = pos[1,nd1]
  endif else begin
    nd0 = (where(between[0] eq tplot_vars.options.varnames))[0]
    nd1 = (where(between[1] eq tplot_vars.options.varnames))[0]
    yp[0] = pos[3,nd0]
    yp[1] = pos[1,nd1]
  endelse

  if keyword_set(transient) then $
    device, get_graphics = ograph, set_graphics = 6 ;set to xor

  for i=0l,nt_inter-1 do begin
    tpl = t1_double[i] - trange[0];time_offset
    tpl = pos[0,0] + tpl/(trange[1]-trange[0]) * (pos[2,0]-pos[0,0])
    tpr = t2_double[i] - trange[0];time_offset
    tpr = pos[0,0] + tpr/(trange[1]-trange[0]) * (pos[2,0]-pos[0,0])
    if tpl ge pos[0,0] and tpl le pos[2,0] and tpr ge pos[0,0] and tpr le pos[2,0] then begin
      cgcolorfill,[tpl,tpl,tpr,tpr,tpl],[yp[0],yp[1],yp[1],yp[0],yp[0]],color=color[i],/normal
      if keyword_set(box) then begin
        cgplots,[tpl,tpl],yp,linestyle=bx_linestyle[i],thick=bx_thick[i],color=bx_color[i],/normal
        cgplots,[tpr,tpr],yp,linestyle=bx_linestyle[i],thick=bx_thick[i],color=bx_color[i],/normal
      endif
    endif else if keyword_set(verbose) then $
      dprint, 'Time '+time_string(t2[i])+' is out of trange.'
  endfor
  
  if keyword_set(transient) then device,set_graphics=ograph

  if !d.name eq 'X' or !d.name eq 'WIN' then begin
    wset,current_window
  endif
  return
END
