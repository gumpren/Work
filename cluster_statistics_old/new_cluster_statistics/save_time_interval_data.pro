pro save_time_interval_data
  compile_opt idl2
  filename0=file_search('C:\__Data\OMNI\*.cdf')
  for ii=0,n_elements(filename0)-1 do begin
    cdf2tplot,filename0[ii],varformat='BZ_GSM'
    find_conti_intervals,'BZ_GSM',0,9999,margin=2*60,duration=60*60.,nint=nint,tbeg=tbeg,tend=tend
    tbeg0=array_concat(tbeg,tbeg0)    
    tend0=array_concat(tend,tend0)
  endfor
  store_data,'tbeg_BZgt0_duragt1hr',data={x:time_double('2016-12-06'),y:tbeg0}
  store_data,'tend_BZgt0_duragt1hr',data={x:time_double('2016-12-06'),y:tend0}
  tplot_save,['tbeg_BZgt0_duragt1hr','tend_BZgt0_duragt1hr'],$
    filename='C:\__Data\Datasave\2001_2009_median_new\time_interval_BZgt0_duragt1hr'
  
end