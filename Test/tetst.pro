pro tetst
  restore,'C:\__Data\Datasave\2001_2009_median\OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav'
  restore,'C:\__Data\Datasave\2001_2009_median\C3_CIS_2001_2009_n_vbxyz_p_T_need.sav'
  restore,'C:\__Data\Datasave\2001_2009_median\time_need_omni_to_c3fgm_2001_2009.sav
  
  time_c3cis.time_c3cis3=time_c3cis.time_c3cis3[1:23469]
  density.density3=density.density3[1:23469]
  pressure.pressure3=pressure.pressure3[1:23469]
  temperature.temperature3=temperature.temperature3[1:23469]
  vbx.vbx3=vbx.vbx3[1:23469]
  vby.vby3=vby.vby3[1:23469]
  vbz.vbz3=vbz.vbz3[1:23469]
  
  t_omni_to_fgm=create_struct('t_omni_to_fgm1',t_omni_to_fgm1,'t_omni_to_fgm2',t_omni_to_fgm2,'t_omni_to_fgm3',t_omni_to_fgm3,'t_omni_to_fgm4',t_omni_to_fgm4)
  t_fgm_to_cis=create_struct('t_fgm_to_cis1',t_fgm_to_cis1,'t_fgm_to_cis2',t_fgm_to_cis2,'t_fgm_to_cis3',t_fgm_to_cis3,'t_fgm_to_cis4',t_fgm_to_cis4)
  t_cis_to_fgm=create_struct('t_cis_to_fgm1',t_cis_to_fgm1,'t_cis_to_fgm2',t_cis_to_fgm2,'t_cis_to_fgm3',t_cis_to_fgm3,'t_cis_to_fgm4',t_cis_to_fgm4)
  
  stop
end