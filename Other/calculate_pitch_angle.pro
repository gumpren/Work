pro calculate_pitch_angle,alpha,B,phi,theta,phi1,theta1,phi2,theta2

nopoints=n_elements(B[0,*])
phi=(findgen(361))*!pi/180.0 ;0-!pi*2
theta=fltarr(nopoints,361)  ;0-!pi
phi1=fltarr(nopoints)
theta1=fltarr(nopoints)
phi2=fltarr(nopoints)
theta2=fltarr(nopoints)
for ii=0,nopoints-1 do begin
	a_value=B[0,ii]*cos(phi)+B[1,ii]*sin(phi)
	b_value=B[2,ii]
	B_tot=sqrt(B[0,ii]^2+B[1,ii]^2+B[2,ii]^2)
	beta=atan(b_value/a_value)
	theta[ii,*]=asin(B_tot*cos(alpha*!pi/180.0)/sqrt(a_value^2+b_value^2))-beta
	theta[ii,*]=-((theta[ii,*] le 0.0)* (-90-theta[ii,*]*180.0/!pi)+(theta[ii,*] gt 0.0)* (90-theta[ii,*]*180.0/!pi)) ;-90~90
	xyz_to_polar,B[*,ii],magnitude=r,theta=lat,phi=lon
	phi1[ii]=lon
	theta1[ii]=lat
	phi2[ii]=(phi1[ii] lt 0.0)? (phi1[ii]+180.0):(phi1[ii]-180.0)
	theta2[ii]=-theta1[ii]
endfor
phi=phi*180.0/!pi-180
end