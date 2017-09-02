;+
; :Description:
;    Game 2048.
;
;    ����������
;    1�����д˴��룻
;    2����굥�������м俪ʼ��Ϸ��
;    3����Ҫ�������뷨ΪӢ�ģ���Ϊ��Ҫ�õ������¼���
;    4�����̵��ϡ��¡����ҿ����ƶ����ɣ�
;    5��˫��������¿�ʼ��Ϸ��
;
; :Author: duhj@esrichina.com.cn
;-
PRO Game2048_event, ev
END

;���±�ע��ֵ
PRO ResetNumLabel, oWin
  COMPILE_OPT idl2
  pState = oWin.UVALUE
  ;���±�ע
  data = (*pState).DATA
  NumLabel = STRTRIM(STRING(data),2)
  NumLabel[WHERE(NumLabel EQ '0')] = ' '
  oText = (*pState).OTEXT

  FOR i =0,15 DO BEGIN
    oText[i].STRING = NumLabel[i]
  ENDFOR
END

;ת��Ϊ�ֽ��ͣ�����ʹ����ɫ��
FUNCTION Data2Byte, data
  ;
  COMPILE_OPT idl2

  img = BYTE(ALOG(data)/ALOG(2)*15)
  infIdx = WHERE(FINITE(img, /inf) EQ 1)
  IF infIdx[0] EQ -1 THEN RETURN, (img EQ 0)*255B+(img NE 0)*(255B-img)
  img[infIdx] = 0B
  RETURN, (img EQ 0)*255B+(img NE 0)*(255B-img)
END


FUNCTION RemoveZero, data, $
  up=up, down=down, left=left, right=right

  COMPILE_OPT idl2

  IF KEYWORD_SET(up) + KEYWORD_SET(down) + $
    KEYWORD_SET(left) + KEYWORD_SET(right) GE 2 THEN RETURN, !null
  ;
  ;����ƽ�ƣ��Ȱ�0�ĵط��Ƴ�
  IF KEYWORD_SET(up) THEN BEGIN
    FOR n=0,2 DO BEGIN
      FOR i=0,2 DO BEGIN
        ;��0�Ƴ�
        idx = WHERE(data[*,i] EQ 0)
        IF idx[0] EQ -1 THEN CONTINUE
        data[idx,i] = data[idx,i+1]
        data[idx,i+1] = 0
      ENDFOR
    ENDFOR
  ENDIF

  IF KEYWORD_SET(down) THEN BEGIN
    FOR n=0,2 DO BEGIN
      FOR i=3,1,-1 DO BEGIN
        ;��0�Ƴ�
        idx = WHERE(data[*,i] EQ 0)
        IF idx[0] EQ -1 THEN CONTINUE
        data[idx,i] = data[idx,i-1]
        data[idx,i-1] = 0
      ENDFOR
    ENDFOR
  ENDIF

  IF KEYWORD_SET(left) THEN BEGIN
    FOR n=0,2 DO BEGIN
      FOR i=0,2 DO BEGIN
        ;��0�Ƴ�
        idx = WHERE(data[i,*] EQ 0)
        IF idx[0] EQ -1 THEN CONTINUE
        data[i,idx] = data[i+1,idx]
        data[i+1,idx] = 0
      ENDFOR
    ENDFOR
  ENDIF

  IF KEYWORD_SET(right) THEN BEGIN
    FOR n=0,2 DO BEGIN
      FOR i=3,1,-1 DO BEGIN
        ;��0�Ƴ�
        idx = WHERE(data[i,*] EQ 0)
        IF idx[0] EQ -1 THEN CONTINUE
        data[i,idx] = data[i-1,idx]
        data[i-1,idx] = 0
      ENDFOR
    ENDFOR
  ENDIF

  RETURN, data
END

;ƽ����ݣ��հ�����ɾ����ͬ������
FUNCTION ShiftData, data, $
  up=up, down=down, left=left, right=right
  ;
  COMPILE_OPT idl2
  oridata = data

  IF KEYWORD_SET(up) + KEYWORD_SET(down) + $
    KEYWORD_SET(left) + KEYWORD_SET(right) GE 2 THEN RETURN, !null

  ;����ƽ��
  IF KEYWORD_SET(up) THEN BEGIN
    data = removeZero(data, /up)
    FOR i=0,2 DO BEGIN
      ;
      idx = WHERE(data[*,i] EQ data[*,i+1])
      IF idx[0] EQ -1 THEN CONTINUE
      data[idx,i] *= 2
      data[idx,i+1] = 0
      data = removeZero(data, /up)
    ENDFOR
  ENDIF

  ;����ƽ��
  IF KEYWORD_SET(down) THEN BEGIN
    data = removeZero(data, /down)
    FOR i=3,1,-1 DO BEGIN
      ;
      idx = WHERE(data[*,i] EQ data[*,i-1])
      IF idx[0] EQ -1 THEN CONTINUE
      data[idx,i] *= 2
      data[idx,i-1] = 0
      data = removeZero(data, /down)
    ENDFOR
  ENDIF

  ;����ƽ��
  IF KEYWORD_SET(left) THEN BEGIN
    data = removeZero(data, /left)
    FOR i=0,2 DO BEGIN
      ;
      idx = WHERE(data[i,*] EQ data[i+1,*])
      IF idx[0] EQ -1 THEN CONTINUE
      data[i,idx] *= 2
      data[i+1,idx] = 0
      data = removeZero(data, /left)
    ENDFOR
  ENDIF

  ;����ƽ��
  IF KEYWORD_SET(right) THEN BEGIN
    data = removeZero(data, /right)
    FOR i=3,1,-1 DO BEGIN
      ;
      idx = WHERE(data[i,*] EQ data[i-1,*])
      IF idx[0] EQ -1 THEN CONTINUE
      data[i,idx] *= 2
      data[i-1,idx] = 0
      data = removeZero(data, /right)
    ENDFOR
  ENDIF

  IF ARRAY_EQUAL(data, OriData) THEN RETURN, data

  ;���λ�����һ�����֣�2��4��
  ZeroIdx = WHERE(data EQ 0)
  IF ZeroIdx[0] EQ -1 THEN BEGIN
    RETURN, !null
  ENDIF

  r = RANDOMU(seed, 1)*N_ELEMENTS(ZeroIdx)
  ;����2��4�ĸ���Ϊ3��1
  twoORfour = RANDOMU(seed, 1) GE 0.75 ? 4:2
  data[ZeroIdx[r]] = twoORfour
  ;
  RETURN, data
END

;�����¼�
FUNCTION KeyBoardHandler2048, oWin, $
  IsASCII, Character, KeyValue, X, Y, Press, Release, KeyMods
  COMPILE_OPT idl2

  pState = oWin.UVALUE
  ;��-7����-8����-5����-6
  ;��
  IF KeyValue EQ 7 AND Release EQ 1 THEN BEGIN
    ;
    data = ShiftData((*pState).DATA, /up)

    IF DATA EQ !null THEN BEGIN
      !null = DIALOG_MESSAGE('��Ϸ����')
      RETURN, 0
    ENDIF

    (*pState).DATA = data
    (*pState).OIMAGE.SETDATA, Data2Byte(data), /order
  ENDIF

  ;��
  IF KeyValue EQ 8 AND Release EQ 1 THEN BEGIN
    ;
    data = ShiftData((*pState).DATA, /down)

    IF DATA EQ !null THEN BEGIN
      !null = DIALOG_MESSAGE('��Ϸ����')
      RETURN, 0
    ENDIF

    (*pState).DATA = data
    (*pState).OIMAGE.SETDATA, Data2Byte(data), /order
  ENDIF

  ;��
  IF KeyValue EQ 5 AND Release EQ 1 THEN BEGIN
    ;
    data = ShiftData((*pState).DATA, /left)

    IF DATA EQ !null THEN BEGIN
      !null = DIALOG_MESSAGE('��Ϸ����')
      RETURN, 0
    ENDIF

    (*pState).DATA = data
    (*pState).OIMAGE.SETDATA, Data2Byte(data), /order
  ENDIF

  ;��
  IF KeyValue EQ 6 AND Release EQ 1 THEN BEGIN
    ;
    data = ShiftData((*pState).DATA, /right)

    IF DATA EQ !null THEN BEGIN
      !null = DIALOG_MESSAGE('��Ϸ����')
      RETURN, 0
    ENDIF

    (*pState).DATA = data
    (*pState).OIMAGE.SETDATA, Data2Byte(data), /order
  ENDIF

  ;���±�ע
  ResetNumLabel, oWin

  RETURN, 0
END

;��갴���¼�
FUNCTION MouseDownHandler2048, oWin, $
  x, y, iButton, KeyMods, nClicks

  COMPILE_OPT idl2
  pState = oWin.UVALUE

  oWin.SetCurrentCursor, 'ARROW'
  
  ;��굥����ʼ��˫�����¿�ʼ
  IF iButton EQ 1 AND nClicks EQ 1 THEN RETURN, 1 $
  ELSE IF iButton EQ 1 AND nClicks EQ 2 THEN BEGIN
    data = LONARR(4,4)
    r = RANDOMU(seed, 2)*16
    data[r] = 2
    (*pState).DATA = data
    (*pState).OIMAGE.SETDATA, Data2Byte(data), /order

    ResetNumLabel, oWin
    RETURN, 0
  ENDIF ELSE RETURN, 0
END

;����ԭʼ������ƶ����¼�
FUNCTION MouseMotionHandler2048, oWin, x, y, KeyMods
  RETURN, 0
END

FUNCTION MouseWheelHandler2048, oWin, X, Y, Delta, KeyMods
  RETURN, 0
END


PRO Game2048

  COMPILE_OPT idl2
  ;
  !except = 0
  
  ;��ʼ�����
  data = LONARR(4,4)
  r = RANDOMU(seed, 2)*16
  data[r] = 2
  
  ;����
  tlb = WIDGET_BASE(/COLUMN, TITLE='2048', TLB_FRAME_ATTR=1, $
    XPAD=-7, YPAD=-7, map=0)
  ;
  Win = WIDGET_WINDOW(tlb, XSIZE=400, YSIZE=400)
  WIDGET_CONTROL, tlb, /REALIZE

  ;������ʾ
  geom = WIDGET_INFO(tlb, /Geometry)
  DEVICE, get_screen_size=ss
  xoffset = (ss[0]-geom.SCR_XSIZE)/2
  yoffset = (ss[1]-geom.SCR_YSIZE)/2
  WIDGET_CONTROL, tlb, XOFFSET=XOFFSET, YOFFSET=YOFFSET
  WIDGET_CONTROL, tlb, /map
  
  ;��ʾ��ʼ���
  WIDGET_CONTROL, Win, GET_VALUE=oWin
  oWin.SetCurrentCursor, 'ARROW'
  oWin.Select
  oImage = Image(Data2Byte(data), /CURRENT, RGB_TABLE=2, /ORDER, WINDOW_TITLE='2048')
  oImage.Scale, 100,100
  oImage.Select

  ;��ע���
  locX = (INDGEN(4)+1)*0.25-0.125
  locY = reverse((INDGEN(1,4)+1)*0.25-0.125, 2)
  locX = REBIN(locX, 4,4)
  locY = REBIN(locY, 4,4)-0.025
  
  ;��ע��ǰ��Ԫֵ
  NumLabel = STRTRIM(STRING(data),2)
  ZeroIdx = WHERE(NumLabel EQ '0')
  IF ZeroIdx[0] NE -1 THEN NumLabel[ZeroIdx] = ' '
  oText = Text(locX, locY, NumLabel, /current, align=0.5, $
    font_size = 26, font_color = 'white', font_name='Calibri', font_style=1)
    
  ;����Ҫ�ı���������pState��
  pState = {data:data, oImage:oImage, oText:oText, locX:locX, locY:locY}
  oWin.UVALUE = PTR_NEW(pState)
  
  ;������ꡢ�����¼�
  oWin.KEYBOARD_HANDLER = 'KeyBoardHandler2048'
  oWin.MOUSE_DOWN_HANDLER='MouseDownHandler2048'
  oWin.MOUSE_MOTION_HANDLER='MouseMotionHandler2048'
  oWin.MOUSE_WHEEL_HANDLER = 'MouseWheelHandler2048'

  XMANAGER, 'Game2048_event', tlb, /NO_BLOCK
END
