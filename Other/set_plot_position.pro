function set_plot_position,row,col,left=left,low=low,right=right,high=high,$
  xgap=xgap,ygap=ygap,isotropic=isotropic,panel_size=panel_size
 
  position=fltarr(row,col,4)
  if ~keyword_set(left) then left=0.1
  if ~keyword_set(low) then low=0.1
  if ~keyword_set(right) then right=0.9
  if ~keyword_set(high) then high=0.9
  if ~keyword_set(xgap) then xgap=0.1
  if ~keyword_set(ygap) then ygap=0.1
  if ~keyword_set(panel_size) then panel_size=make_array(row,value=1.0)
  xwidth=(right-left-(col-1.0)*xgap)/col
  ywidth=(high-low-(row-1.0)*ygap)/total(panel_size)
  if keyword_set(isotropic) then begin
    xwidth=(xwidth le ywidth) ? xwidth : ywidth
    ywidth=(xwidth le ywidth) ? xwidth : ywidth
  endif
  for i=0,row-1 do begin
    ylow=(i eq row-1) ? low : low+(ywidth*total(panel_size[i+1:row-1.0]))+(row-1.0-i)*ygap
    for j=0,col-1 do begin
      position[i,j,*]=[left+j*(xwidth+xgap),ylow,$
        left+j*(xwidth+xgap)+xwidth,ylow+ywidth*panel_size[i]]
    endfor
  endfor
  return,position
end
