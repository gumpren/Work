;Functio n return_kinetic_energy_x,density,velocityx,velocityy,index,x_pos,y_pos,eventimes
;  kinetic_ernegy=dblarr(10,30)
;  mass=1.6726e-27
;  for ii=-20,-11 do begin
;    for jj=-15,14 do begin
;      density[where(~finite(density))]=0
;      velocityx[where(~finite(velocityx))]=0
;      velocityy[where(~finite(velocityy))]=0
;      for kk=0,n_elements(index)-1 do begin
;        app=calposition((x_pos[index])[kk],(y_pos[index])[kk],ii,jj)
;        if(eventimes[ii+20,jj+15] ne 0)  then  kinetic_ernegy[ii+20,jj+15]=kinetic_ernegy[ii+20,jj+15]+0.5*mass*(density[kk])*((velocityx[kk])^2+(velocityy[kk])^2)*(velocityx[kk])*app/eventimes[ii+20,jj+15]
;      endfor
;    endfor
;  endfor
;
;  return,kinetic_ernegy
;end

Function return_kinetic_energy_flow_density,density,velocityx,velocityy,velocityz,form
  if n_elements(form) eq 0 then form=1
  
  mass=1.6726e-27
  Re=6371.0
  Re_fac=(1.0e6*Re^2)/1.0e16
  
  index_n=where(~finite(density))
  index_vx=where(~finite(velocityx))
  index_vy=where(~finite(velocityy))
  index_vz=where(~finite(velocityz))

  if(index_n[0] ne -1) then density[index_n]=0
  if(index_vx[0] ne -1) then velocityx[index_vx]=0
  if(index_vy[0] ne -1) then velocityy[index_vy]=0
  if(index_vz[0] ne -1) then velocityz[index_vz]=0
    
  v_total=sqrt((velocityx)^2+(velocityy)^2+(velocityz)^2)
        
  kinetic_EFD_x=0.5*1.0e22*mass*(density)*(v_total)*(v_total)*(velocityx)  ;erg/(m^2*s)
  kinetic_EFD_y=0.5*1.0e22*mass*(density)*(v_total)*(v_total)*(velocityy)
  kinetic_EFD_z=0.5*1.0e22*mass*(density)*(v_total)*(v_total)*(velocityz)
  
  kinetic_EFD=[[kinetic_EFD_x],[kinetic_EFD_y],[kinetic_EFD_z]]
  
  kinetic_EFD_Re=kinetic_EFD*Re_fac
  
  case form of
    1:return,kinetic_EFD
    2:return,kinetic_EFD_Re
  endcase
 
end
