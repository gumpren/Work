pro read_dat_data
   filename='F:\___Download\u.dat'
 ;  Openr, lun, filepath(filename, root_dir=''), /get_lun;建立并打开一个输出文件
   
   n_lat = 46 ; given
   n_lon = 72 ; given
   lat = fltarr(n_lat)
   lon = fltarr(n_lon)
   u = fltarr(n_lon, n_lat)
   v = fltarr(n_lon, n_lat)
   
   ;method 1
   Openr,lun,filename,/get_lun
   readf,lun,uu
   free_lun,lun
 
 
 
   ;method 2
   tt=ascii_template(filename)
   data=READ_ASCII(filename,TEMPLATE=tt)
   print,data.(0)
   ;read_ascii_cmdline()
   
   
   stop





end