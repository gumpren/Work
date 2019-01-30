pro copy_file_name_txt

   filename1=file_search('D:\video1\250\1-50\*.mkv')
   help,filename1
   filename2=file_search('D:\video1\250\51-100\*.mkv')
   filename=[filename1,filename2]
   file_str1=strarr(51)
   file_str2=strarr(50)

   
   for i=0,n_elements(filename1)-1 do begin
     file_str1[i]=strmid(filename1[i],19,strlen(filename1[i])-19)
      ;stop
   endfor
   
   for i=0,n_elements(filename2)-1 do begin
     file_str2[i]=strmid(filename2[i],21,strlen(filename2[i])-21)
     ;stop
   endfor
   
   file_str=[file_str1,file_str2]
   openw,lun,filepath('top250list.txt',root_dir='D:\video1\250\'),/get_lun,width=500
   for j=0,n_elements(file_str)-1 do begin
     printf,lun,file_str[j]
   endfor
   
  ; printf,lun,file_str
   free_lun,lun
   
   stop



end