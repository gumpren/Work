
pro plot_line_variables_lasttime_10minute_per_point
  
  namestr=''
  suffix_str='_duskflank'
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  filename=root_dir+namestr+'raw_data'+save_str+'_list_10minute_per_point'+suffix_str+'.sav'
         
  restore,filename=filename
  
  x=indgen(15)
  vari=e_gsm_y
  vari_str='e_gsm_y'
  
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\'
  title_char='line_'+vari_str+'_lasttime_10minute_per_point'+suffix_str
  if (strmatch(filename,'*full*') eq 1b) then begin
    output_dir=output_dir+'full\'
    title_char='full_'+title_char
  endif else begin
    output_dir=output_dir
    title_char=title_char
  endelse

 
  title0=['median_'+vari_str+'_Bz','average_'+vari_str+'_Bz']
  ytitle=vari_str
  
  if (vari_str eq 'density' eq 1b)  then yrange=[0.0,0.5] ;n
  if (vari_str eq 'pressure' eq 1b)  then yrange=[0.05,0.11] ;p
  if (vari_str eq 'temperature' eq 1b)  then yrange=[1.0,5.0] ;t
  if (vari_str eq 'e_gsm_y' eq 1b)  then yrange=[-0.4,0.4] ; ey
  
  median_vari1=dblarr(15)  
  average_vari1=dblarr(15)
  median_vari2=dblarr(15)
  average_vari2=dblarr(15)
      
  for i=0,14 do begin
    median_vari1[i]=median(vari[i])
    average_vari1[i]=cal_average(vari[i],/normal_average)   ;fix average

    median_vari2[i]=median(vari[i+15])
    average_vari2[i]=cal_average(vari[i+15],/normal_average)    ; 57 58 
    
    print,i
    
  endfor
    
     
  a=[[[1],[2]], $
     [[3],[4]]]
  
  get_Data=[[[median_vari1],[median_vari2]],  $
           [[average_vari1],[average_vari2]]]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=8.0;,/ENCAPSULATED
  pos=set_plot_position(2,1,left=0.05,right=0.80,xgap=0.1,ygap=0.1,low=0.01,high=0.7)

  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add
  


  for i=0,1 do begin
;    for j=0,1 do begin
;      if i ne 1 then begin
;        str_element,opt_plot,'xtickformat','(a1)',/add
;        str_element,opt_plot,'xtitle',/delete
;      endif else begin
;        str_element,opt_plot,'xtickformat',/delete
;        str_element,opt_plot,'xtitle','Time',/add
;      endelse

      ;      if j eq 0 then begin
      ;        str_element,opt_plot,'ytitle',ytitle[0],/add
      ;      endif else begin
      ;        str_element,opt_plot,'ytitle',ytitle[1],/add
      ;      endelse
      ;str_element,opt_plot,'SYM_INCREMENT',3
;      str_element,opt_plot,'xtickname',['[0,0.5]','[0.5,1.0]','[1.0,1.5]','[1.5,2.0]','[2.0,2.5]','[2.5,3.0]',$
;        '[3.0,3.5]','[3.5,4.0]','[4.0,4.5]','[4.5,5.0]','[5.0,5.5]', $
;        '[5.5,6.0]','[6.0,6.5]','[6.5,7.0]','[7.0,7.5]','[7.5, 8.0]'],/add
      str_element,opt_plot,'xtickname',['0','10','20','30','40','50','60','70','80','90', $
      '100','110','120','130','140','150'],/add
      str_element,opt_plot,'xticks',15,/add
      str_element,opt_plot,'charsize',0.7,/add
      str_element,opt_plot,'xtitle',cgsymbol('delta')+'t',/add
      str_element,opt_plot,'ytitle',ytitle,/add

      
      cgplot,x,get_Data[*,0,i],position=pos[i,0,*],xrange=[0.5,14.5],yrange=yrange,_extra=opt_plot,/normal,/noerase
      cgoplot,x,get_Data[*,1,i],color='red',position=pos[i,0,*],_extra=opt_plot,/normal,/noerase
      labels_stamp,pos[i,0,*],title0[i],charsize=0.7,/left_right_center,/up_out
      
      ;      p = ERRORPLOT(x, get_Data[*,i,j], err_bar[*,i,j], XRANGE=[1,15], $
      ;        XTITLE="Day", YTITLE="Distance (miles)", $
      ;        TITLE="Average distance bears walk in a day")
    endfor
      
      cgText, 0.85, 0.68, 'Northward IMF Bz', ALIGNMENT=0, /NORMAL ,charsize=0.7
      cgText, 0.85, 0.66, 'Southward IMF Bz', ALIGNMENT=0, /NORMAL ,COLOR='RED',charsize=0.7

  ;  cgplot,x,aaa,position=pos[0,0,*],xrange=[-20,-10],_extra=opt_plot
  ;
  ;  cgplot,x,aaa,position=pos[0,1,*],xrange=[-20,-10],_extra=opt_plot

  cgps_close;,/png
  ;cgPS2Raster,output_dir+title_char+save_str+'.ps', /PNG

  stop


end