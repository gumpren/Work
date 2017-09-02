;+
; :Description:
;    Describe the procedure.
;   read omni data .asc
;   (1)read one file or multi files      /pickfile
;   (2)read all files from data base path
;  note:
;  read data from myTemplate.sav
;  pickfile use only
;
; :Keywords:
;    pickfile      pick file gui
;    data_path
;    variable_name   variable names
;
; :Returns:
;
; :Author: dell-yangjian
;-
; :Bugs:
;
;  written at 19:28:54 2016-1-5
;  Email:yangjian615@buaa.edu.cn
;
FUNCTION read_omni_data_from_spdf_all_parameter,pickfile=pickfile,data_path=data_path,variable_name=variable_name
  compile_opt idl2
  
  if KEYWORD_SET(pickfile) then begin
    if N_ELEMENTS(data_path) eq 0 then data_path='D:\__Data\OMNI'
    filters=['*.txt','*.asc']
    file=DIALOG_PICKFILE(/READ,/MULTIPLE_FILES,FILTER = filters,PATH=data_path)
    
    ;; =============================================
    ;read one file
    ;; =============================================
    if (N_ELEMENTS(file) eq 1) then begin
    
      ;; =============================================
      ; load data read struct
      ;; =============================================
      result = FILE_TEST(data_path+'/myTemplate.sav')
      PRINT, 'myTemplate in: ', result ? 'yes' : 'no'
      if result eq 0 then begin
        myTemplate = ASCII_TEMPLATE(file)
        save,myTemplate,FILENAME=data_path+'/myTemplate.sav', DESCRIPTION='read template structure'
      ENDIF ELSE begin
        restore,data_path+'/myTemplate.sav'
      endelse
      data_from_onefile=READ_ASCII(file, TEMPLATE=myTemplate)
      return,data_from_onefile
    endif ELSE begin
      for i = 0L, file_number-1 do begin
        if (i eq 0) then begin
          data=READ_ASCII(file[i], TEMPLATE=myTemplate,count=read_count)
          tagnames=TAG_NAMES(data)
          for i_tags= 0L, N_TAGS(data)-1 do begin
            print,'NAME:',STRCOMPRESS(i_tags),' ',tagnames[i_tags]
          endfor
          
        endif else begin
          data_count= READ_ASCII(file[i], TEMPLATE=myTemplate,count=read_count)
          case (N_ELEMENTS(variable_name)) of
            0: begin
            
              for i_tags= 0L, N_TAGS(data)-1 do begin
                staus=execute(tagnames[i_tags]+'=data.('+STRCOMPRESS(i_tags)+')')
                staus=execute(tagnames[i_tags]+'=['+tagnames[i_tags]+',data_count.('+STRCOMPRESS(i_tags)+')]')
                
                if i_tags eq 0 then staus=execute('variable_data=CREATE_STRUCT('''+tagnames[0]+''','+tagnames[0]+')') ;��ʼ�� variable_data �Ե�һ��Ϊ��׼
                
                if i_tags gt 0 then staus=execute('variable_data=CREATE_STRUCT('''+tagnames[i_tags]+''','+tagnames[i_tags]+',variable_data)')
              endfor
            ;help,variable_data    check if create all struct
            end
            else: begin
              variable_i=where(tagnames eq STRUPCASE(variable_name))
              variable_data=data.(variable_i)
              variable_data=[variable_data,data_count.(variable_i)]
            end
          endcase
          
        endelse
        
      endfor
      return,variable_data
    endelse
    
  endif
  
  ;; =============================================
  ; to read more than one file
  ;; =============================================
  if N_ELEMENTS(data_path) eq 0 then data_path='Desktop/��һ/omni_energy_initail_phase/omni_data'
  
  restore,data_path+'/myTemplate.sav'
  filters=['*.txt']
  ; variable_name='YEAR'
  
  
  file=FILE_SEARCH(data_path+'/'+filters,COUNT = file_number)
  
  
  for i = 0L, file_number-1 do begin
    if (i eq 0) then begin
      data=READ_ASCII(file[i], TEMPLATE=myTemplate,count=read_count)
      tagnames=TAG_NAMES(data)
      for i_tags= 0L, N_TAGS(data)-1 do begin
        print,'NAME:',STRCOMPRESS(i_tags),' ',tagnames[i_tags]
      endfor
      
    endif else begin
      data_count= READ_ASCII(file[i], TEMPLATE=myTemplate,count=read_count)
      case (N_ELEMENTS(variable_name)) of
        0: begin
        
          for i_tags= 0L, N_TAGS(data)-1 do begin
            staus=execute(tagnames[i_tags]+'=data.('+STRCOMPRESS(i_tags)+')')
            staus=execute(tagnames[i_tags]+'=['+tagnames[i_tags]+',data_count.('+STRCOMPRESS(i_tags)+')]')
            
            if i_tags eq 0 then staus=execute('variable_data=CREATE_STRUCT('''+tagnames[0]+''','+tagnames[0]+')') ;��ʼ�� variable_data �Ե�һ��Ϊ��׼
            
            if i_tags gt 0 then staus=execute('variable_data=CREATE_STRUCT('''+tagnames[i_tags]+''','+tagnames[i_tags]+',variable_data)')
          endfor
        ;help,variable_data    check if create all struct
        end
        else: begin
          variable_i=where(tagnames eq STRUPCASE(variable_name))
          variable_data=data.(variable_i)
          variable_data=[variable_data,data_count.(variable_i)]
        end
      endcase
      
    endelse
    
  endfor
  return,variable_data
  
  
end

