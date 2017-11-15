
Pro write_data_without_form
  input_file=filepath('OMNI_HRO_1MIN_7631.txt1',root_dir='E:\IDLworks\浠诲共��O1')
  data=read_data(input_file)
  hr=data.hr
  min=data.min
  sec=data.sec
  msec=data.msec
  AE=data.AE
  DST=data.DST

;  index=where(AE lt 200 and DST gt -30)
;  row=n_elements(index)
;  peaceful_data=fltarr(6,row)
;  peaceful_data[0,*]=hr[index]
;  peaceful_data[1,*]=min[index]
;  peaceful_data[2,*]=sec[index]
;  peaceful_data[3,*]=msec[index]
;  peaceful_data[4,*]=AE[index]
;  peaceful_data[5,*]=DST[index]
;
;  openw,lun,filepath('peaceful_data_noform.dat',root_dir='E:\IDLworks\浠诲共��O1'),/get_lun,width=500
;  writeu,lun,peaceful_data;,format='(i2,1x,i2,1x,i1,1x,i1,5x,i4,5x,i3)'




        index1=where(AE ge 200 and DST le -30)
        row=n_elements(index1)
        active_data=fltarr(6,row)
        active_data[0,*]=hr[index1]
        active_data[1,*]=min[index1]
        active_data[2,*]=sec[index1]
        active_data[3,*]=msec[index1]
        active_data[4,*]=AE[index1]
        active_data[5,*]=DST[index1]
  
        openw,lun,filepath('active_data_noform.dat',root_dir='E:\IDLworks\浠诲共��O1'),/get_lun,width=500
        writeu,lun,active_data;,format='(i2,1x,i2,1x,i1,1x,i1,5x,i4,5x,i3)'



  free_lun,lun

end

