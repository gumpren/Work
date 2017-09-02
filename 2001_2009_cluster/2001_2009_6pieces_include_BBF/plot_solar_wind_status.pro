pro plot_solar_wind_status
;0-8   (20040727,20050824)
    date='200508'    ;20040727 20050824
    filename1=file_search('C:\__Data\OMNI\*_'+date+'*.cdf')
    cdf2tplot,filename1,varformat=['BZ_GSM','BY_GSM','Vx','proton_density','T','Pressure','AE_INDEX','SYM_H']
    
    tstart=time_double('2005-08-23/12:00:00')
    tend=time_double('2005-08-26/12:00:00')
    
    
    plot_trange=[tstart,tend]
    
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_6pieces_include_BBF\littlev_largeh_events\'
    save_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\littlev_largeh_events'
    title_char='solar wind__'+time_string(tstart,format=2)+'_'+time_string(tend,format=2)
    
    ;timespan,time_string(time[0]),time[n_elements(time)-1]-time[0],/seconds
    init_crib_colors
    
    popen,output_dir+title_char,xsize=4.5,ysize=7.0,font=1,units='inches'
    tplot_options, 'font', 1
    tplot_options, 'charsize', 0.7
    tplot_options, 'xticklen', 0.05
    tplot_options, 'yticklen', 0.015
    tplot_options, 'zticklen', 0.3
    tplot_options, 'xgap', 0.3
    tplot_options, 'ygap', 0.8
    tplot_options, 'xmargin', [14,10]
    tplot_options, 'ymargin', [1,1]
    ; tplot_options, 'tickinterval', 60.*10.
    tplot_options,'y_no_interp',1
    time_stamp,/off
    ; options,'*',colors=[0,4,6]
    
    
    ;    tplot_options,'polyfill.tstart',time_string(tstart_shadow)
    ;    tplot_options,'polyfill.tend',time_string(tend_shadow)
    ;    tplot_options,'polyfill.color','grey'
    
    ;   tlimit, time[0], time[n_elements(time)-1]-time[0], /seconds
    
    options, 'BZ_GSM',ytitle='Bz(nT)',labflag=0
    options, 'BY_GSM',ytitle='By(nT)',labflag=-1
    options, 'Vx',ytitle='Vx(km/s)',labflag=-1
    options, 'proton_density',ytitle='Np(n/cc)',labflag=-1
    options, 'T',ytitle='T(K)',labflag=-1
    options, 'Pressure',ytitle='P(nPa)',labflag=-1
    options, 'AE_INDEX',ytitle='AE(nT)',labflag=-1  ;'H(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
    options, 'SYM_H',ytitle='SYM_H(nT)',labflag=-1
    
    tplot,['proton_density','T','Pressure','BY_GSM','BZ_GSM','Vx','AE_INDEX','SYM_H'],trange=plot_trange;,/polyfill
    
    
    pclose
    
    
    stop

end