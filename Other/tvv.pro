pro tvv
   array=dblarr(100,100)
   for i=0,99 do begin
    for j=0,99 do begin
      array[i,j]=3*i+5*j
    endfor
   endfor
 
   xno=4 & x0=0.05 & x1=0.95 & detax=0.025
   dx=(x1-x0-detax*(xno-1))/xno
   yno=4


   entry_device=!d.name
   set_plot,'ps'
   device,/color,Bits_per_pixel=8.0
   TVLCT, r, g, b,/Get
   output_dir='E:\OneDrive\IDLworks\cluster_statistics\ps\'
   device,filename=output_dir+'1234.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
   !p.multi=[0,xno,yno,0,0]
   loadct,39
   device,decomposed=0

   scaled=bytscl(array,min=11,max=100,top=250,/nan)
   tv,scaled,0.2,0.2,xsize=0.8,ysize=0.8,/normal

   device,/close_file
   set_plot,entry_device 
   
end