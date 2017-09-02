pro crib_progress_bar

  tlb=widget_base(xsize=400,ysize=300)
  widget_control,tlb,/real
  prsbar=idlitwdprogressbar(group_leader=tlb,title='progress',cancel=cancelin)
  for ii=0,220 do begin
    if widget_info(prsbar,/valid) then begin
      idlitwdprogressbar_setvalue,prsbar,ii
    endif else begin
      tmp=dialog_message('click cancel, current progress'+string(ii)+'%',/info)
      break
    endelse
    wait,0.1
  endfor
  widget_control,tlb,/destroy

end