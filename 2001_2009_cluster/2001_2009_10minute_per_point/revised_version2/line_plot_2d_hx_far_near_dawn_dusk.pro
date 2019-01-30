;+
; :Author: Gren
;-

pro line_plot_2d_hx_far_near_dawn_dusk
  h_Factor=1.0/(6.371^2*1.0e3)

  ;1W/m^2=6.371^2*1.0e3(1.0e15*erg/(Re^2*s))

  region_strs=['','_dawnflank','_duskflank','_near_dawnflank','_far_dawnflank','_near_duskflank','_far_duskflank']

  ;  ;region_str=region_strs[4]
  namestr=''
  ;  ;typee=1; dawn
  ;  typee=2; dusk
  ;  case (typee) of
  ;    1: begin
  ;         aa=0
  ;         region_s=region_strs[1]
  ;       end
  ;    2: begin
  ;         aa=1
  ;         region_s=region_strs[2]
  ;       end
  ;  endcase



  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_10minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_10minute_per_point\revised_version2_remove_duplicate_points\'


  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[3]+'.sav'
  vari_near_dawn=H_Re
  tt_dawn=t_last

  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[4]+'.sav'
  vari_far_dawn=H_Re
  tt_dusk=t_last

  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[5]+'.sav'
  vari_near_dusk=H_Re
  tt_dusk=t_last

  restore,filename=root_dir+namestr+'remove_duplicate_points_raw_data'+save_str+'_list_10minute_per_point'+region_strs[6]+'.sav'
  vari_far_dusk=H_Re
  tt_dusk=t_last

  title_char=namestr+'hx_separate_far_near_flank_remove_duplicate_points_line_plot_2d'

  x=10*(indgen(15))+5

  median_vari_near_dawn_north=dblarr(15)
  median_vari_far_dawn_north=dblarr(15)
  median_vari_near_dusk_north=dblarr(15)
  median_vari_far_dusk_north=dblarr(15)

  median_vari_near_dawn_south=dblarr(15)
  median_vari_far_dawn_south=dblarr(15)
  median_vari_near_dusk_south=dblarr(15)
  median_vari_far_dusk_south=dblarr(15)


  average_vari_near_dawn_north=dblarr(15)
  average_vari_far_dawn_north=dblarr(15)
  average_vari_near_dusk_north=dblarr(15)
  average_vari_far_dusk_north=dblarr(15)

  average_vari_near_dawn_south=dblarr(15)
  average_vari_far_dawn_south=dblarr(15)
  average_vari_near_dusk_south=dblarr(15)
  average_vari_far_dusk_south=dblarr(15)

  ; restore,filename='C:\__Data\Datasave\2001_2009_10minute_per_point\earthward_flow_index.sav'

  for i=0,14 do begin

    if ( (size(vari_near_dawn[i]))[0] eq 1)  then begin

      vari_near_dawn_north=get_varii(vari_near_dawn[i],log=0)
      vari_far_dawn_north=get_varii(vari_far_dawn[i],log=0)
      vari_near_dusk_north=get_varii(vari_near_dusk[i],log=0)
      vari_far_dusk_north=get_varii(vari_far_dusk[i],log=0)

      vari_near_dawn_south=get_varii(vari_near_dawn[i+15],log=0)
      vari_far_dawn_south=get_varii(vari_far_dawn[i+15],log=0)
      vari_near_dusk_south=get_varii(vari_near_dusk[i+15],log=0)
      vari_far_dusk_south=get_varii(vari_far_dusk[i+15],log=0)

    endif

    if ( (size(vari_near_dawn[i]))[0] eq 2)  then begin

      vari_near_dawn_north=get_varii((vari_near_dawn[i])[*,0],log=0)
      vari_far_dawn_north=get_varii((vari_far_dawn[i])[*,0],log=0)
      vari_near_dusk_north=get_varii((vari_near_dusk[i])[*,0],log=0)
      vari_far_dusk_north=get_varii((vari_far_dusk[i])[*,0],log=0)

      vari_near_dawn_south=get_varii((vari_near_dawn)[i+15],log=0)
      vari_far_dawn_south=get_varii((vari_far_dawn)[i+15],log=0)
      vari_near_dusk_south=get_varii((vari_near_dusk)[i+15],log=0)
      vari_far_dusk_south=get_varii((vari_far_dusk)[i+15],log=0)

    endif


    ;    vari_dawn_north=vari_dawn_north[(idx_dawn_north_gt0[i])]
    ;    vari_dawn_south=vari_dawn_south[(idx_dawn_south_gt0[i])]
    ;    vari_dusk_north=vari_dusk_north[(idx_dusk_north_gt0[i])]
    ;    vari_dusk_south=vari_dusk_south[(idx_dusk_south_gt0[i])]
    ;
    median_vari_near_dawn_north[i]=median(vari_near_dawn_north)
    median_vari_far_dawn_north[i]=median(vari_far_dawn_north)
    median_vari_near_dusk_north[i]=median(vari_near_dusk_north)
    median_vari_far_dusk_north[i]=median(vari_far_dusk_north)

    median_vari_near_dawn_south[i]=median(vari_near_dawn_south)
    median_vari_far_dawn_south[i]=median(vari_far_dawn_south)
    median_vari_near_dusk_south[i]=median(vari_near_dusk_south)
    median_vari_far_dusk_south[i]=median(vari_far_dusk_south)


    average_vari_near_dawn_north[i]=average(vari_near_dawn_north,/nan)
    average_vari_far_dawn_north[i]=average(vari_far_dawn_north,/nan)
    average_vari_near_dusk_north[i]=average(vari_near_dusk_north,/nan)
    average_vari_far_dusk_north[i]=average(vari_far_dusk_north,/nan)

    average_vari_near_dawn_south[i]=average(vari_near_dawn_south,/nan)
    average_vari_far_dawn_south[i]=average(vari_far_dawn_south,/nan)
    average_vari_near_dusk_south[i]=average(vari_near_dusk_south,/nan)
    average_vari_far_dusk_south[i]=average(vari_far_dusk_south,/nan)


    ;    append_Array,vari_dawn_north1,vari_dawn_north
    ;    append_Array,vari_dawn_south1,vari_dawn_south
    ;    append_Array,vari_dusk_north1,vari_dusk_north
    ;    append_Array,vari_dusk_south1,vari_dusk_south
    ;
    ;    append_Array,tt_dawn_north,tt_dawn[i]
    ;    append_Array,tt_dawn_south,tt_dawn[i+15]
    ;    append_Array,tt_dusk_north,tt_dusk[i]
    ;    append_Array,tt_dusk_south,tt_dusk[i+15]


  endfor

  ;  tt_arr=hash()
  ;  tt_arr[0,0]=tt_dawn_north   &    tt_arr[0,1]=tt_dawn_south
  ;  tt_arr[1,0]=tt_dusk_north   &    tt_arr[1,1]=tt_dusk_south

  ;  vari_arr=hash()
  ;  vari_arr[0,0]=vari_dawn_north1   &    vari_arr[0,1]=vari_dawn_south1
  ;  vari_arr[1,0]=vari_dusk_north1   &    vari_arr[1,1]=vari_dusk_south1

  ; if ((vari_str eq 'H!dx!n' or vari_str eq 'K!dx!n')eq 1b)  then median_vari_dusk_south[11]=!values.f_nan
  median_arr=hash()
  median_arr[0,0]=median_vari_near_dawn_north
  median_arr[1,0]=median_vari_far_dawn_north
  median_arr[2,0]=median_vari_near_dusk_north
  median_arr[3,0]=median_vari_far_dusk_north

  median_arr[0,1]=median_vari_near_dawn_south
  median_arr[1,1]=median_vari_far_dawn_south
  median_arr[2,1]=median_vari_near_dusk_south
  median_arr[3,1]=median_vari_far_dusk_south


  average_arr=hash()
  average_arr[0,0]=average_vari_near_dawn_north
  average_arr[1,0]=average_vari_far_dawn_north
  average_arr[2,0]=average_vari_near_dusk_north
  average_arr[3,0]=average_vari_far_dusk_north

  average_arr[0,1]=average_vari_near_dawn_south
  average_arr[1,1]=average_vari_far_dawn_south
  average_arr[2,1]=average_vari_near_dusk_south
  average_arr[3,1]=average_vari_far_dusk_south


  ;  title_arr=[['N-IMF Dawnflank','N-IMF Duskflank'],$
  ;             ['S-IMF Dawnflank','S-IMF Duskflank']]


  ; median_smooth_arr=smooth_hkx_line_data(median_Arr) ;,/nan_12
  ; if keywordset nan_12  the 12th vaule in duskflank would be nan

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,2,left=0.07,right=0.95,xgap=0.06,ygap=0.06,low=0.05,high=0.60)
  ;cgdisplay

  str_element,opt_plot,'charsize',1.0,/add
  str_element,opt_plot,'color',black,/add
  str_element,opt_plot,'yticks',yticks,/add
  ; str_element,opt_plot,'ytickname',ytickname,/add
  str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/add
  str_element,opt_plot,'ytitle','H'+cgsymbol('down')+'x'+'!n (10!u16!n!xergs!u-1!n!xRe!u2!n!x)',/add
  ; str_element,opt_plot,'xtickformat','(a1)',/add

  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yminor',9,/add
  str_element,opt_plot,'thick',4,/add

  str_element,opt_plot,'ylog',1,/add
  str_element,opt_plot,'xrange',[0.0,150.0],/add
  str_element,opt_plot,'yrange',[0.01,1.0],/add  ;
  title_arr=['near-dawn','far-dawn','near-dusk','far-dusk']
  ;       dawn     ,      dusk

  ;      if i ne 1 then begin
  ;        str_element,opt_plot,'xtickformat','(a1)',/add
  ;        str_element,opt_plot,'xtitle',/delete
  ;      endif else begin
  ;        str_element,opt_plot,'xtickformat',/delete
  ;        str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/add
  ;      endelse
  for j=0,3 do begin

    if j eq 0  or j eq 2 or j eq 3 then begin
      str_element,opt_plot,'ytitle','H'+cgsymbol('down')+'x'+'!n (10!u16!n!xergs!u-1!n!xRe!u2!n!x)',/delete
    endif

    if j eq 0  or j eq 2 or j eq 3 then begin
      str_element,opt_plot,'xtitle',cgsymbol('Delta')+'t '+'(minutes)',/delete
      str_element,opt_plot,'xtickformat','(a1)',/delete
    endif


    if j eq 0 then pos11=pos[0,0,*]
    if j eq 1 then pos11=pos[0,1,*]
    if j eq 2 then pos11=pos[1,0,*]
    if j eq 3 then pos11=pos[1,1,*]

    ;  cgplot,tt_arr[i,j],alog(vari_arr[i,j]),pos=pos[i,j,*],color='grey',psym=3,ylog=ylog,xrange=xrange,yrange=yrange,/normal,/noerase,_extra=opt_plot
    cgplot,x,median_arr[j,0],pos=pos11,/normal,/noerase,_extra=opt_plot,linestyle=0
    cgoplot,x,median_arr[j,1],pos=pos11,/normal,/noerase,_extra=opt_plot,linestyle=2

    ;  cgoplot,x,alog10(average_arr[i,j]),xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,ylog=ylog,yrange=yrange

    ;     cgplot,x,median_smooth_arr[i,0],pos=pos[i,0,*],xrange=xrange,color='red',/normal,/noerase,_extra=opt_plot,yrange=yrange
    ;     cgoplot,x,median_smooth_arr[i,1],pos=pos[i,0,*],xrange=xrange,color='blue',/normal,/noerase,_extra=opt_plot,yrange=yrange
    ;     ;
    ;     cgoplot,x,average_arr[i,j],xrange=xrange,color='royal blue',/normal,/noerase,_extra=opt_plot,yrange=yrange

    labels_stamp,pos11,title_arr[j],charsize=1.0,/left_right_center,/up_out
  endfor


  ;  cgtext,0.98,0.88,'median',alignment=0,charsize=1.0,font=0,color='red',/normal
  ;  cgtext,0.98,0.85,'average',alignment=0,charsize=1.0,font=0,color='royal blue',/normal         Location=[0.48, 0.409],
  ;  cgLegend, Colors=['black', 'black'], linestyle=[0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.55], $
  ;       Titles=['N-IMF','S-IMF'], Length=0.075, VSpace=1.0, /Background, $
  ;       BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15]
  ;
  cgLegend, Colors=['black', 'black'], linestyle=[0,2],alignment=1,charsize=0.8, Symsize=0.4, Location=[0.48, 0.25], $
    Titles=['N-IMF','S-IMF'], Length=0.075, VSpace=1.0, /Background, $
    BG_Color='white',visible=1, /AddCmd   ;, /Box, PSyms=[6,15]

  cgps_close


  stop


end