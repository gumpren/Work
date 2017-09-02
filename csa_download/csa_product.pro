function csa_product, csa_creds, csa_dataset_id, csa_start_date, csa_end_date,$
  delivery_format=csa_delivery_format, delivery_interval=csa_delivery_interval,$
  ref_doc=csa_ref_doc, ingested_since=csa_ingested_since, max_file_size = csa_max_file_size
  ;Function that Downloads data from the CSA AIO system.
  ;Parameters:
  ;     CSA_CREDS: String containing the JSESSIONID cookie returned from csa_login.pro
  ;     CSA_DATASET_ID: String array containing one or more valid dataset ids, one per element
  ;     CSA_START_DATE: String containing start date for data request, in the format 'yyyy-mm-ddThh:mi:ssZ'
  ;     CSA_END_DATE: String containing end date for data request, in the same format as csa_start_date
  ;Keywords:
  ;     Optional parameters accepted by the CSA AIO product action, with the exception of NON_BROWSER and RETRIEVALTYPE, are accepted as keywords.
  ;     Optional parameters MUST be passed as strings to the relevant keyword. See the CSA AIO User Manual for accepted values.
  ;     Note START_DATE and END_DATE are mandatory and passed as parameters here.
  ;Return Value:
  ;     If download is successful, returns a string containing the downloaded file name.
  ;     If download is unsuccessful, returns 0 (or falls over gracelessly).
  ;
  ;Example:
  ;     To download full resolution FGM data from C1 and C2 22:50-23:50 UT, 7 August 2004, including caveats, in cdf format:
  ;
  ;     credentials = csa_login('username','password')
  ;     filename = csa_product(credentials,['C1_CP_FGM_FULL','C2_CP_FGM_FULL'],'2004-08-07T22:50:00Z','2004-08-07T23:50:00Z',delivery_format='CDF',REF_DOC='1')
  ;
  ;Andrew Walsh, 2013-05-30, awalsh[AT]rssd[DOT]esa[DOT]int

  ;define URL host and path
  csa_host = 'csa.esac.esa.int'
  csa_product_path = 'csa/aio/product-action'

  ;construct URL query from supplied parameters and keywords
  csa_product_query = ''
  for i = 0, n_elements(csa_dataset_id) -1 do begin
    csa_product_query=csa_product_query+'DATASET_ID='+csa_dataset_id[i]+'&'
  endfor
  csa_product_query = csa_product_query+'&START_DATE='+csa_start_date+'&END_DATE='+csa_end_date+'&NON_BROWSER'
  if keyword_set(csa_delivery_format) then csa_product_query=csa_product_query+'&DELIVERY_FORMAT='+csa_delivery_format
  if keyword_set(csa_delivery_interval) then csa_product_query=csa_product_query+'&DELIVERY_INTERVAL='+csa_delivery_interval
  if keyword_set(csa_ref_doc) then csa_product_query=csa_product_query+'&REF_DOC='+csa_ref_doc
  if keyword_set(csa_ingested_since) then csa_product_query=csa_product_query+'&INGESTED_SINCE='+csa_ingested_since
  if keyword_set(csa_max_file_size) then csa_product_query=csa_product_query+'&MAX_FILE_SIZE='+csa_max_file_size

  ;construct crendentials string for http header
  csa_cookie = 'Cookie: '+csa_creds

  ;Create IDLnetURL object and set properties
  csa_product_obj = obj_new('IDLnetUrl')
  csa_product_obj->SetProperty, VERBOSE=1
  csa_product_obj->SetProperty, url_scheme = 'https'
  csa_product_obj->SetProperty, url_host = csa_host
  csa_product_obj->SetProperty, url_path = csa_product_path
  csa_product_obj->SetProperty, url_query = csa_product_query
  csa_product_obj->SetProperty, headers = csa_cookie

  ;send request to CSA AIO system, saving response in csa_buffer.dat
  print, 'Getting data from CSA, please wait.'
  csa_product_response = csa_product_obj->get(filename='csa_buffer.dat')
  csa_product_obj->getproperty, response_header=csa_product_header
  ;print, csa_product_header

  ;check a .tar.gz file was downloaded and if so rename buffer to correct filename and return correct filename, otherwise return 0
  csa_filestart = strpos(csa_product_header,'filename=')
  if csa_filestart ne -1 then begin
    csa_fileend =  strpos(csa_product_header,'gz"')
    csa_filename = strmid(csa_product_header,csa_filestart+10,csa_fileend-csa_filestart-8)
    csa_dir_end = strpos(csa_product_response,'csa_buffer.dat')
    csa_working_dir = strmid(csa_product_response,0,csa_dir_end)
    file_move, csa_product_response, csa_working_dir+csa_filename
    print, 'Downloaded data to '+csa_working_dir+csa_filename
    outfile = csa_working_dir+csa_filename
    return, outfile
  endif else begin
    print, 'Something went wrong.'
    return, 0
  endelse
end