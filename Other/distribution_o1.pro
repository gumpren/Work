pro distribution_O1

  compile_opt idl2
  file_dir='C:\Users\ccvok\Desktop\Oxygen_Flux_Enhancement\'
  date='2001-10-11'
  tseries=[['04:47:35','04:47:28','04:47:35','04:47:28'],$
    ['04:47:35','04:47:28','04:47:35','04:47:28'],$
    ['04:47:35','04:47:28','04:47:35','04:47:28']]
  satellite=['C1','C3','C4']
  panel=[['(a)','(b)','(c)','(d)'],['(e)','(f)','(g)','(h)'],['(i)','(j)','(k)','(l)']]

  tpoints=time_double(date+'/'+tseries)
  
  symsize=0.8
  ;; set Y label parameters
  ytitle=['C1_Elevation','C3_Elevation','C4_Elevation']
  min_value=intarr(4,3)+3
  max_value=intarr(4,3)+6
  yrange=[-90,90]
  ylog=0
  yticks=4
  yminor=4
  ytickv=[-80,-40,0,40,80]
  ytickname=['-80','-40','0','40','80']

  file=file_dir+'O1_distributionBisr2.txt'

  openr,lun,file,/get_lun
  B_isr2=fltarr(3,12)
  readf,lun,B_isr2
  free_lun,lun

  ;; set X label parameters
  xrange=[-180,180]
  xticks=4
  xminor=3
  xtickv=[-180,-90,0,90,180]
  xtickname=['-180','-90','0','90','180']
  
  title_colorbar='!cParticle Flux [#/cm!u2!n!x-s-sr-eV]'
  ;; set drawing parameters
  Bottom=0 & Ncolors=251
  cgloadct,33,Bottom=Bottom,NColors=Ncolors
  dims=dimen(tseries)
  pho_row=dims[1]
  pho_column=dims[0]
  x0=0.12 & y0=0.08
  x1=0.92 & y1=0.98
  delx=0.03 & dely=0.09
  dy=(y1-y0-(pho_row-1)*dely)/pho_row & dx=(x1-x0-(pho_column-1)*delx)/pho_column
  !p.charsize=0.6
  !p.charthick=1.0
  !p.ticklen=0.2
  !x.ticklen=0.05
  !y.ticklen=0.02
  figurename=file_dir+'distribution_O1_fluxrope_new.ps'
  cgps_open,figurename,xsize=8,ysize=4.5,xoffset=1,yoffset=1,/inches,/encapsulated
  alpha0=90
  
  for row=0,pho_row-1 do begin  ;;satellite
    sc=satellite[row]
    ;cdffile=file_search(file_dir+'DF\CAA\'+sc+'_CP_FGM_5VPS\*.cdf')  ;B
    ;cdf2tplot,cdffile,varformat='B_vec_xyz_gse__'+sc+'_CP_FGM_5VPS'
    cdffile=file_search(file_dir+'DF\CAA\'+sc+'_CP_CIS-CODIF_HS_O1_PF\*.cdf')  ;3d ions flux
    cdf2tplot,cdffile,varformat='3d_ions__'+sc+'_CP_CIS-CODIF_HS_O1_PF'
    for column=0,pho_column-1 do begin  ;;time
      print,column,row
      ;tinterpol_mxn,'B_vec_xyz_gse__'+sc+'_CP_FGM_5VPS',reform(tpoints[*,row]),newname='B_interp',/nearest_neighbor
      ;get_data,'B_interp',t,B
      tinterpol_mxn,'3d_ions__'+sc+'_CP_CIS-CODIF_HS_O1_PF',reform(tpoints[*,row]),newname='3d_ions_interp',/nearest_neighbor
      get_data,'3d_ions_interp',t,ions_3d_flux,dl=dl
      ;ions_3d_flux=dat.y
      get_data,'3d_ions__'+sc+'_CP_CIS-CODIF_HS_O1_PF',data=dat,dl=dl
      theta=dat.v1
      phi=reverse(shift(dat.v2,-6))
      flux=reverse(shift(total(reform(ions_3d_flux[column,*,*,*]),1,/nan),-6,0))
      x_title=(row eq pho_row-1)? cgsymbol('phi')+' [deg]':''
      y_title=(column eq 0)? cgsymbol('theta')+' [deg]':''
      calculate_pitch_angle,alpha0,B_isr2[*,row*4+column],phi0,theta0,phi1,theta1,phi2,theta2
      logflux=alog10(flux)
      scaledflux=bytscl(logflux,min=min_value[column,row],max=max_value[column,row],top=ncolors-1,/nan)
      index=where(finite(logflux) eq 0)
      scaledflux[index]=255
      axis_format={ylog:ylog,xrange:xrange,xticks:xticks,xminor:xminor,xtickv:xtickv,xtickname:'',$
        xtitle:x_title,yrange:yrange,yticks:yticks,yminor:yminor,ytickv:ytickv,$
        ytickname:ytickname,ytitle:y_title,title:sc+'  '+time_string(tpoints[column,row])}
      cgimage,scaledflux,axkeyword=axis_format,/noerase,/axes,/normal,$
        position=[x0+column*(dx+delx),y0+(pho_row-1-row)*(dy+dely),x0+column*(dx+delx)+dx,y0+(pho_row-1-row)*(dy+dely)+dy]
        
      cgoplot,phi0,theta0,color='black'
      cgoplot,phi1,theta1,color='red',psym=cgsymcat('filled circle'),symsize=symsize
      cgoplot,phi2,theta2,color='red',psym=cgsymcat('Asterisk'),symsize=symsize

      IF column eq pho_column-1 then $
        cgcolorbar,position=[x0+column*(dx+delx)+dx+0.02,y0+(pho_row-1-row)*(dy+dely),x0+column*(dx+delx)+dx+0.045,y0+(pho_row-1-row)*(dy+dely)+dy],$
        range=[min_value[row],max_value[row]],bottom=bottom,ncolors=ncolors,$
        title=title_colorbar,minor=1,tickinterval=1.0,/vertical,/right

      cgtext,x0+column*(dx+delx)+0.015,y0+(pho_row-1-row)*(dy+dely)+0.025,panel[column,row],charsize=0.8,charthick=Charthick,color='black',/normal
    endfor

  endfor
  cgps_close
end

