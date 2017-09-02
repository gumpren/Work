pro save_time_interval_data
  compile_opt idl2
  filename0=file_search('C:\__Data\OMNI\*.cdf')
  tbeg=dblarr(4) & tend=dblarr(4)
  for jj=0,3 do begin
   for ii=0,106 do begin
    cdf2tplot,filename0[ii],varformat='BZ_GSM'
    case jj of
     0:begin
        find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[60*60.,666666666],nint=nint,tbeg=tbeg0,tend=tend0
        append_array,tbeg1,tbeg0
        append_array,tend1,tend0
       end       
     1:begin
        find_conti_intervals,'BZ_GSM',0,1000,margin=2*60,duration=[10*60.,60*60.],nint=nint,tbeg=tbeg0,tend=tend0
        append_array,tbeg2,tbeg0
        append_array,tend2,tend0
       end
     2:begin
        find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[60*60.,666666666],nint=nint,tbeg=tbeg0,tend=tend0
        append_array,tbeg3,tbeg0
        append_array,tend3,tend0
       end
     3:begin
        find_conti_intervals,'BZ_GSM',-1000,0,margin=2*60,duration=[10*60.,60*60.],nint=nint,tbeg=tbeg0,tend=tend0
        append_array,tbeg4,tbeg0
        append_array,tend4,tend0
       end
    endcase

   endfor
  endfor
  
  t_beg=create_struct('tbeg1',tbeg1,'tbeg2',tbeg2,'tbeg3',tbeg3,'tbeg4',tbeg4)
  t_end=create_struct('tend1',tend1,'tend2',tend2,'tend3',tend3,'tend4',tend4)
  
  save,t_beg,t_end,$
    filename='C:\__Data\Datasave\2001_2009_median_new\time_interval_divided_by_Bz.sav'
  
end