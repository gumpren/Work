pro test_tend_equal
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  restore,root_dir+'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
  
  a=2
  tbeg=t_beg[a]
  tend=t_end[a]

  tb=tbeg[sort(tbeg)]
  tb_gap=shift(tb,-1)-tb
  indexb=where(tb_gap eq 0)

  te=tend[sort(tend)]
  te_gap=shift(te,-1)-te
  indexe=where(te_gap eq 0)

  stop


end
