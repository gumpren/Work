pro test_tend_tbeg
   root_Dir='C:\__Data\Datasave\2001_2009_5minute_per_point\'
   
   restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_5minute_per_point_add_former_time1.sav'
   tbfix=t_beg
   tefix=t_end
   
   restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_5minute_per_point_add_former_time.sav'
   
   j=0
   for i=0,59 do begin
      tb=total(tbfix[i]-t_beg[i])
      te=total(tefix[i]-t_end[i])
        
      if (tb ne 0 or te ne 0  )  then  j=j+1
   endfor
   
   stop
   



end