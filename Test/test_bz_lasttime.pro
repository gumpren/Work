pro test_bz_lasttime
   
;   Re=6371.0
;   root_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\'
;   reverse_gap=5.0/10.0
;   save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re' 
;   restore,root_dir+'time_interval_divided_by_Bz_yearly_add_former_time.sav'
;  
;   
;   filename0=file_search('C:\__Data\OMNI\*.cdf')
;   
;   for ii=0,106 do begin             ;divided by year
;      cdf2tplot,filename0[ii],varformat='BZ_GSM'
;      get_data,'BZ_GSM',time0,BZ_GSM0
;      append_array,time,time0
;      append_array,BZ_GSM,BZ_GSM0
;   endfor
;   
;   tt_5_30=t_beg[0]
;   
;   for k=0,n_elements(tt_5_30)-1 do begin
;     indexb=where(tt_5_30[k] eq time)
;     append_array,index_beg,indexb
;   endfor
;   
;   bz_beg=BZ_GSM[index_beg]
;   tbz_beg=time[index_beg]
;   tt=tbz_beg[where(bz_beg gt 5.0)]
;   bbz=bz_beg[where(bz_beg gt 5.0)]
;   
;   save,tbz_beg,bz_beg,tt,bbz,filename='bz_gt_5_timerange_05_30.sav' 
   
   restore,filename='bz_gt_5_timerange_05_30.sav'
   
   cgps_open,'bz_beg_times.ps',xsize=6.0,ysize=7.0
   cgHistoplot,bz_beg , /FILL, POLYCOLOR='royal blue', xtitle='bz_beg' $
     , charsize=1.2, yticklen=0.05, binsize=0.5 
   cgps_close
    stop
end