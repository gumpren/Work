pro plot_b_v_q
    
    restore,filepath('T_V_Q_H_K_x.sav',root_dir='C:\__Data\Datasave')
    H_scal=return_Q_v_T(Hx_Re,Vx,T)
    K_scal=return_Q_v_T(Kx_Re,Vx,T)
    Q_scal=return_Q_v_T(Qx_Re,Vx,T)
    Qtotal_scal=return_Q_v_T(QTOTAL_X_RE,Vx,T)

    entry_device=!d.name
    set_plot,'ps'
    device,/color,Bits_per_pixel=8.0
    TVLCT, r, g, b,/Get
    output_dir='E:\OneDrive\IDLworks\ps\kinetic analysis of energy flux density'
    device,filename=output_dir+'\T_V_Qtotal.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
    !p.multi=[0,2,2,0,0]
    loadct,39
    device,decomposed=0
    
    index1=where(Qtotal_scal eq 0)
    Qtotal_scal[index1]=!values.f_nan
;    index2=where(event_t2 eq 0)
;    event_t2[index2]=!values.f_nan
;    index3=where(event_t3 eq 0)
;    event_t3[index3]=!values.f_nan
;    index4=where(event_t4 eq 0)
;    event_t4[index4]=!values.f_nan

    top_flux=14
    bottom_flux=0.5


    ncolors=250
    bottom=0
    cgloadct,33,bottom=0,ncolors=ncolors
    scaled1=calculate_colors(alog10(Qtotal_scal),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    ; scaled4=calculate_colors(event_t4,bottom_flux,top_flux,Bottom,Ncolors)
;    scaled2=calculate_colors(alog10(event_t2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled3=calculate_colors(alog10(event_t3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled4=calculate_colors(alog10(event_t4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    scaled1[index1]=255
;    scaled2[index2]=255
;    scaled3[index3]=255
;    scaled4[index4]=255

    tv,scaled1,0.1,0.1,xsize=0.35,ysize=0.35,/normal
;    tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal

    colorbar_new,position=[0.5,0.1,0.52,0.3],ticklen=-0.3,color=0,NCOLORS=ncolors,$
      range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=0.6,/log

    loadct,39
    xl=findgen(10)
    yl=findgen(10)
    plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-400,0,400,800,1200,1600],xminor=2,xrange=[-400,1600],yrange=[10,70],yticks=6,yminor=6,yticklen=0.05,$
     ytickv=[10,20,30,40,50,60,70],position=[0.1,0.1,0.45,0.45],xtickname = NAMES, /NODATA,CHARSIZE=0.7,XTITLE='Vx(Km/s)',YTITLe='T(MK)',font=0
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;     position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;     position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
;     position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA

    xyouts,0.275,0.46,'Qtotal_x',color=0,alignment=0.5,charsize=1.0,font=0,/normal
    
    device,/close_file
    set_plot,entry_device

    stop
    
  end