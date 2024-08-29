REPORT z_http_gameplay.

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_url TYPE string.
SELECTION-SCREEN: END OF BLOCK b1.

CALL METHOD cl_http_client=>create_by_url
  EXPORTING
    url                = p_url
  IMPORTING
    client             = DATA(lv_client)
  EXCEPTIONS
    argument_not_found = 1
    plugin_not_active  = 2
    internal_error     = 3
    pse_not_found      = 4
    pse_not_distrib    = 5
    pse_errors         = 6
    OTHERS             = 7.
IF sy-subrc = 0.
* Implement suitable error handling here


  DATA(lv_time_constraint) = 15.

  CALL METHOD lv_client->send
    EXPORTING
      timeout                    = lv_time_constraint
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3
      http_invalid_timeout       = 4
      OTHERS                     = 5.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  CALL METHOD lv_client->receive
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3
      OTHERS                     = 4.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  DATA(result) = lv_client->response->get_cdata( ).

  CALL METHOD cl_abap_browser=>show_html
    EXPORTING
      title       = 'Result of your rest API'
      html_string = result.
ENDIF.
