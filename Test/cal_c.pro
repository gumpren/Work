pro cal_c
   cgdisplay
   x=findgen(10)
   cgplot,x,30*(1.05^x-1),color='royal blue'
   cgoplot,x,1.14387*(x+1),color='red'
   stop



end