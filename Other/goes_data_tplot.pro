pro goes_data_tplot

   date='2012-10-31'
   timespan,date+'/15:30:00',1.,/hour
   ;goes_overview_plot, date = date, probe = '13'
   ;goes_overview_plot, date = date, probe = '14'
   ;goes_overview_plot, date = date, probe = '15'
   
   popen,'E:\GOES\Overview_'+date,xsize=6,ysize=4.5,font=0,units='inches'
   ztickname=['10!u-3!n!x','10!u-2!n!x','10!u-1!n!x']
   thm_init
   tplot_options, 'font', 0
   tplot_options, 'charsize', 0.7
   tplot_options, 'xticklen', 0.05
   tplot_options, 'yticklen', 0.015
   tplot_options, 'zticklen', 0.3
   tplot_options, 'xgap', 0.3
   tplot_options, 'ygap', 0.4
   tplot_options, 'xmargin', [1,1]
   tplot_options, 'ymargin', [1,1]
   tplot_options, 'tickinterval', 60.*10.
   tplot_options,'y_no_interp',1
   time_stamp,/off

   options, ['*_pos_mlt','*L_shell'],'format','(f5.2)'
   tplot_options,'title',' '
   options, '*', 'ytitle',' '
   options, '*L_shell', 'ytitle','L'
   options, '*_pos_mlt', 'ytitle','MLT'
   options, '*_H_sm', 'ytitle','B!dSM!n!x [nT]'
   options, '*_maged_dtc_cor_omni_flux', 'ytitle','Flux [#/cm!u2!n!x-s-sr-keV]'
   options, '*_elec_uncor_comb_flux', 'ytitle','Flux [#/cm!u2!n!x-s-sr]'
   options, '*', 'ysubtitle',' '

   prefix='g13'
   goes_pitch_angles, prefix+'_H_enp_1', prefix+'_HT_1', prefix = prefix

   tplot_options,'region',[0.,0.,0.41,1.0]
   tplot_options,'noerase',1
   options, prefix+'_H_sm', 'title','GOES-13 Overview'
   options, prefix+'_H_sm', 'labels',' '
   options, prefix+'_maged_dtc_cor_omni_flux', 'labels',' '
   options, prefix+'_elec_uncor_comb_flux', 'labels',' '
   tplot, [prefix+'_H_sm',$
          prefix+'_maged_dtc_cor_omni_flux',$
          prefix+'_elec_uncor_comb_flux'],$
          var_label=[prefix+'_pos_mlt',prefix+'_L_shell'],get_plot_position=pos,trange=timerange()
   ;xyouts,pos[0,*]+0.04,pos[3,*]-0.03,['Er','Ea','Ep','Br','Ba','Bp'],/norm,charsize=0.8,color=220

   prefix='g15'
   goes_pitch_angles, prefix+'_H_enp_1', prefix+'_HT_1', prefix = prefix

   tplot_options,'region',[0.54,0.,0.95,1.0]
   tplot_options,'noerase',1
   tplot_options,'no_color_scale',0
   options, prefix+'_H_sm', 'title','GOES-15 Overview'
   options, prefix+'_elec_uncor_comb_flux', 'labels',['>0.6 MeV','>2 MeV','>4 MeV']

   tplot, [prefix+'_H_sm',$
          prefix+'_maged_dtc_cor_omni_flux',$
          prefix+'_elec_uncor_comb_flux'],$
          var_label=[prefix+'_pos_mlt',prefix+'_L_shell'],get_plot_position=pos,trange=timerange()
   ;xyouts,pos[0,*]+0.58,pos[3,*]-0.03,['Er','Ea','Ep','Br','Ba','Bp'],/norm,charsize=0.8,color=220
   pclose
   
end

