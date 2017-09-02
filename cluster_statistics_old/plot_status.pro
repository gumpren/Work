 pro plot_status

  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('eventimes_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  cgps_open,output_dir+'cluster_status_2001_2009_median_gap0.833.ps',xsize=6.0,ysize=7.0
  cgloadct,39
  pos0=set_plot_position(3,4,left=0.05,right=0.725,xgap=0.025,ygap=0.05,low=0.05,high=0.48)
  xrange=[[0,12],[0,12],[2,8]]
  xstep=[2,2,1]
  xtitle1=[('B!dz!n!x(nT)'),('P!ddyn!n!x(nPa)'),('|V!dx!n!x|(10!u2!n!xkm/s)')]
  xval=[[findgen(7)*2],[findgen(7)*2],[findgen(7)+2]]
  yval=dblarr(6,4,3)  ;0B,1P,2Vx
  for i=0,5 do begin
    for j=0,3 do begin
      yval[i,j,0]=data_divided.bzt[i,j]/total(data_divided.bzt[*,j])
      yval[i,j,1]=data_divided.pt[i,j]/total(data_divided.pt[*,j])
      yval[i,j,2]=data_divided.vxt[i,j]/total(data_divided.vxt[*,j])
    endfor
  endfor  
  for j=0,3 do begin 
    for k=0,2 do begin  
     def_opt=get_plot_tickname(xrange=xrange[*,k],yrange=[0,1],xstep=xstep[k],ystep=0.2) 
     if (j ne 0) then str_element,def_opt,'ytickname',strarr(def_opt.yticks+1)+' ',/add
     str_element,def_opt,'charsize',0.6,/add
     str_element,def_opt,'xminor',3,/add
     str_element,def_opt,'xticklen',0.05,/add
      ;str_element,def_opt,'xtilte',xtitle1[k],/add
     cgplot,[0,0],[0,0],position=pos0[k,j,*],xtitle=xtitle1[k],_extra=def_opt

     for i=0,5 do EX_BOX,xval[i,k],!y.CRANGE[0],xval[i+1,k],yval[i,j,k],50
     endfor
   endfor
  
   ;plot higher part
   pos=set_plot_position(1,4,left=0.05,right=0.725,xgap=0.025,ygap=0.06,low=0.51,high=0.93)
   x=linspace(-20,-10,13)
   v=linspace(-15,15,37)
   xrange=[-20,-10]
   yrange=[15,-15]
   zrange=[0.001,450]
   
   eventimes1=reform(eventimes1,432)
   eventimes2=reform(eventimes2,432)
   eventimes3=reform(eventimes3,432)
   eventimes4=reform(eventimes4,432)
   
   data=[[eventimes1],[eventimes2],[eventimes3],[eventimes4]]
   idx=where(data eq 0)
   data[idx]=!values.f_nan
   title0=['B!dz_IMF!n!x>0 d!dt!n!x>1hr','B!dz_IMF!n!x>0 d!dt!n!x<1hr','B!dz_IMF!n!x<0 d!dt!n!x>1hr','B!dz_IMF!n!x<0 d!dt!n!x<1hr']

   str_element,opt_plot,'charsize',0.6,/add
   str_element,opt_plot,'yticklen',0.05,/add
   str_element,opt_plot,'XMINOR',2,/add
   str_element,opt_plot,'xrange',xrange,/add
   str_element,opt_plot,'yrange',yrange,/add
   
   str_element,opt_bar,'no_color_scale',0,/add
   str_element,opt_bar,'charsize',0.6,/add
   str_element,opt_bar,'title','Times',/add
     
   for j=0,3 do begin
      ;str_element,opt_plot,'title',title0[j,i],/add
       if j ne 0 then begin
         str_element,opt_plot,'ytickformat','(a1)',/add
         str_element,opt_plot,'ytitle',/delete
       endif else begin
         str_element,opt_plot,'ytickformat',/delete
         str_element,opt_plot,'ytitle','Y(Re)',/add
       endelse

       if j eq 3 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
       str_element,opt_bar,'position',[pos[0,j,2]+0.02,pos[0,j,1],pos[0,j,2]+0.05,pos[0,j,3]],/add
       d={x:x,y:reform(data[*,j],12,36),v:v}
       color_fill,pos[0,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange,top=254,bottom=0,backcolor='white',zlog=1,opt_plot=opt_plot,opt_bar=opt_bar
     endfor
   
   labels_stamp,pos[0,*,*],title0[*],charsize=0.8,/left_right_center,/up_out
   
  cgps_close



  stop

end