;+
; :Description:
;    Describe the procedure.
;    cluster read and generate tplot names
;    CP_CIS_HIA_HS_MAG_IONS_PSD
;    CP_CIS_HIA_HS_SW_IONS_PSD
;
; :Params:
;    filename
;
; :Keywords:
;    units :'RC' 'CS' 'PEF' 'PF' 'PSD'
;    mode : SW(solar wind) MAG(Magnetospheric Mode) default MAG mode
;
; :Returns:
;
; :Author: yangjian-yangjian
;-
; :Bugs:
; just test DATA id:
; CP_CIS_HIA_HS_MAG_IONS_PSD
; CP_CIS_HIA_HS_SW_IONS_PSD
;
;  written at 8:22:04 2016-6-24
;  Email:yangjian615@buaa.edu.cn
;
function CLUSTER_GENERATE_CIS_HIA_DIST_TPLOTVAR,filename,probe=probe,units=units,mode=mode
  compile_opt idl2

  if undefined(probe) then probe='C1'
  
  if undefined(units) then units='PSD'
  units=STRUPCASE(units)
  
  if undefined(mode) then mode='MAG'
  mode=STRUPCASE(mode)
  IF STRPOS(filename,'MAG') GE 0 THEN mode='MAG'
  IF STRPOS(filename,'SW') GE 0 THEN mode='SW'
  
  cdf2tplot,filename,varformat='3d_ions__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units
  ;options,'3d_ions__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,LOG=byte(1),/DEFAULT
  ;options,'3d_ions__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,data_att={COORD_SYS:''},/DEFAULT
  ;;cdfi=cdf_load_vars(filename,VARFORMAT='*')
  get_data,'3d_ions__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,dl=dl
  
  
  loadcdf,filename,'time_tags__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,TIME_CIS
  loadcdf,filename,'energy_table__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,energy_table
  loadcdf,filename,'theta__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,theta   ;-90 ~90
  loadcdf,filename,'phi__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,phi       ;-180~180
  loadcdf,filename,'3d_ions__'+probe+'_CP_CIS-HIA_HS_'+mode+'_IONS_'+units,dist_data  ;TIME ENREGY PHI THETA
  
  TIME_CIS=time_double(TIME_CIS,/EPOCH)
  theta=90-[theta[0:3],theta[4:7]]
  
  phi=[phi[0:5],phi[6:13]+360,phi[14:15]]
  
  
  ;energy_table=reverse(energy_table)
  dist_data=TRANSPOSE(dist_data,[0,2,3,1]);time PHI THETA  ENREGY
  
  data_structure={V1:energy_table,V2:theta,V3:phi,X:TIME_CIS,Y:dist_data}
  store_data,'cluster1_dis_dist_'+units,data=data_structure,dl=dl
  
  return,'cluster1_dis_dist_'+units
end