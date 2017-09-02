Function read_data,file,maxrec=maxrec

  ;- Check arguments
  if (n_elements(file) eq 0) then message, 'file is undefined'

  ;seting the maximum number of the 'isldata' arrary of 'record' structure, maxrec can be changed according to requirements

  if (n_elements(file) gt 0) then maxrec=1000000L

  openr,lun,file,/get_lun

  fmt = '(11x,i2,1x,i2,1x,i2,1x,i3,122x,i4,31x,i3)'
  record={hr:0L,min:0L,sec:0L,msec:0L,AE:0L,DST:0L} ;defining the 'record' structure

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

Pro write_data_with_form
      input_file=filepath('OMNI_HRO_1MIN_7631.txt1',root_dir='E:\IDLworks\任干明NO1')
      data=read_data(input_file)
      hr=data.hr
      min=data.min
      sec=data.sec
      msec=data.msec
      AE=data.AE
      DST=data.DST
        
      index=where(AE lt 200 and DST gt -30)
      row=n_elements(index)
      peaceful_data=fltarr(6,row)
      peaceful_data[0,*]=hr[index]
      peaceful_data[1,*]=min[index]
      peaceful_data[2,*]=sec[index]
      peaceful_data[3,*]=msec[index]
      peaceful_data[4,*]=AE[index]
      peaceful_data[5,*]=DST[index]

      openw,lun,filepath('peaceful_data.dat',root_dir='E:\IDLworks\任干明NO1'),/get_lun,width=500    
      printf,lun,peaceful_data,format='(i2,1x,i2,1x,i1,1x,i1,5x,i4,5x,i3)'
      free_lun,lun
  
   
   
   
      index1=where(AE ge 200 and DST le -30) 
      row=n_elements(index1)
      active_data=fltarr(6,row)
      active_data[0,*]=hr[index1]
      active_data[1,*]=min[index1]
      active_data[2,*]=sec[index1]
      active_data[3,*]=msec[index1]
      active_data[4,*]=AE[index1]
      active_data[5,*]=DST[index1]
      
      openw,lun,filepath('active_data.dat',root_dir='E:\IDLworks\任干明NO1'),/get_lun,width=500
      printf,lun,active_data,format='(i2,1x,i2,1x,i1,1x,i1,5x,i4,5x,i3)'
    
    
       
 free_lun,lun
 
 end     
      
