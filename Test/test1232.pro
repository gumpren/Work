pro test1232

     filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*.cdf')
     cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
     get_Data,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',data=data
     
     append_Array,density,data.y
    
    
   
   stop
end
