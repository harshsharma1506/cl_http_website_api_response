# cl_http_website_api_response
Following code can help you to get data from any API / site to SAP via HTML viewer

## Class Used 
### CL_HTTP_CLIENT 
This will make your object an HTTP client with the help of which you will be interacting with the URL

```
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
```

### Send method to send the response to your API / URL / URI

```
CALL METHOD lv_client->send
    EXPORTING
      timeout                    = lv_time_constraint  " for timeout , its fine to have max 15 seconds 
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3
      http_invalid_timeout       = 4
      OTHERS                     = 5.
```

### Call the receive method to fetch the details first 

```
CALL METHOD lv_client->receive
    EXCEPTIONS
      http_communication_failure = 1
      http_invalid_state         = 2
      http_processing_failed     = 3
      OTHERS                     = 4.
```

### Now we need to get the response via response method which within itself will call get_cdata , this will return HTML string !

```
DATA(result) = lv_client->response->get_cdata( ).

  CALL METHOD cl_abap_browser=>show_html
    EXPORTING
      title       = 'Result of your rest API'
      html_string = result.
```

### Selection Screen 

![image](https://github.com/user-attachments/assets/e71008f5-2e15-4873-b1fa-396771a73c91)

### Result - ( it does get the HTML response :) )

![image](https://github.com/user-attachments/assets/12f2a000-eb09-49fa-a9c5-29a1711b9d61)


