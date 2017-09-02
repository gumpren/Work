  
  ;+
  ;Procedure:
  ;  Cluster_get_dist
  ;
  ;Purpose:
  ;  Returns 3D particle data structures containing CLUSTER CIS
  ;  data for use with spd_slice2d.
  ;
  ;Calling Sequence:
  ;  data = Cluster_get_dist(tname [,index] [,trange=trange] [,/times] [,/structure]
  ;                                [,probe=probe] [,species=species] )
  ;
  ;Input:
  ;  tname: Tplot variable containing the desired data.
  ;  index:  Index of time samples to return (supersedes trange)
  ;  trange:  Two element time range to constrain the requested data
  ;  times:  Flag to return full array of time samples
  ;  structure:  Flag to return a structure array instead of a pointer.
  ;
  ;  probe: specify probe if not present or correct in input_name
  ;  species:  specify species if not present or correct in input_name
  ;  units_name: PSD Def DF
  ;  integ_time: 4s spin default
  ;  dphi: default abs(phi[0]-phi[1])      deg
  ;  dtheta: default abs(theta[0]-theta[1]) deg
  ;Output:
  ;  return value: pointer to array of 3D particle distribution structures
  ;                or 0 in case of error
  ;
  ;Notes:
  ;add keywords:
  ;units_name integ_time dphi dtheta
  ;
  ;CHANGE LINE:
  ; var_info
  ; integ_time
  ;
  
  function Cluster_get_dist, tname, index, trange=trange, times=times, structure=structure, $
      species = species, probe = probe,units_name=units_name,integ_time=integ_time,dphi=dphi,$
      dtheta=dtheta
      
    compile_opt idl2, hidden
    
    name = (tnames(tname))[0]
    if name eq '' then begin
      dprint, 'Variable: "'+tname+'" not found'
      return, 0
    endif
    
    
    
    ;pull data and metadata
    get_data, name, ptr=p
    ;P={V1:PTR_NEW(energy_table),V1_IND:1,V2:PTR_NEW(theta),V2_IND:1,V3:PTR_NEW(phi),V3_IND:1,$
    ;  X:TIME_CIS,X_IND:1,Y:dist_data,Y_IND:1}
    
    if ~is_struct(p) then begin
      dprint, 'Variable: "'+tname+'" contains invalid data'
      return, 0
    endif
    
    if size(*p.y,/n_dim) ne 4 then begin
      dprint, 'Variable: "'+tname+'" d wrong number of elements'
      return, 0
    endif
    
    ;get info from tplot variable name
    var_info = STRLOWCASE(stregex(tname, 'cluster([1-4])_d([ei])s_dist', /subexpr, /extract))
    if var_info[0] eq '' then begin
      var_info[1] = (STRLOWCASE(stregex(tname, 'cluster([1-4])', /subexpr, /extract)))[1]
      IF STRPOS(tname,'dH1s') GE 0 THEN var_info[2]='H1'
      IF STRPOS(tname,'dHE1') GE 0 THEN var_info[2]='HE1'
      IF STRPOS(tname,'dHE2') GE 0 THEN var_info[2]='HE2'
      IF STRPOS(tname,'O1') GE 0 THEN var_info[2]='O1'
      var_info[0]='cluster'
    endif
    
    ;use info from the variable name if not explicitly set
    if var_info[0] ne '' then begin
      if ~is_string(probe) then probe = var_info[1]
      if ~is_string(species) then species = var_info[2]
    endif
    
    ;double check that required info is defined
    if ~is_string(probe) || ~is_string(species) then begin
      dprint, 'Cannot determine probe/species from variable name, please specify by kewword'
      return, 0
    endif
    
    ;return times
    ;calling code could use get_data but this allows for consistency with other code
    if keyword_set(times) then begin
      return, *p.x
    endif
    
    
    ; Allow calling code to request a time range and/or specify index
    ; to specific sample.  This allows calling code to extract
    ; structures one at time and improves efficency in other cases.
    ;-----------------------------------------------------------------
    
    ;index supersedes time range
    if undefined(index) then begin
      if ~undefined(trange) then begin
        tr = minmax(time_double(trange))
        index = where( *p.x ge tr[0] and *p.x lt tr[1], n_times)
        if n_times eq 0 then begin
          dprint, 'No data in time range: '+strjoin(time_string(tr),' ')
          return, 0
        endif
      endif else begin
        n_times = n_elements(*p.x)
        index = lindgen(n_times)
      endelse
    endif else begin
      n_times = n_elements(index)
    endelse
    
    
    ; Initialize angles, and support data
    ;-----------------------------------------------------------------
    
    ;dimensions
    ;data is stored as azimuth x elevation x energy x time
    ;time must be last for fields to be added to time varying structure array
    ;slice code expects energy to be the first dimension
    dim = (size(*p.y,/dim))[1:*]
    dim = dim[[2,0,1] ]
    base_arr = fltarr(dim)
    
    
    ;support data
    ;  -slice routines assume mass in eV/(km/s)^2
    case strlowcase(species) of
      'i': begin
        if undefined(integ_time) then integ_time=4.0
        mass = 1.04535e-2
        charge = 1.
        data_name = 'CIS Ion'
        integ_time = integ_time
      end
      'e': begin
        if undefined(integ_time) then integ_time=4.0
        mass = 5.68566e-06
        charge = -1.
        data_name = 'PEACE Electron'
        integ_time = integ_time
      end
      strlowcase('H1'):begin
      mass = 1.04535e-2
      charge = 1.
      data_name = 'CODIF H+'
      
    end
    strlowcase('HE1'):begin
    mass = 4.18138e-2
    charge = 1.
    data_name = 'CODIF He+'
    
  end
  strlowcase('HE2'):begin
  mass = 4.18138e-2
  charge = 2.
  data_name = 'CODIF He++'
  
end
strlowcase('O1'):begin
mass = 0.167255
charge = 1.
data_name = 'CODIF O+'

end
else: begin
  dprint, 'Cannot determine species'
  return, 0
endelse
endcase

;elevations are constant across time
;convert colat -> lat
theta = rebin( reform(90-*p.v2,[1,1,dim[2]]), dim );mms



;  dphi = replicate(22.5, dim)
;  dtheta = replicate(22.5, dim)
if undefined(dphi)|| undefined(dtheta) then begin
  dphi = replicate(abs(abs((*p.v2)[0])-abs((*p.v2)[1])), dim)
  dtheta = replicate(abs(abs((*p.v3)[0])-abs((*p.v3)[1])), dim)
endif else begin
  dphi = replicate(dphi, dim)
  dtheta = replicate(dtheta, dim)
endelse
; Create standard 3D distribution
;-----------------------------------------------------------------

;basic template structure that is compatible with spd_slice2d
template = {  $
  project_name: 'Cluster', $
  spacecraft: probe, $
  data_name: data_name, $
  units_name: 'f (s!U3!N/cm!U6!N)', $
  ;  units_name: 'df_cm', $
  units_procedure: '', $ ;placeholder
  species:species,$
  valid: 1b, $
  
  charge: charge, $
  mass: mass, $
  time: 0d, $
  end_time: 0d, $
  
  data: base_arr, $
  bins: base_arr+1, $ ;must be set or data will be considered invalid
  
  energy: base_arr, $
  denergy: base_arr, $ ;placeholder
  phi: base_arr, $
  dphi: dphi, $
  theta: theta, $
  dtheta: dtheta $
  }
  
dist = replicate(template, n_times)


; Populate
;-----------------------------------------------------------------
dist.time = (*p.x)[index]
dist.end_time = (*p.x)[index] + integ_time

;shuffle data to be energy-azimuth-elevation-time
dist.data = transpose((*p.y)[index,*,*,*],[3,1,2,0])

;get energy values for each time sample and copy into
;structure array with the correct dimensions
if size(/n_dim, *p.v1) eq 1 then begin
  e0 = *p.v1 ;fast data uses constant table
endif else begin
  e0 = reform( transpose((*p.v1)[index,*]), [dim[0],1,1,n_times])
endelse
dist.energy = rebin( e0, [dim,n_times] )

;get azimuth values for each time sample and copy into
;structure array with the correct dimensions
if size(/n_dim, *p.v3) eq 1 then begin
  phi0 = transpose(*p.v3) ;fast data uses constant table
endif else begin
  phi0 = reform( transpose((*p.v3)[index,*]), [1,dim[1],1,n_times])
endelse
dist.phi = rebin( phi0, [dim,n_times] )

;phi must be in [0,360)
dist.phi = dist.phi mod 360

;spd_slice2d accepts pointers or structures
;pointers are more versatile & efficient, but less user friendly
if keyword_set(structure) then begin
  return, dist
endif else begin
  return, ptr_new(dist,/no_copy)
endelse


end