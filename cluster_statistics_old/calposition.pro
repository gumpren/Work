Function calposition,x,y,xloc,yloc
  if  (x gt xloc) && (x le xloc+1) then dexb=1 else dexb=0
  if  (y gt yloc) && (y le yloc+1) then dexc=1 else dexc=0
  return,dexb*dexc
end