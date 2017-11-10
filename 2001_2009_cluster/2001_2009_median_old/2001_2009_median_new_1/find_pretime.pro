pro find_pretime
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'   ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_median_new_1\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new_1\'
  
  
  restore,filepath('time_interval_divided_by_Bz.sav',root_Dir=root_dir)
  
  tbegin1=t_beg.tbeg1
  for i=0,n_elements(begin1)-1 do begin
      index1=where(t_end.tend1 le tbegin1[i])
      index2=where(t_end.tend2 le tbegin1[i])
      index3=where(t_end.tend3 le tbegin1[i])
      index4=where(t_end.tend4 le tbegin1[i])
      index5=where(t_end.tend5 le tbegin1[i])
      index6=where(t_end.tend6 le tbegin1[i])
      
      
      
  stop
  endfor
  stop
;  index1=where(t_end.tend1 eq t_beg.tbeg1)
;  index2=where(t_end.tend2 eq t_beg.tbeg1)
;  index3=where(t_end.tend3 eq t_beg.tbeg1)
;  index4=where(t_end.tend4 eq t_beg.tbeg1)
;  index5=where(t_end.tend5 eq t_beg.tbeg1)
;  index6=where(t_end.tend6 eq t_beg.tbeg1)
;  
;;  index11=neighbor_time(t_end.tend1,t_beg.tbeg1)
;;  ;index21=neighbor_time(t_end.tend2,t_beg.tbeg1)
;;  index31=neighbor_time(t_end.tend3,t_beg.tbeg1)
;  index41=neighbor_time(t_end.tend4,t_beg.tbeg1)
;  index51=neighbor_time(t_end.tend5,t_beg.tbeg1)
;  index61=neighbor_time(t_end.tend6,t_beg.tbeg1)
;;  index1=where(t_beg.tbeg2 eq t_end.tend1)
;;  index2=where(t_beg.tbeg2 eq t_end.tend2)
;;  index3=where(t_beg.tbeg2 eq t_end.tend3)
;;  index4=where(t_beg.tbeg2 eq t_end.tend4)
;;  index5=where(t_beg.tbeg2 eq t_end.tend5)
;;  index6=where(t_beg.tbeg1 eq t_end.tend6)
;;  
  stop
end