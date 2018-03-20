
;+
; :Description:
;    Describe the procedure.
;
;     fit demo by iplot
;     ������ϵ�demo
;
;
;
; :Returns:
;
; :Author: yangjian-yangjian
;-
; :Bugs:
;
;  written at 22:43:19 2016-10-28
;  Email:yangjian615@buaa.edu.cn
;
PRO cure_fit_example

    ; Generate a plot line
;    n = 50
;    x = (findgen(n) - 25)/2
;    yerr = 0.1
;    y = 2 + 0.1*x + 3*exp(-((x - 1)/2)^2) + yerr*randomn(1,n)
;    yerror = replicate(yerr, n)
    
    restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\H_x_average_median_arr_dawn_dusk_lasttime_10minute_per_point_4panel.sav'
    
    x=10*(indgen(15))+5
    y=median_vari_dawn_south
    
    
    IPLOT, x, y, $
        COLOR = [255,0,0], $
        ERRORBAR_COLOR = [255,0,0], $
        THICK = 2, $
        LINESTYLE = 6, $
        NAME = 'Gaussian+Linear', $
        SYM_INDEX = 4, $
        XTITLE = 'X', $
        YTITLE = 'Y', $
        YERROR = yerror, $
        /NO_SAVEPROMPT

    idTool = iGetCurrent(TOOL=oTool)
    void = oTool->DoAction('Operations/Operations/Filter/Curve Fitting')
    oWin = oTool->GetCurrentWindow()
    oWin->ClearSelections
    void = oTool->DoAction('Operations/Insert/Legend')

    stop

END
