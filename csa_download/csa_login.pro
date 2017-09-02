function csa_login,user,pass

  ;Function that logs in to the CSA AIO system.
  ;Parameters:
  ;     USER: String containing your RSSD LDAP user identifier
  ;     PASS: String containing your RSSD LDAP password
  ;
  ;Return Value:
  ;     If login is successful, returns a string containing a JSESSIONID cookie
  ;     If login is unsuccessful, returns 0
  ;
  ;Example:
  ;     credentials = csa_login('username','password')
  ;
  ;Andrew Walsh, 2013-05-30, awalsh[AT]rssd[DOT]esa[DOT]int
  ;
  ;Updated to add support for reserved characters in passwords
  ;Andrew Walsh, 2015-01-28, awalsh[AT]sciops[DOT]esa[DOT]int

  ;Check for reserved characters in password and replace with URL-Encoded equivalents.

  reserved = ["%","!","#","$","&","'","(",")","*","+",",","/",":",";","=","?","@","[","]"]
  encoded = ["%25","%21","%23","%24","%26","%27","%28","%29","%2A","%2B","%2C","%2F","%3A","%3B","%3D","%3F","%40","%5B","%5D"]

  for i = 0, n_elements(reserved) -1 do begin
    startpos = 0
    foundpos = 0
    reserved_positions = -1
    while foundpos ne -1 and startpos le  strlen(pass)-1 do begin
      foundpos = strpos(pass,reserved[i],startpos)
      if foundpos ne -1 then begin
        if startpos eq 0 then reserved_positions = foundpos else reserved_positions = [reserved_positions,foundpos]
        startpos = foundpos+1
      endif
    endwhile
    if reserved_positions[0] ne -1 then begin
      reserved_positions = reverse(reserved_positions)
      for j = 0, n_elements(reserved_positions) -1 do begin
        if reserved_positions[j] eq strlen(pass)-1 then begin
          pass_before = strmid(pass,0,reserved_positions[j])
          new_pass = pass_before+encoded[i]
          pass = new_pass
        endif else if reserved_positions[j] eq 0 then begin
          pass_after = strmid(pass,reserved_positions[j]+1,strlen(pass)-(reserved_positions[j]+1))
          new_pass = encoded[i]+pass_after
          pass = new_pass
        endif else begin
          pass_before = strmid(pass,0,reserved_positions[j])
          pass_after = strmid(pass,reserved_positions[j]+1,strlen(pass)-(reserved_positions[j]+1))
          new_pass = pass_before+encoded[i]+pass_after
          pass = new_pass
        endelse
      endfor
    endif
  endfor




  ;construct host, path and query parts of URL
  csa_host = 'csa.esac.esa.int'
  csa_login_path = 'csa/aio/login-action'
  csa_login_query = 'USERNAME='+user+'&PASSWORD='+pass+'&SUBMIT=LOGIN&NON_BROWSER'

  ;define successful login string for comparision with what's returned from CSA AIO
  csa_login_success = '['+user+'] has successfully logged in!'

  ;create and set properties of an IDLnetURL object
  csa_login_obj = obj_new('IDLnetUrl')
  csa_login_obj->SetProperty, url_scheme = 'https'
  csa_login_obj->SetProperty, url_host = csa_host
  csa_login_obj->SetProperty, url_path = csa_login_path
  csa_login_obj->SetProperty, url_query = csa_login_query

  ;send login request to CSA AIO
  csa_login_response = csa_login_obj->IDLnetURL::get(/string_array)

  ;print response from CSA AIO
  print, csa_login_response

  ;check for successful login and extract session cookie from CSA AIO response
  if csa_login_response[0] ne csa_login_success then begin
    return, 0
  endif else begin
    csa_login_obj->getproperty, response_header=csa_login_header
    csa_cred_start = strpos(csa_login_header,'JSESSIONID')
    csa_cred_end = strpos(csa_login_header,';')
    csa_creds = strmid(csa_login_header,csa_cred_start,csa_cred_end-csa_cred_start)
    return, csa_creds
  endelse
end


