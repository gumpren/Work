
Pro zuoye2
      
      input_file=filepath('OMNI_HRO_1MIN_7631.txt1',root_dir='E:\IDLworks\浠诲共��O2')
      data=read_data(input_file)
      rows=n_elements(data)
      
      hr=data.hr
      min=data.min
      Bx=data.Bx
      By=data.By
      Bz=data.Bz
      v=data.v
      rou=data.rou
      p=data.p
      AE=data.AE
      DST=data.DST
      UT=hr+min/60.0
      
      for i=0,rows-1 do begin
      if Bx[i] gt 1000 then Bx[i]=Bx[i-1]
      if By[i] gt 1000 then By[i]=By[i-1]
      if Bz[i] gt 1000 then Bz[i]=Bz[i-1] 
      if v[i]  gt 1500 then v[i]=v[i-1]
      if rou[i] gt 100 then rou[i]=rou[i-1]
      if p[i]  gt  90  then p[i]=p[i-1]
      endfor 
     
      
      
      
      
      entry_device=!d.name
      set_plot,'ps'
      device,/color,bits_per_pixel=8
      TVLCT, r, g, b, /Get
      output_dir='E:\IDLworks\浠诲共��O2\'
      device,filename=output_dir+'AE_DST.ps',xsize=5.5,ysize=6.5,$
        xoffset=1,yoffset=2,/inches,/encapsulated
      !p.multi=[0,1,8,0,0]
      
      device,decomposed=0
      loadct,40
      
      plot,UT,AE,position=[0.12,0.05,0.88,0.95],background=255,color=0,xstyle=1+4,xrange=[15,22],ystyle=1+4,yrange=[-90,50],/normal,/nodata
;      box_x_coords = [0.735, 0.735, 0.88, 0.88, 0.735]
;      box_y_coords = [0.05, 0.95, 0.95, 0.05,0.05]
;      Polyfill,box_x_coords,box_y_coords,Color=100,/Normal
       
       index=where(DST le -30)
       for i=0,n_elements(index)-1 do begin
       plots,[UT[index[i]],UT[index[i]]],[-90,50],thick=3,color=100
       endfor     
    
      plot,UT,Bx,position=[0.12,0.05,0.88,0.2],xstyle=1,ystyle=1,background=255,color=0,ytitle='B/nT',charsize=1.5
     
      oplot,UT,By,color=50
      oplot,UT,Bz,color=150
    
      plot,UT,v,position=[0.12,0.2,0.88,0.35],xstyle=1,ystyle=1,background=255,color=0,ytitle='v/(km/s)',charsize=1.5,xtickformat='(a1)'
      plot,UT,rou,position=[0.12,0.35,0.88,0.5],xstyle=1,ystyle=1,background=255,color=0,ytitle='rou/(n/cc)',charsize=1.5,xtickformat='(a1)'
      plot,UT,p,position=[0.12,0.5,0.88,0.65],xstyle=1,ystyle=1,background=255,color=0,ytitle='p/nPa',charsize=1.5,xtickformat='(a1)'
      plot,UT,AE,position=[0.12,0.65,0.88,0.8],xstyle=1,ystyle=1,background=255,color=0,ytitle='AE/nT',charsize=1.5,xtickformat='(a1)'
      plot,UT,DST,position=[0.12,0.8,0.88,0.95],xstyle=1,ystyle=1,background=255,color=0,ytitle='DST/nPa',charsize=1.5,xtickformat='(a1)'
      plots,[15,22],[-30,-30],color=240,linestyle=2
      
;      index=where(DST le 30)
;      UT[*]=UT[index]
;      row=n_elements(UT) 
;      for i=0,row-1 do begin
;         if 
;      endfor
      
  
    
    
      xyouts,0.20,0.92,'(a)',color=0,alignment=1.0,charsize=0.8,font=0,/normal
      xyouts,0.20,0.77,'(b)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      xyouts,0.20,0.62,'(c)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      xyouts,0.20,0.47,'(d)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      xyouts,0.20,0.32,'(e)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      xyouts,0.20,0.17,'(f)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      
      xyouts,0.94,0.18,'Bx',color=0,charsize=0.8,alignment=1.0,/normal
      xyouts,0.94,0.16,'By',color=50,charsize=0.8,alignment=1.0,/normal
      xyouts,0.94,0.14,'Bz',color=150,charsize=0.8,alignment=1.0,/normal
      
      
      device,/close_file
      Set_plot,entry_device

 
 end     
      
