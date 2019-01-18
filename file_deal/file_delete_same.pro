pro file_delete_same
  root_Dir='E:\OneDrive\Pictures\Camera Roll\'
  filename1=file_search(root_Dir+'Screenshot*.jpg')
  help,filename1
  a=0
  
  for i=0,n_elements(filename1)-1 do begin
    str_index_beg=STRPOS(filename1[i],'Screenshot')
    str_index_end=STRPOS(filename1[i],'.jpg')
    file_str=strmid(filename1[i],str_index_beg,strlen(filename1[i])-str_index_beg-4)
    file_same1=file_search(root_Dir+file_str+'.png')
    if ( (file_same1 eq '') ne 1b) then begin
      
      file_delete,file_same1
      
      a=a+1
      print,a
    endif
    
  endfor
  ;file_delete,filename1
  stop
  
  ;file_delete_same
end