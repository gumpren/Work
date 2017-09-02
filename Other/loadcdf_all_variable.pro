;+
; :author: yangjian
;-

;+
; :description:
;    describe the procedure.
;
; :params:
;    cdffile
;
; :keywords:
;    g_attributes
;    atts
;    index_need
;    var_structure
;    _extra
;
; :author: dell
;-
function loadcdf_all_variable,cdffile,g_attributes=g_attributes,atts=atts,index_need=index_need,$
  var_structure=var_structure,_extra=extra_
  compile_opt idl2
  data_structure=cdf_load_vars(cdffile,varformat='*',_extra=extra_)
  var_structure=data_structure.vars
  varnames=data_structure.vars.name
  varnames_new=strsplit(varnames[0], escape='-', /extract)
  index=indgen(n_elements(varnames))
  g_attributes=data_structure.g_attributes

  ;;;convert the time in hours
  epoch=*data_structure.vars[0].dataptr
  row=n_elements(epoch)
  time_tag=fltarr(row)
;print,(var_structure.datatype)[0]
  case (var_structure.datatype)[0] of
    'CDF_EPOCH': begin
      for i=0l,row-1l do begin
        cdf_epoch,epoch[i],yr,mo,dy,hr,min,sec,milli,/breakdown_epoch
        time_tag[i]=hr*3600.0+min*60.0+(sec+milli/(1.0e3));/3600.0
      endfor
    end
    'CDF_EPOCH16': begin
      for i=0ll,row-1ll do begin
        cdf_epoch16,epoch[i],yr,mo,dy,hr,min,sec,milli,micro,nano,pico,/breakdown_epoch
        time_tag[i]=hr*3600.0+min*60.0+(sec+milli/(1.0e3)+micro/(1.0e6)+nano/(1.0e9)+pico/(1.0e12));/3600.0
      endfor
    end
    'CDF_TIME_TT2000': begin
      for i=0l,row-1l do begin
        cdf_tt2000,epoch[i],yr,mo,dy,hr,min,sec,milli,micro,nano,/breakdown_epoch
        time_tag[i]=hr*3600.0+min*60.0+(sec+milli/(1.0e3)+micro/(1.0e6)+nano/(1.0e9));/3600.0
      endfor
    end
    else: print,'the time type of the cdf file are not epoch, epoch16 or tt2000'
  endcase
  data=create_struct(varnames_new[0],time_tag)
;  data=create_struct(varnames_new[0],*data_structure.vars[0].dataptr)
  atts=list()

;  print,index[0],varnames[0],format='(i-3,1x,a-)'
  for i = 0l,n_elements(varnames)-1 do begin
;    print,index[i],varnames[i],format='(i-3,1x,a-)'
    if i lt n_elements(varnames)-1 then begin
      varnames_new=[varnames_new,strsplit(varnames[i+1], escape='-', /extract)]
      if ((var_structure.dataptr)[i+1] ne ptr_new() and strmatch(varnames_new[i+1],'*#*') ne 1) then begin
        data=create_struct(data,varnames_new[i+1],*data_structure.vars[i+1].dataptr)
;        print,index[i+1],varnames_new[i+1],format='(i-3,1x,a-)'
      endif
    endif
    atts.add,*data_structure.vars[i].attrptr
  endfor
  if n_elements(index_need) ne 0 then begin
    return,data.(index_need)
  endif else begin
    return,data
  endelse
  
end