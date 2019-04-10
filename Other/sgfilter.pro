;-------------------------------------------------------------------------
;                         S-G FILTER PROGRAM
;         written by zhu xiaolin, ires of bnu, email:zhuxiaolin.rs@gmail.com
;                               2007-03

;          reference: chen jin et.al,2004,paper in RSE
;-------------------------------------------------------------------------
compile_opt idl2
;open the image file

Pro GetData,ImgData = ImgData,ns = ns,nl = nl,nb = nb,Data_Type = Data_Type,$
  FileName = FileName,Map_info = map_Info
  Filter = ['all file;*.*']
  Envi_Open_File,FileName,R_Fid = R_Fid,/no_realize
  Envi_File_Query,R_Fid,ns = ns,nl = nl,nb = nb,Data_Type = Data_Type
  map_info = envi_get_map_info(fid=R_Fid)
  dims = [-1,0,ns - 1 ,0,nl - 1]

  case Data_Type Of
    1:ImgData = BytArr(ns,nl,nb)    ;  BYTE  Byte
    2:ImgData = IntArr(ns,nl,nb)    ;  INT  Integer
    3:ImgData = LonArr(ns,nl,nb)    ;  LONG  Longword integer
    4:ImgData = FltArr(ns,nl,nb)    ;  FLOAT  Floating point
    5:ImgData = DblArr(ns,nl,nb)    ;  DOUBLE  Double-precision floating
  EndCase
  For i = 0,nb-1 Do Begin
    Dt = Envi_Get_Data(Fid = R_Fid,dims = dims,pos=i)
    ImgData[*,*,i] = Dt[*,*]
  EndFor
End


;--------------------------------------------------------------------------------
function fill_up, data_in, maxNDVI               ;remove the cloudy values

  num_elements=n_elements(data_in)/2.
  data_cloud=data_in[0,*]
  vector_in=data_in[1,*];;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  in=where(data_cloud ge 2)
  vector_in[in]=0;;;;;;;;;;;;;;;;;把云雪归0
  for in_pixel=1, num_elements-2 do begin
    if ((data_cloud[in_pixel] eq 1) and ((vector_in[in_pixel-1] - vector_in[in_pixel]) GE 0.2*maxNDVI $
      or (vector_in[in_pixel+1] - vector_in[in_pixel]) GE 0.2*maxNDVI)) then vector_in[in_pixel] =0;;;;;把flag=1处的，临近突然降低0.2单位的归0
    if((data_cloud[in_pixel] eq 0)and data_cloud[in_pixel-1] eq 1)$
      then vector_in[in_pixel-1]=(vector_in[in_pixel-1] ge (vector_in[in_pixel]+0.2*maxNDVI))? 0 : vector_in[in_pixel-1];
    if((data_cloud[in_pixel] eq 0)and data_cloud[in_pixel+1] eq 1)$
      then vector_in[in_pixel+1]=(vector_in[in_pixel+1] ge (vector_in[in_pixel]+0.2*maxNDVI))? 0 : vector_in[in_pixel+1];
    ;;;;以上两行把flag=0左右比它高0.2单位的归0
  endfor
  ;;;;;above lines set cloud and low quality data to 0
  in=where((data_cloud eq 1 and vector_in ne 0), count)
  data_cloud[in]=5
  in=where(data_cloud eq 0, count)
  high_i=0
  while count ge 2 and high_i le count-2 do begin
    for high_j=in[high_i], in[high_i+1] do begin
      new_val=vector_in[in[high_i]]+(high_j-in[high_i])*(vector_in[in[high_i+1]]-vector_in[in[high_i]])/(in[high_i+1]-in[high_i])
      if data_cloud[high_j] eq 5 then vector_in[high_j]=(new_val ge vector_in[high_j])? new_val : vector_in[high_j]
    endfor

    high_i++
  endwhile
  ;;;;;;;;;;把flag=1且原始值低于最近两个flag=0高质量点差值的的地方归0
  in_pixel = 0
  if vector_in[in_pixel] EQ 0 then begin
    pixel_start = in_pixel
    while vector_in[in_pixel] EQ 0 && in_pixel LT num_elements -2 do begin
      in_pixel = in_pixel +1
    endwhile
    pixel_end = in_pixel
    vector_in[pixel_start:pixel_end-1] = vector_in[pixel_end]
  endif

  in_pixel = num_elements-1
  if vector_in[in_pixel] EQ 0 then begin
    pixel_end = in_pixel
    while vector_in[in_pixel] EQ 0 && in_pixel GT 2 do begin
      in_pixel = in_pixel -1
    endwhile
    pixel_start = in_pixel
    vector_in[pixel_start+1:pixel_end] = vector_in[pixel_start]
  endif

  in_pixel = 1
  while in_pixel LT num_elements - 2 do begin
    if vector_in[in_pixel] EQ 0 then begin
      pixel_start = in_pixel
      num_pixel = 1
      while vector_in[in_pixel] EQ 0 && in_pixel LT num_elements -2 do begin
        in_pixel = in_pixel +1
        num_pixel = num_pixel +1
      endwhile
      pixel_end = in_pixel
      temp = (vector_in[pixel_end] - vector_in[pixel_start-1]) / num_pixel
      for pixel = 0, num_pixel-2 do begin
        vector_in[pixel_start + pixel] = vector_in[pixel_start -1] + (pixel+1)*temp
      endfor
    endif
    in_pixel = in_pixel + 1
  endwhile

  ;  in_pixel = 1
  ;  while  in_pixel LT num_elements -2 do begin
  ;    if ((vector_in[in_pixel] - vector_in[in_pixel -1]) GE 0.2*maxNDVI $
  ;      && (vector_in[in_pixel] - vector_in[in_pixel +1]) GE 0.2*maxNDVI) $
  ;      or ((vector_in[in_pixel] - vector_in[in_pixel -1]) GE -0.2*maxNDVI $
  ;      && (vector_in[in_pixel] - vector_in[in_pixel +1]) GE -0.2*maxNDVI) then begin
  ;      vector_in[in_pixel] = (vector_in[in_pixel -1] + vector_in[in_pixel +1]) /2.0
  ;      in_pixel = in_pixel +2
  ;    endif else begin
  ;      in_pixel = in_pixel +1
  ;    endelse
  ;  endwhile

  return, vector_in

end

;-----------------------------------------------------------------------------------------
function sgfilter,vector_in, num_bd                 ;S-G filter

  num_elements = n_elements(vector_in)
  ; The first Savitzky-Golay fitting
  vector_in=reform(vector_in,num_bd)                         ; 20 is the number of values of time-series
  savgolFilter = SAVGOL(4,4,0,2)                          ;set the window width(4,4) and degree (2) for computing trend curve
  rst = CONVOL(vector_in, savgolFilter, /EDGE_TRUNCATE)

  ; Calculate the threshold for loop control, so that the fit is maximize
  gdis = 0.0
  fl = IntARR(num_elements)

  for i =0,(num_elements-1) do begin
    fl[i] = (vector_in[i] ge rst[i])
    gdis = gdis + fl[i]*abs(vector_in[i]-rst[i])*abs(vector_in[i]-rst[i])
  endfor

  ra4 = fltARR(num_elements)
  pre = fltARR(num_elements)

  ormax = gdis
  num   = 0

  loop_times = 0l
  while (gdis le ormax) && loop_times LT 1000 do begin
    loop_times = loop_times +1
    for i =0,(num_elements-1) do begin
      ra4[i] = (vector_in[i] ge rst[i]) ? vector_in[i] : rst[i]
      pre[i] = rst[i]
    endfor

    ; The Savitzky-Golay fitting
    savgolFilter = SAVGOL(4, 4, 0, 2)        ;set the window width(4,4) and degree (6) for repetition
    rst = CONVOL(ra4, savgolFilter, /EDGE_TRUNCATE)
    ormax = gdis
    ; Calculate the fitting-effect index
    gdis = 0.0
    for i =0,(num_elements-1) do begin
      gdis = gdis + fl[i]*abs(vector_in[i]-rst[i])*abs(vector_in[i]-rst[i])
    endfor
  endwhile

  if loop_times GE 1000 then begin
    print, 'loop times is: ', loop_times
  endif


  return, pre

end ; of function sgfilter


