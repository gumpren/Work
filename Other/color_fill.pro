pro color_fill,pos,data,xrange=xrange,yrange=yrange,zrange=zrange,$
  xlog=xlog,ylog=ylog,zlog=zlog,backcolor=backcolor,top=top,bottom=bottom,$
  opt_plot=opt_plot,opt_bar=opt_bar

  if n_elements(pos) ne 4 then begin
    print,'plot position not 4 elements'
    return
  endif
  if n_elements(data) eq 0 then begin
    print,'no plot data'
    return
  endif
  x=data.x
  y=data.v
  z=data.y
  d1=dimen1(z)
  d2=dimen2(z)
  if n_elements(x) ne d1+1 and n_elements(y) ne d2+1 then begin
    print,'the plot data dimension not equal'
    return
  endif
  if ~keyword_set(xlog) then xlog=0
  if ~keyword_set(ylog) then ylog=0
  if ~keyword_set(zlog) then zlog=0
  if ~keyword_set(xrange) then xrange=minmax(x)
  if ~keyword_set(yrange) then yrange=minmax(y)
  if ~keyword_set(zrange) then zrange=minmax(z)
  xrange0=xrange
  yrange0=yrange
  if (xlog ne 0) then begin
    xrange0=alog10(xrange)
    x=alog10(x)
  endif
  if (ylog ne 0) then begin
    yrange0=alog10(yrange)
    y=alog10(y)
  endif
  if ~keyword_set(backcolor) then backcolor='white'
  colors=bytescale(z,range=zrange,log=zlog,bottom=bottom,top=top)
  for i=0,d1-1 do begin
    xl=pos[0]+(x[i]-xrange0[0])*(pos[2]-pos[0])/(xrange0[1]-xrange0[0])
    xr=pos[0]+(x[i+1]-xrange0[0])*(pos[2]-pos[0])/(xrange0[1]-xrange0[0])
    for j=0,d2-1 do begin
      yl=pos[1]+(y[j]-yrange0[0])*(pos[3]-pos[1])/(yrange0[1]-yrange0[0])
      yh=pos[1]+(y[j+1]-yrange0[0])*(pos[3]-pos[1])/(yrange0[1]-yrange0[0])      
      if finite(z[i,j]) eq 0 then color=backcolor else color=colors[i,j]
      cgcolorfill,[xl,xl,xr,xr,xl],[yl,yh,yh,yl,yl],color=color,/normal
    endfor
  endfor
  cgplot,x,y,xlog=xlog,ylog=ylog,xrange=xrange,yrange=yrange,position=pos,$
    /normal,/nodata,/noerase,_extra=opt_plot
    
  
  str_element,opt_bar,'charsize',value=charsize,index=index
  if index lt 0 then charsize=!p.charsize
  if charsize eq 0. then charsize=1.
  str_element,opt_bar,'charsize',charsize,/add
  str_element,opt_bar,'no_color_scale',no_color_scale
  str_element,opt_bar,'no_color_scale',/delete
  str_element,opt_bar,'position',value=position,index=index
 ; str_element,opt_bar,/ylog
  if index lt 0 then position=[pos[2]+charsize*!d.x_ch_size/!d.x_size,pos[1],$
    pos[2]+3.*charsize*!d.x_ch_size/!d.x_size,pos[3]]

  if ~keyword_set(no_color_scale) then begin
    cgcolorbar,range=zrange,bottom=bottom,ncolors=top-bottom+1,position=position,/right,/vertical,_extra=opt_bar
  endif
end

