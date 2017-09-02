  pro plot_y_direction_average_new
  
    Re=6371.0
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
    ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
    root_dir='C:\__Data\Datasave\2001_2009_median_new_2\'
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new_2\'
  
    ee=1
  
  
    title0=[['B!dz!n!x>0 5~15min','B!dz!n!x>0 15~30min','B!dz!n!x>0 30~60min','B!dz!n!x>0 60~90min','B!dz!n!x>0 >90min'],$
            ['B!dz!n!x<0 5~15min','B!dz!n!x<0 15~30min','B!dz!n!x<0 30~60min','B!dz!n!x<0 60~90min','B!dz!n!x<0 >90min']]
  
    restore,filepath('H_Re_xy'+save_str+'_new3.sav',root_dir=root_dir)
  ;  restore,filepath('K_Re_xy'+save_str+'.sav',root_dir=root_dir)
  ;  restore,filepath('event_vxy'+save_str+'.sav',root_dir=root_dir)
  
  ;  vx1=reform(event_vx1,10*30*reverse_gap^2)
  ;  vx2=reform(event_vx2,10*30*reverse_gap^2)
  ;  vx3=reform(event_vx3,10*30*reverse_gap^2)
  ;  vx4=reform(event_vx4,10*30*reverse_gap^2)
  ;
  ;  vy1=reform(event_vy1,10*30*reverse_gap^2)
  ;  vy2=reform(event_vy2,10*30*reverse_gap^2)
  ;  vy3=reform(event_vy3,10*30*reverse_gap^2)
  ;  vy4=reform(event_vy4,10*30*reverse_gap^2)
  
    H_RE_X1=reform(H_RE_X1,4350*reverse_gap^2)
    H_RE_X2=reform(H_RE_X2,4350*reverse_gap^2)
    H_RE_X3=reform(H_RE_X3,4350*reverse_gap^2)
    H_RE_X4=reform(H_RE_X4,4350*reverse_gap^2)
    H_RE_X5=reform(H_RE_X5,4350*reverse_gap^2)
    H_RE_X6=reform(H_RE_X6,4350*reverse_gap^2)
    H_RE_X7=reform(H_RE_X7,4350*reverse_gap^2)
    H_RE_X8=reform(H_RE_X8,4350*reverse_gap^2)
    H_RE_X9=reform(H_RE_X9,4350*reverse_gap^2)
    H_RE_X10=reform(H_RE_X10,4350*reverse_gap^2) 
  
    H_RE_Y1=reform(H_RE_Y1,4350*reverse_gap^2)
    H_RE_Y2=reform(H_RE_Y2,4350*reverse_gap^2)
    H_RE_Y3=reform(H_RE_Y3,4350*reverse_gap^2)
    H_RE_Y4=reform(H_RE_Y4,4350*reverse_gap^2)
    H_RE_Y5=reform(H_RE_Y5,4350*reverse_gap^2)
    H_RE_Y6=reform(H_RE_Y6,4350*reverse_gap^2)
    H_RE_Y7=reform(H_RE_Y7,4350*reverse_gap^2)
    H_RE_Y8=reform(H_RE_Y8,4350*reverse_gap^2)
    H_RE_Y9=reform(H_RE_Y9,4350*reverse_gap^2)
    H_RE_Y10=reform(H_RE_Y10,4350*reverse_gap^2) 
  
  ;  K_RE_X1=reform(K_RE_X1,300*reverse_gap^2)
  ;  K_RE_X2=reform(K_RE_X2,300*reverse_gap^2)
  ;  K_RE_X3=reform(K_RE_X3,300*reverse_gap^2)  ; 0.8 error data
  ;  K_RE_X4=reform(K_RE_X4,300*reverse_gap^2)
  ;
  ;  K_RE_Y1=reform(K_RE_Y1,300*reverse_gap^2)
  ;  K_RE_Y2=reform(K_RE_Y2,300*reverse_gap^2)
  ;  K_RE_Y3=reform(K_RE_Y3,300*reverse_gap^2)
  ;  K_RE_Y4=reform(K_RE_Y4,300*reverse_gap^2)
  
    case ee of
      1:begin
         yrange=[-0.5,0.5]
         ytitle=['Hx','HX']
         data=[[[H_RE_X1],[H_RE_X2],[H_RE_X3],[H_RE_X4],[H_RE_X5]], $
               [[H_RE_X6],[H_RE_X7],[H_RE_X8],[H_RE_X9],[H_RE_X10]]]
         title_char='Hx median along Y direction'
        end
      2:begin
         yrange=[-0.2,0.2]
         ytitle=['Hy','Hy']
         data=[[[H_RE_Y1],[H_RE_Y2],[H_RE_Y3],[H_RE_Y4],[H_RE_Y5]], $
               [[H_RE_Y6],[H_RE_Y7],[H_RE_Y8],[H_RE_Y9],[H_RE_Y10]]]
         title_char='Hy median along Y direction'
        end
  ;    2:begin
  ;       yrange=[-0.1,0.1]
  ;       ytitle=['Kx','Ky']
  ;       data=[[[K_RE_X1],[K_RE_X2],[K_RE_X3],[K_RE_X4]], $
  ;            [[K_RE_Y1],[K_RE_Y2],[K_RE_Y3],[K_RE_Y4]]]
  ;       title_char='K average along Y direction'
  ;      end
  ;    3:begin
  ;       yrange=[-200,600]
  ;       ytitle=['Vx','Vy']
  ;       data=[[[vx1],[vx2],[vx3],[vx4]],$
  ;            [[vx1],[vx2],[vx3],[vx4]]]
  ;       title_char='Velocity average along Y direction'
  ;      end
     endcase
  
  
  ;  data=[[[H_RE_X1],[H_RE_X2],[H_RE_X3],[H_RE_X4]], $
  ;        [[H_RE_Y1],[H_RE_Y2],[H_RE_Y3],[H_RE_Y4]]]
  ;;
  ;;  data=[[[K_RE_X1],[K_RE_X2],[K_RE_X3],[K_RE_X4]], $
  ;;        [[K_RE_Y1],[K_RE_Y2],[K_RE_Y3],[K_RE_Y4]]]
     get_Data1=dblarr(145,5,2)
     get_Data2=dblarr(145,5,2)
  
  ;  for i=0,3 do begin
  ;    for j=0,1 do begin
  ;      for k=0,9 do begin
  ;        sum=0
  ;        for t=0,29 do begin
  ;         sum=sum+data[k+10*t,i,j]
  ;        endfor
  ;         get_Data[k,i,j]=average(sum)       ; average along y direction
  ;      endfor
  ;    endfor
  ;  endfor
  
  
  for i=0,4 do begin
    for j=0,1 do begin
      for k=0,144 do begin
        data_divide1=dblarr(15)
        data_divide2=dblarr(15)
        for t=0,14 do begin
          data_divide1[t]=data[k+145*t,i,j]
          data_divide2[t]=data[k+145*(t+15),i,j]
        endfor
        
        data_divide1=data_divide1[where(data_divide1 ne 0)]
        data_divide2=data_divide2[where(data_divide2 ne 0)]
        get_Data1[k,i,j]=average(data_divide1)   ; median along y direction
        get_Data2[k,i,j]=average(data_divide2)
        print,k
      endfor
    endfor
  endfor
  
  
  cgps_open,output_dir+title_char+save_str+'_new3.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(5,2,left=0.05,right=0.63,xgap=0.1,ygap=0.06,low=0.01,high=0.8)
  
  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add
  
  x=linspace(-19.5,-10.5,145*reverse_gap)
  
 
  for i=0,4 do begin
    for j=0,1 do begin
      if i ne 4 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse
  
      if j eq 0 then begin
        str_element,opt_plot,'ytitle',ytitle[0],/add
      endif else begin
        str_element,opt_plot,'ytitle',ytitle[1],/add
      endelse
  
      cgplot,x,get_Data1[*,i,j],position=pos[i,j,*],xrange=[-20,-10],yrange=yrange,_extra=opt_plot,/normal,/noerase
      cgoplot,x,get_Data2[*,i,j],color='red',position=pos[i,j,*],xrange=[-20,-10],yrange=yrange,_extra=opt_plot,/normal,/noerase
      labels_stamp,pos[i,j,*],title0[i,j],charsize=0.8,/left_right_center,/up_out
    endfor
  endfor
  
  
  ;  cgplot,x,aaa,position=pos[0,0,*],xrange=[-20,-10],_extra=opt_plot
  ;
  ;  cgplot,x,aaa,position=pos[0,1,*],xrange=[-20,-10],_extra=opt_plot
  
  cgps_close
  
  
  
  stop
  
  
  end