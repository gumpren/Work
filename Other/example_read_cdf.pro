pro example_read_cdf

cdf_file='D:\__Data\OMNI\omni_hro_1min_20030101_v01.cdf'
;cdf_file='E:\MyWorkSpace\Data\rbspa_efw-l3_20121031_v01.cdf'
;cdf_file='E:\MyWorkSpace\Data\RBSP\EMFISIS\rbsp-a_magnetometer_4sec-gse_emfisis-L3_20121031_v1.3.2.cdf'
data=loadcdf_all_variable(cdf_file,g_attributes=g_attributes,atts=atts,var_structure=var_structure,_extra=extra_)

end