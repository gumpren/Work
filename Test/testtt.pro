pro testtt
  restore,'C:\__Data\Datasave\2001_2009_6pieces_include_BBF\raw_data_2001_2009_gap1.000Re_list_all_plus_median3.sav'
  H_5_30=H_re
  k_5_30=k_re
  
  restore,'C:\__Data\Datasave\2001_2009_median_new_3\event_data_2001_2009_gap1.000Re_list_median.sav'
  H_10_30=H_re
  k_10_30=k_re
  
  window,0
  cgHistoplot, (k_5_30[0])[*,0], /FILL, POLYCOLOR='royal blue', xtitle='k_5_30' $
    , charsize=1.2, yticklen=0.05 , maxinput=0.02, MININPUT=-0.02, binsize=0.0001, histdata=hisdata1;, max_value=50, BINSIZE=0.02
  window,1
  cgHistoplot, (k_10_30[0])[*,0], /FILL, POLYCOLOR='royal blue', xtitle='k_10_30' $
    , charsize=1.2, yticklen=0.05 , maxinput=0.02, MININPUT=-0.02, binsize=0.0001, histdata=hisdata2;, max_value=50, BINSIZE=0.02
  
  stop
  
end