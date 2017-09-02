pro test_plot_vector
  ; Create data to contour.
  data = cgDemoData(2)
  dims = Size(data, /Dimensions)
  x = cgScaleVector(Findgen(dims[0]), 0, 6)
  y = cgScaleVector(Findgen(dims[1]), 0, 10)

  ; Create data to plot as vectors.
  xloc = Randomu(seed, 40) * 4 + 1
  yloc = Randomu(seed, 40) * 8 + 1
  u = Randomu(seed, 40) *2
  v = Randomu(seed, 40) * 2

  cgContour, data, x, y, NLevels=12, Position=[0.15, 0.15, 0.90, 0.85]
  PartVelVec, u, v, xloc, yloc, /Over, VecColor='red'

end