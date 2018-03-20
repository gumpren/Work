pro test_fit
 
  restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\H_x_average_median_arr_dawn_dusk_lasttime_10minute_per_point_4panel.sav'
  x=10*(findgen(15))+5
  y1=alog10(median_vari_dawn_north)
  y2=alog10(median_vari_dawn_south)


  polynomial_fit,x,alog10(median_vari_dawn_north),alog10(median_vari_dawn_south),5,measure_errors=measure_errors,plot_vis=1


  stop

end