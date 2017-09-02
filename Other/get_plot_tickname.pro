pro power_of_tickname,range,ticks,tickv,tickname,tick_step

  power=alog10(float(range))
  low_power=ceil(min(power))
  high_power=floor(max(power))
  tick_step=fix(tick_step)
  ticks=(high_power-low_power)/(tick_step)
  tickv=fltarr(ticks+1)
  tickname=strarr(ticks+1)
  for i=0,ticks do begin
    tickv[i]=10.^(i*tick_step+low_power)
    tickname[i]=strcompress('10!u'+string(i*tick_step+low_power,format='(i3)')+'!n!x',/remove_all)
  endfor

end

pro line_of_tickname,range,ticks,tickv,tickname,tick_step

  power=floor(alog10(tick_step))
  ticks=floor((max(range)-min(range))/tick_step)
  low_line=ceil(min(range)/tick_step)*tick_step
  if (low_line ge max(range)) then return
  if (low_line+ticks*tick_step gt max(range)) then ticks=ticks-1
  tickv=fltarr(ticks+1)
  tickname=strarr(ticks+1)
  for i=0,ticks do begin
    tickv[i]=low_line+i*tick_step
    if (power ge 4) then begin
      format='(i5)'
      tickname[i]=strcompress(string(((low_line+i*tick_step)/10.^power),format=format),/remove_all)
    endif
    if (power lt 4 and power ge 0) then begin
      format='(i5)'
      tickname[i]=strcompress(string(((low_line+i*tick_step)),format=format),/remove_all)
    endif
    if (power lt 0) then begin
      format=strcompress('(f5.'+string(abs(power))+')',/remove_all)
      tickname[i]=strcompress(string(((low_line+i*tick_step)),format=format),/remove_all)
    endif
  endfor
  ;stop
end


function get_plot_tickname,xrange=xrange,yrange=yrange,zrange=zrange,xstep=xstep,ystep=ystep,zstep=zstep,$
  xlog=xlog,ylog=ylog,zlog=zlog

  if ~keyword_set(xlog) then xlog=0
  if ~keyword_set(ylog) then ylog=0
  if ~keyword_set(zlog) then zlog=0
  if ~undefined(xrange) then begin
    if ~keyword_set(xstep) then begin
      if xlog eq 0 then begin
        xstep=(max(xrange)-min(xrange))/3.0
        power=floor(alog10(xstep))
        xstep=floor(xstep/10.^power)*10.^power
        line_of_tickname,xrange,xticks,xtickv,xtickname,xstep
      endif else begin
        xstep=1
        power_of_tickname,xrange,xticks,xtickv,xtickname,xstep
      endelse
    endif else begin
      if xlog eq 0 then begin
        line_of_tickname,xrange,xticks,xtickv,xtickname,xstep
      endif else begin
        xstep=1
        power_of_tickname,xrange,xticks,xtickv,xtickname,xstep
      endelse
    endelse
    str_element,def_plot_options,'xrange',xrange,/add
    str_element,def_plot_options,'xlog',xlog,/add
    str_element,def_plot_options,'xticks',xticks,/add   
    str_element,def_plot_options,'xtickv',xtickv,/add
    str_element,def_plot_options,'xtickname',xtickname,/add
  endif
  if ~undefined(yrange) then begin
    if ~keyword_set(ystep) then begin
      if ylog eq 0 then begin
        ystep=(max(yrange)-min(yrange))/3.0
        power=floor(alog10(ystep))
        ystep=floor(ystep/10.^power)*10.^power
        line_of_tickname,yrange,yticks,ytickv,ytickname,ystep
      endif else begin
        ystep=1
        power_of_tickname,yrange,yticks,ytickv,ytickname,ystep
      endelse
    endif else begin
      if ylog eq 0 then begin
        line_of_tickname,yrange,yticks,ytickv,ytickname,ystep
      endif else begin
        ystep=1
        power_of_tickname,yrange,yticks,ytickv,ytickname,ystep
      endelse
    endelse
    str_element,def_plot_options,'yrange',yrange,/add
    str_element,def_plot_options,'ylog',ylog,/add
    str_element,def_plot_options,'yticks',yticks,/add
    str_element,def_plot_options,'ytickv',ytickv,/add
    str_element,def_plot_options,'ytickname',ytickname,/add
  endif
  if ~undefined(zrange) then begin
    if ~keyword_set(zstep) then begin
      if zlog eq 0 then begin
        zstep=(max(zrange)-min(zrange))/3.0
        power=floor(alog10(zstep))
        zstep=floor(zstep/10.^power)*10.^power
        line_of_tickname,zrange,zticks,ztickv,ztickname,zstep
      endif else begin
        zstep=1
        power_of_tickname,zrange,zticks,ztickv,ztickname,zstep
      endelse
    endif else begin
      if zlog eq 0 then begin
        line_of_tickname,zrange,zticks,ztickv,ztickname,zstep
      endif else begin
        zstep=1
        power_of_tickname,zrange,zticks,ztickv,ztickname,zstep
      endelse
    endelse
    str_element,def_plot_options,'zrange',zrange,/add
    str_element,def_plot_options,'zlog',zlog,/add
    str_element,def_plot_options,'zticks',zticks,/add
    str_element,def_plot_options,'ztickv',ztickv,/add
    str_element,def_plot_options,'ztickname',ztickname,/add
  endif
  str_element,def_plot_options,'xstyle',1,/add
  str_element,def_plot_options,'ystyle',1,/add
  str_element,def_plot_options,'nodata',1,/add
  str_element,def_plot_options,'noerase',1,/add
  str_element,def_plot_options,'normal',1,/add
  return,def_plot_options
;stop
end

