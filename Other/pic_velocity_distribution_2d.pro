pro pic_velocity_distribution_2d   ;,filename,satellitename,element,x0,x1,y0,y1,tickname,BOTTOM=bottom


;�� ����λ��+�ܶ� �ļ�,��������

file='F:\pic\H_O_R_velocity\velocity_distribution_2D.txt'

openr,lun,file,/get_lun
x_div=20
y_div=40
H_Vx=fltarr(x_div,y_div)
H_Vy=fltarr(x_div,y_div)
O_Vx=fltarr(x_div,y_div)
O_Vy=fltarr(x_div,y_div)

readf,lun,H_Vx
readf,lun,H_Vy
readf,lun,O_Vx
readf,lun,O_Vy
free_lun,lun

vector_H=fltarr(x_div,y_div)
vector_O=fltarr(x_div,y_div)
vector_H(*,*)=sqrt(H_Vx(*,*)^2+H_Vy(*,*)^2)
vector_O(*,*)=sqrt(O_Vx(*,*)^2+O_Vy(*,*)^2)
max_H=max(vector_H)
max_O=max(vector_O)
length_H=5.0
length_O=length_H*(max_O/max_H)
print,max_H

;xy������

x=findgen(x_div)
y=findgen(y_div)
x(*)=-x(*)-0.5
y(*)=19.5-y(*)

;ȥ��0��
    for i=0,x_div-1 do begin
    for j=0,y_div-1 do begin
         if H_Vx[i,j] eq 0 then begin
            H_Vx[i,j]=1001
         endif
         if H_Vy[i,j] eq 0 then begin
            H_Vy[i,j]=1001
         endif
         if O_Vx[i,j] eq 0 then begin
            O_Vx[i,j]=1001
         endif
         if O_Vy[i,j] eq 0 then begin
            O_Vy[i,j]=1001
         endif
    endfor
    endfor
;���ܶ�     ��ά�ֲ�ͼ

entry_device=!d.name                 ;����ϵͳ����!d.name�洢�ĵ�ǰ�豸���豸����
set_plot,'ps'                        ;�ѵ�ǰ�豸����Ϊ��.ps����ʽ��ͼ���ļ�
device,/color,bits_per_pixel=8       ;device����Ĺؼ�������ͼ���豸������


TVLCT, r, g, b, /Get                 ;��ȡ�Ѿ����ڵ���ɫ��
device,filename='F:\pic\H_O_R_velocity\velocity_distribution_2D.ps'   ;,xsize=4.2,ysize=4.8,xoffset=1,yoffset=2,/inches,/encapsulated


!p.multi=[0,2,1,0,0]
loadct,39

x0=0.15 & y0=0.55 & x1=0.45 & y1=0.97


     VELOVECT,H_Vx,H_Vy,X,Y,COLOR=0,MISSING=1000,LENGTH=length_H,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
          position=[x0,y0,x1,y1],background=255,/noerase,/nodata,$
          xticks=4,xminor=5,xtickname=['0','-5','-10','-15','-20'],xrange=[0,-20],$;
          xtitle='X!DGSM!N(R!DE!N)',yrange=[20,-20],$;
          ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8




     VELOVECT,O_Vx,O_Vy,X,Y,COLOR=0,MISSING=1000,LENGTH=length_O,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
          position=[x0+0.45,y0,x1+0.45,y1],background=255,/noerase,/nodata,$
          xticks=4,xminor=5,xtickname=['0','-5','-10','-15','-20'],xrange=[0,-20],$;
          xtitle='X!DGSM!N(R!DE!N)',yrange=[20,-20],$;
          ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8



;xyouts,x0+0.02,y1-0.03,'(!3f!X) C1',color=0,/normal,charsize=0.8,font=0


device,/close_file                        ; �ر�PostScript�ļ�plotting_filename.ps
Set_plot,entry_device                     ; �ָ�ԭ�豸entry_device




end