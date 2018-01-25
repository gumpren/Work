
Function return_thermal_energy_flow_density,pressure,velocityx,velocityy,velocityz,form
  if n_elements(form) eq 0 then form=1
  
  Re=6371.0
  Re_fac=(1.0e6*Re^2)/1.0e16
  
  index_p=where(~finite(pressure))
  index_vx=where(~finite(velocityx))
  index_vy=where(~finite(velocityy))
  index_vz=where(~finite(velocityz))
   
  if(index_p[0] ne -1) then pressure[index_p]=0
  if(index_vx[0] ne -1) then velocityx[index_vx]=0
  if(index_vy[0] ne -1) then velocityy[index_vy]=0
  if(index_vz[0] ne -1) then velocityz[index_vz]=0
  

;  thermal_EFD_x=2.5*10.0*(pressure[*,0,0]*velocityx+pressure[*,0,1]*velocityy+pressure[*,0,2]*velocityz)
;  thermal_EFD_y=2.5*10.0*(pressure[*,1,0]*velocityx+pressure[*,1,1]*velocityy+pressure[*,1,2]*velocityz)
;  thermal_EFD_z=2.5*10.0*(pressure[*,2,0]*velocityx+pressure[*,2,1]*velocityy+pressure[*,2,2]*velocityz)

  thermal_EFD_x=2.5*10.0*(pressure*velocityx)
  thermal_EFD_y=2.5*10.0*(pressure*velocityy)
  thermal_EFD_z=2.5*10.0*(pressure*velocityz)
;

  thermal_EFD=[[thermal_EFD_x],[thermal_EFD_y],[thermal_EFD_z]]   ;erg/(m^2*s)

  thermal_EFD_Re=thermal_EFD*Re_fac                         ;1.0e16*erg/(Re^2*s)
  
  case form of
    1:return,thermal_EFD
    2:return,thermal_EFD_Re
  endcase
end


;Function return_thermal_energy,pressure,velocity,index,x_pos,y_pos,eventimes
;  thermal_energy=dblarr(10,30)
;  for ii=-20,-11 do begin
;    for jj=-15,14 do begin
;      pressure[where(~finite(pressure))]=0
;      velocity[where(~finite(velocity))]=0
;      for kk=0,n_elements(index)-1 do begin
;        app=calposition((x_pos[index])[kk],(y_pos[index])[kk],ii,jj)
;        if(eventimes[ii+20,jj+15] ne 0)  then  thermal_energy[ii+20,jj+15]=thermal_energy[ii+20,jj+15]+2.5*(velocity[kk])*(pressure[kk])*app/eventimes[ii+20,jj+15]
;      endfor
;    endfor
;  endfor
;
;  return,thermal_energy
;
;end