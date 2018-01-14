pro file_move_to
   date='200'+strcompress(ii+1,/remove)
   
   
   file_move,'C:\Users\Gren\Desktop\1\aa*.txt','C:\Users\Gren\Desktop\2\'
   file_mkdir,'C:\__Data\THEMIS\the\state\'
   
   file_move,'C:\__Data\THEMIS\tha\state\*_v0*.cdf','C:\Users\Gren\Desktop\2\'
   file_move,'C:\__Data\THEMIS\thd\state\the*.cdf','C:\__Data\THEMIS\the\state\'
   
   ;if you want delete multi files, you should use FILE_SEARCH to get a list of files first.
   filename1=file_search('C:\Users\Gren\Desktop\2\*.cdf')
   file_delete,filename1
;   file_move
;   file_mkdir
;
  

end