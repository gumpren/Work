pro testtttt
  data_1 = randomn(-3L, 1000)
  data_2 = randomn(-5L, 1000) + 2

  ; To overlap the histogram plots, we have to specify the same ranges
  ; for both the plots. Here we gather information we need to do so.
  ; Be VERY careful to make the binsize variable the same data type as the data!
  binsize = 0.25
  h1 = Histogram(data_1, Binsize=binsize)
  h2 = Histogram(data_2, Binsize=binsize)
  min_xrange = Floor(Min(data_1) < Min(data_2))
  max_xrange = Ceil(Max(data_1) > Max(data_2))
  xrange = [min_xrange, max_xrange]
  ymax = Max(h1) > Max(h2)
  yrange = [0, ymax + (0.05*ymax)]

  ; The way we are going to do transparency is with images. We are
  ; going to create two 24-bit images and blend them. Since we can't
  ; get these images in PostScript, we are going to do this in the
  ; Z-graphic buffer.
  IF (Total(!P.Position) EQ 0) $
    THEN position = [0.125, 0.125, 0.9, 0.9] $
  ELSE position = !P.Position
  cgDisplay, 640, 512
  thisDevice = !D.Name
  Set_Plot, 'Z'
  Device, Set_Resolution=[640,512], Decomposed=1, Set_Pixel_Depth=24

  ; Create the first plot. Draw 2nd Histoplot first.
  cgErase
  cgHistoplot, data_2, POLYCOLOR='olive', /FILL, YRANGE=yrange, $
    XRANGE=xrange, BINSIZE=binsize, POSITION=position
  cgHistoplot, data_1, POLYCOLOR='yellow', /FILL, /OPLOT, BINSIZE=binsize

  ; Take a picture of the inside of the plot region.
  start_x = Round(position[0] * !D.X_Size)
  start_y = Round(position[1] * !D.Y_Size)
  end_x = Round(position[2] * !D.X_Size)
  end_y = Round(position[3] * !D.Y_Size)
  xsize = end_x - start_x
  ysize = end_y - start_y

  ; Grab the first image.
  firstImage = cgSnapshot(start_x, start_y, xsize, ysize)

  ; Do the same thing for the second image, but reverse the order of
  ; the histogram plots.
  cgErase
  cgHistoplot, data_1, POLYCOLOR='yellow', /FILL, YRANGE=yrange, $
    XRANGE=xrange, BINSIZE=binsize, POSITION=position
  cgHistoplot, data_2, POLYCOLOR='olive', /FILL, /OPLOT, BINSIZE=binsize
  secondImage = cgSnapshot(start_x, start_y, xsize, ysize)

  ; Leave the Z-buffer and carry on.
  Set_Plot, thisDevice

  ; Display the blendedImage.
  cgBlendimage, firstImage, secondImage, Position=position, XRange=xrange, $
    YRange=yrange, /Axes, YTitle='Histogram Density', XTitle='Value'

end