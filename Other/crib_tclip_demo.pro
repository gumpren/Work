pro crib_tclip_demo

  init_crib_colors
  cdffile='K:\original_data\OMNI\hro_1min\2012\omni_hro_1min_20120701_v01.cdf'
  cdf2tplot,cdffile,varformat='AE_INDEX'
  find_conti_intervals,'AE_INDEX',0,100,margin=5*60,duration=3600,nint=nint,tbeg=tbeg,tend=tend

end