pro test_list
  n = 1000L
  cat_times = fltarr(n) + !values.f_nan
  list_times = fltarr(n) + !values.f_nan
  arraylist_times = fltarr(n) + !values.f_nan

  ; time new list object adding
  print, 'Starting list timing...'
  b = list()
  for i = 0L, n - 1L do begin
    t0 = systime(/seconds)
    for j = 0L, n - 1L do begin
      b->add, 1.0
    endfor
    list_times[i] = systime(/seconds) - t0
  endfor

  ; time MGcoArrayList adding
  print, 'Starting MGcoArrayList timing...'
  c = obj_new('MGcoArrayList', type=4)
  for i = 0L, n - 1L do begin
    t0 = systime(/seconds)
    for j = 0L, n - 1L do begin
      c->add, 1.0
    endfor
    arraylist_times[i] = systime(/seconds) - t0
  endfor

  ; time array concatenation
  print, 'Starting array concatenation timing...'
  a = []
  for i = 0L, 2 * n / 10 - 1L do begin
    t0 = systime(/seconds)
    for j = 0L, n - 1L do begin
      a = [a, 1.0]
    endfor
    cat_times[i] = systime(/seconds) - t0
  endfor

  ccat_times = total(cat_times, /cumulative)
  clist_times = total(list_times, /cumulative)
  carraylist_times = total(arraylist_times, /cumulative)

  xpad = 15000
  ypad = 0.4
  mult = 1.5
  charsize = 0.75 * mult

  vis_psbegin, filename='concatenation.ps'
  !p.font = 0
  vis_window, xsize=4.5 * mult, ysize=1.5 * mult, /inches

  vis_decomposed, 1, old_decomposed=odec
  plot, findgen(n) * n + 1L, ccat_times, /nodata, xstyle=9, ystyle=8, xmargin=[10, 14], thick=8., $
    xtitle='elements', ytitle='time (seconds)', $
    charsize=charsize, xticklen=0.02, yticklen=0.01, $
    color='000000'x, background='ffffff'x

  vis_decomposed, 0
  vis_loadct, 27, /brewer

  oplot, findgen(n) * n + 1L, ccat_times, thick=8., color=5
  oplot, findgen(n) * n + 1L, clist_times, thick=8., color=3
  oplot, findgen(n) * n + 1L, carraylist_times, thick=8., color=4

  vis_decomposed, 1

  xyouts, n * n + 1L + xpad, clist_times[999], 'LIST', /data, charsize=charsize
  xyouts, n * n + 1L + xpad, carraylist_times[999], 'MGcoArrayList', /data, $
    charsize=charsize

  ind = where(finite(cat_times), count)
  loc = ind[n_elements(ind) - 1L]
  xyouts, loc * n + xpad, ccat_times[loc], 'array concatenation', /data, $
    charsize=charsize

  vis_decomposed, odec
  vis_psend
  vis_convert, 'concatenation', /from_ps, /to_png, max_dimensions=[500, 500], $
    output=im
  vis_image, im, /new




end