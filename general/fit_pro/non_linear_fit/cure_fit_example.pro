
;+
; :Description:
;    Describe the procedure.
;
;     fit demo by iplot
;     各种拟合的demo
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
    n = 50
    x = (findgen(n) - 25)/2
    yerr = 0.1
    y = 2 + 0.1*x + 3*exp(-((x - 1)/2)^2) + yerr*randomn(1,n)
    yerror = replicate(yerr, n)

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



END
