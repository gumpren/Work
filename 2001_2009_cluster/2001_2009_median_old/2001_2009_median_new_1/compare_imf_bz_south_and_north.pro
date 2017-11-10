pro compare_IMF_Bz_south_and_north
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'   ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_median_new_1\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new_1\'
  
  restore,filepath('H_Re_xy'+save_str+'.sav',root_dir=root_dir)
  
  H_Re_x1=reform(H_Re_x1,300*reverse_gap^2)
  H_Re_x2=reform(H_Re_x2,300*reverse_gap^2)
  H_Re_x3=reform(H_Re_x3,300*reverse_gap^2)
  H_Re_x4=reform(H_Re_x4,300*reverse_gap^2)
  H_Re_x5=reform(H_Re_x5,300*reverse_gap^2)
  H_Re_x6=reform(H_Re_x6,300*reverse_gap^2)
  
  H_Re_x1=H_Re_x1(where(H_Re_x1 ne 0))
  H_Re_x2=H_Re_x2(where(H_Re_x2 ne 0))
  H_Re_x3=H_Re_x3(where(H_Re_x3 ne 0))
  H_Re_x4=H_Re_x4(where(H_Re_x4 ne 0))
  H_Re_x5=H_Re_x5(where(H_Re_x5 ne 0))
  H_Re_x6=H_Re_x6(where(H_Re_x6 ne 0))
  
  
  BinSize=0.03
  
  cgHistoplot, H_Re_x3, POLYCOLOR='olive', /FILL, XRANGE=[-0.5,1.0], BINSIZE=binsize
  cgHistoplot, H_Re_x6, POLYCOLOR='yellow',XRANGE=[-0.5,1.0],/FILL, /OPLOT, BINSIZE=binsize
  firstPlot = cgSnapshot()
  
  cgHistoplot, H_Re_x6, POLYCOLOR='yellow',XRANGE=[-0.5,1.0], /FILL, BINSIZE=binsize
  cgHistoplot, H_Re_x3, POLYCOLOR='olive', /FILL, XRANGE=[-0.5,1.0], BINSIZE=binsize, /OPLOT

  secondPlot = cgSnapshot()
  
  cgBlendimage, firstPlot, secondPlot, ALPHA=0.75
  
;  cgHistoplot, H_Re_x3, BinSize=0.03, /Fill , polycolor='yellow',xrange=[-0.5,1.0]; mininput=-0.5, maxinput=1.0 
;  cgHistoplot, H_Re_x6, BinSize=0.03, /Fill , polycolor='olive', mininput=-0.5, maxinput=1.0, /oplot        
;  
  
;  Transparent_Histogram_Plot,H_Re_x3,H_Re_x6
  
  
  
  stop
end