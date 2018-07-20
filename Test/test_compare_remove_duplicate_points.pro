pro test_compare_remove_duplicate_points
    str='remove_duplicate_points_'
    root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
    restore,root_dir+'raw_data_2001_2009_gap1.000Re_list_10minute_per_point.sav'
    
    dens=density
    
    restore,root_dir+str+'raw_data_2001_2009_gap1.000Re_list_10minute_per_point.sav'
    dens_remove=density
    
    gaps=dblarr(30)
    for i=0,29 do begin
      gaps[i]=n_elements(dens[i]-dens_remove[i])                  
    endfor
    
    stop


end