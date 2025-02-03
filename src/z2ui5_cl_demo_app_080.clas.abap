CLASS z2ui5_cl_demo_app_080 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_s_appointments,
        start     TYPE string,
        end       TYPE string,
        title     TYPE string,
        type      TYPE string,
        info      TYPE string,
        pic       TYPE string,
        tentative TYPE abap_bool,
      END OF ty_s_appointments .
    TYPES:
      BEGIN OF ty_s_headers,
        start     TYPE string,
        end       TYPE string,
        title     TYPE string,
        type      TYPE string,
        info      TYPE string,
        pic       TYPE string,
        tentative TYPE abap_bool,
      END OF ty_s_headers .
    TYPES:
      BEGIN OF ty_s_people,
        name         TYPE string,
        pic          TYPE string,
        role         TYPE string,
        appointments TYPE TABLE OF ty_s_appointments WITH NON-UNIQUE DEFAULT KEY,
        headers      TYPE TABLE OF ty_s_headers      WITH NON-UNIQUE DEFAULT KEY,
      END OF ty_s_people .

    TYPES temp1_813550bafa TYPE STANDARD TABLE OF ty_s_people.
DATA mt_people TYPE temp1_813550bafa.

  PROTECTED SECTION.

    DATA client            TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_display_view.
    METHODS z2ui5_on_event.
    METHODS z2ui5_set_data.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_080 IMPLEMENTATION.


  METHOD z2ui5_display_view.

    DATA lv_s_date TYPE c LENGTH 19.
    lv_s_date = '2023-04-22T08:15:00'.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE z2ui5_if_types=>ty_s_name_value.
    CLEAR temp1.
    temp1-n = `core:require`.
    temp1-v = `{Helper:'z2ui5/Util'}`.
    view->_generic_property( temp1 ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp3 TYPE xsdboolean.
    temp3 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page( id = `page_main`
            title               = 'abap2UI5 - Planning Calendar'
            navbuttonpress      = client->_event( 'BACK' )
            shownavbutton       = temp3
            class               = 'sapUiContentPadding' ).

    DATA lo_vbox TYPE REF TO z2ui5_cl_xml_view.
    lo_vbox = page->vbox( class ='sapUiSmallMargin' ).

    DATA temp2 TYPE string_table.
    CLEAR temp2.
    INSERT `${$parameters>/appointment/mProperties/title}` INTO TABLE temp2.
    DATA lo_planningcalendar TYPE REF TO z2ui5_cl_xml_view.
    lo_planningcalendar = lo_vbox->planning_calendar(
                                                          startdate         = `{= Helper.DateCreateObject($` && client->_bind_local( lv_s_date ) && ') }'
                                                          rows              = `{path: '` && client->_bind_local( val = mt_people path = abap_true ) && `'}`
                                                          appointmentselect = client->_event( val = 'AppSelected' t_arg = temp2 )
                                                          showweeknumbers   = abap_true ).


    DATA lo_rows TYPE REF TO z2ui5_cl_xml_view.
    lo_rows = lo_planningcalendar->rows( ).
    DATA lo_planningcalendarrow TYPE REF TO z2ui5_cl_xml_view.
    lo_planningcalendarrow = lo_rows->planning_calendar_row(
                                                     appointments    = `{path:'APPOINTMENTS', templateShareable: false}`
                                                     icon            = '{PIC}'
                                                     title           = '{NAME}'
                                                     text            = '{ROLE}'
                                                     intervalheaders = `{path:'HEADERS', templateShareable: false}` ).
    lo_planningcalendarrow->appointments( )->calendar_appointment(
                                                                  startdate = `{= Helper.DateCreateObject(${START} ) }`
                                                                  enddate   = `{= Helper.DateCreateObject(${END} ) }`
                                                                  icon      = '{PIC}'
                                                                  title     = '{TITLE}'
                                                                  text      = '{INFO}'
                                                                  type      = '{TYPE}'
                                                                  tentative = '{TENTATIVE}' ).

    lo_planningcalendarrow->interval_headers( )->calendar_appointment(
                                                                      startdate = `{= Helper.DateCreateObject(${START} ) }`
                                                                      enddate   = `{= Helper.DateCreateObject(${END} ) }`
                                                                      icon      = '{PIC}'
                                                                      title     = '{TITLE}'
                                                                      text      = '{INFO}'
                                                                      type      = '{TYPE}' ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    me->client     = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_set_data( ).
    ENDIF.

    IF client->get( )-check_on_navigated = abap_true OR client->get( )-event = 'DISPLAY_VIEW'.
      z2ui5_display_view( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.
    CASE client->get( )-event.
      WHEN 'AppSelected'.
        DATA ls_client TYPE z2ui5_if_types=>ty_s_get.
        ls_client = client->get( ).
        DATA temp4 LIKE LINE OF ls_client-t_event_arg.
        DATA temp5 LIKE sy-tabix.
        temp5 = sy-tabix.
        READ TABLE ls_client-t_event_arg INDEX 1 INTO temp4.
        sy-tabix = temp5.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        client->message_toast_display( |Event AppSelected with appointment { temp4 }| ).
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.
  ENDMETHOD.


  METHOD z2ui5_set_data.
    DATA temp6 LIKE mt_people.
    CLEAR temp6.
    DATA temp7 LIKE LINE OF temp6.
    temp7-name = 'Olaf'.
    temp7-role = 'Team Member'.
    temp7-pic = 'sap-icon://employee'.
    DATA temp1 TYPE z2ui5_cl_demo_app_080=>ty_s_people-appointments.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-start = '2023-04-22T08:15:00'.
    temp2-end = '2023-04-23T08:15:00'.
    temp2-info = 'Mittag1'.
    temp2-type = 'Type01'.
    temp2-title = 'App1'.
    temp2-tentative = abap_false.
    temp2-pic = 'sap-icon://sap-ui5'.
    INSERT temp2 INTO TABLE temp1.
    temp2-start = '2023-04-25T10:30:00'.
    temp2-end = '2023-04-26T11:30:00'.
    temp2-info = 'Mittag2'.
    temp2-type = 'Type02'.
    temp2-title = 'App2'.
    temp2-tentative = abap_false.
    temp2-pic = 'sap-icon://sap-ui5'.
    INSERT temp2 INTO TABLE temp1.
    temp2-start = '2023-04-10T10:30:00'.
    temp2-end = '2023-04-11T11:30:00'.
    temp2-info = 'Mittag3'.
    temp2-type = 'Type03'.
    temp2-title = 'App3'.
    temp2-tentative = abap_false.
    temp2-pic = 'sap-icon://sap-ui5'.
    INSERT temp2 INTO TABLE temp1.
    temp7-appointments = temp1.
    DATA temp3 TYPE z2ui5_cl_demo_app_080=>ty_s_people-headers.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-start = '2020-04-22T08:15:00'.
    temp4-end = '2020-04-23T08:15:00'.
    temp4-type = 'Type11'.
    temp4-title = 'Reminder1'.
    temp4-tentative = abap_true.
    INSERT temp4 INTO TABLE temp3.
    temp4-start = '2020-04-25T10:30:00'.
    temp4-end = '2020-04-26T11:30:00'.
    temp4-type = 'Type12'.
    temp4-title = 'Reminder2'.
    temp4-tentative = abap_false.
    INSERT temp4 INTO TABLE temp3.
    temp7-headers = temp3.
    INSERT temp7 INTO TABLE temp6.
    temp7-name = 'Stefanie'.
    temp7-role = 'Team Member'.
    temp7-pic = 'sap-icon://employee'.
    DATA temp5 TYPE z2ui5_cl_demo_app_080=>ty_s_people-appointments.
    CLEAR temp5.
    DATA temp8 LIKE LINE OF temp5.
    temp8-start = '2023-04-22T08:15:00'.
    temp8-end = '2023-04-23T08:15:00'.
    temp8-info = 'Mittag11'.
    temp8-type = 'Type11'.
    temp8-title = 'App11'.
    temp8-tentative = abap_false.
    temp8-pic = 'sap-icon://sap-ui5'.
    INSERT temp8 INTO TABLE temp5.
    temp8-start = '2023-04-25T10:30:00'.
    temp8-end = '2023-04-26T11:30:00'.
    temp8-info = 'Mittag21'.
    temp8-type = 'Type12'.
    temp8-title = 'App12'.
    temp8-tentative = abap_false.
    temp8-pic = 'sap-icon://sap-ui5'.
    INSERT temp8 INTO TABLE temp5.
    temp8-start = '2023-04-10T10:30:00'.
    temp8-end = '2023-04-11T11:30:00'.
    temp8-info = 'Mittag31'.
    temp8-type = 'Type13'.
    temp8-title = 'App13'.
    temp8-tentative = abap_false.
    temp8-pic = 'sap-icon://sap-ui5'.
    INSERT temp8 INTO TABLE temp5.
    temp7-appointments = temp5.
    DATA temp9 TYPE z2ui5_cl_demo_app_080=>ty_s_people-headers.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-start = '2023-04-22T08:15:00'.
    temp10-end = '2023-04-23T08:15:00'.
    temp10-type = 'Type11'.
    temp10-title = 'Reminder11'.
    temp10-tentative = abap_true.
    INSERT temp10 INTO TABLE temp9.
    temp10-start = '2023-04-25T10:30:00'.
    temp10-end = '2023-04-26T11:30:00'.
    temp10-type = 'Type12'.
    temp10-title = 'Reminder21'.
    temp10-tentative = abap_false.
    INSERT temp10 INTO TABLE temp9.
    temp7-headers = temp9.
    INSERT temp7 INTO TABLE temp6.
    mt_people = temp6.
  ENDMETHOD.
ENDCLASS.
