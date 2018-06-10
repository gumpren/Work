Function read_data,file,maxrec=maxrec

  ;- Check arguments
  if (n_elements(file) eq 0) then message, 'file is undefined'

  ;seting the maximum number of the 'isldata' arrary of 'record' structure, maxrec can be changed according to requirements

  if (n_elements(file) gt 0) then maxrec=1000000L

  openr,lun,file,/get_lun

  

  fmt = '(2x,a22,5x,f10.7,5x,f10.7,4x,f11.7,4x,f10.7,4x,f10.7,2x,a3)'
  ;fmt = '(11x,i2,1x,i2,1x,i2,1x,i3,122x,i4,31x,i3)'
  record={date_time:1000L,mlt:0L,maglat:0L,IMF_clang:0L,IMF_By:0L,IMF_Bz:0L,SPCR:0L} ;defining the 'record' structure

  isldata=replicate(record,maxrec)

  ;- Read records until end-of-file reached
  nrecords = 0L
  recnum = 1L

  while (eof(lun) ne 1) do begin
    ;- Read this record (jumps to bad_rec: on error)
    on_ioerror, bad_rec
    error=1

    readf,lun,record,format=fmt

    error=0

    ;- Store data for this record
    isldata[nrecords]=record
    nrecords=nrecords + 1L

    ;- Check if maximum record count exceeded
    if (nrecords eq maxrec) then begin
      free_lun, lun
      message, 'Maximum record reached: increase MAXREC'
    endif

    ;- Check for bad input record
    bad_rec:
    if (error eq 1) then print, 'Bad data at record', recnum
    recnum=recnum + 1

  endwhile

  ;- Close input file unit
  free_lun, lun


  isldata=isldata[0:nrecords-1]
  return,isldata

end