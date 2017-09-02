pro labels_stamp,pos_var,labels,$
    colors=colors,$
    charsize=chsize,$
    left_out=left_out,$
    left_in=left_in,$
    right_out=right_out,$
    right_in=right_in,$
    up_out=up_out,$
    up_in=up_in,$
    down_out=down_out,$
    down_in=down_in,$
    left_right_center=left_right_center,$
    up_down_center=up_down_center,$
    orientation=orientation,$
    dev_left=dev_left
    
  pos=pos_var
  dim=dimen(pos)
  if undefined(labels) then begin
    if n_elements(dim) eq 2 then begin
      labels=string(byte(indgen(dim[0]))+byte(97))
    endif else if n_elements(dim) eq 3 then begin
      labels=reform(string(reform(byte(indgen(dim[0],dim[1])+97),1,dim[0]*dim[1])),dim[0],dim[1])
    endif else begin
      print,'position dimension greater than 4 or smaller than 1.'
      return
    endelse
  endif
  nlabels = n_elements(labels)
  if not keyword_set(colors) then begin
    colors = 'black'
  endif
  if n_elements(colors) ne nlabels then colors = make_array(nlabels,value=colors)
  if n_elements(chsize) eq 0 then chsize = !p.charsize
  if chsize le 0 then chsize = 1.0
  
  if n_elements(dim) eq 3 then begin
    pos=transpose(reform(pos,dim[0]*dim[1],dim[2]))
    labels=transpose(reform(labels,dim[0]*dim[1]))
    colors=transpose(reform(colors,dim[0]*dim[1]))
  endif
  if ~keyword_set(dev_left) then dev_left=5.0
  if keyword_set(left_out) then xp=pos[0,*]-dev_left*chsize * !d.x_ch_size/!d.x_size
  if keyword_set(left_in) then xp=pos[0,*]+1.2*chsize * !d.x_ch_size/!d.x_size
  if keyword_set(right_out) then xp=pos[2,*]+1.2*chsize * !d.x_ch_size/!d.x_size
  if keyword_set(right_in) then xp=pos[2,*]-1.2*chsize * !d.x_ch_size/!d.x_size
  if keyword_set(up_out) then yp=pos[3,*]+0.6*chsize * !d.y_ch_size/!d.y_size
  if keyword_set(up_in) then yp=pos[3,*]-1.2*chsize * !d.y_ch_size/!d.y_size
  if keyword_set(down_out) then yp=pos[1,*]-2.3*chsize * !d.y_ch_size/!d.y_size
  if keyword_set(down_in) then yp=pos[1,*]+0.6*chsize * !d.y_ch_size/!d.y_size
  if keyword_set(up_down_center) then begin
    yp=(pos[1,*]+pos[3,*])/2.
  endif
  if keyword_set(left_right_center) then begin
    xp=(pos[0,*]+pos[2,*])/2.
  endif
  if ~keyword_set(orientation) then orientation=0
  cgtext,xp,yp,labels,color=colors,charsize=chsize,alignment=0.5,orientation=orientation,/normal
  
end


