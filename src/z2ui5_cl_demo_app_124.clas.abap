CLASS z2ui5_cl_demo_app_124 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .
    DATA mv_scan_input TYPE string.
    DATA mv_scan_type TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_124 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    CASE client->get( )-event.

      WHEN 'ON_SCAN_SUCCESS'.
        client->message_box_display( `Scan finished!`).
        DATA lt_arg TYPE string_table.
        lt_arg = client->get( )-t_event_arg.
        DATA temp1 LIKE LINE OF lt_arg.
        DATA temp2 LIKE sy-tabix.
        temp2 = sy-tabix.
        READ TABLE lt_arg INDEX 1 INTO temp1.
        sy-tabix = temp2.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        mv_scan_input = temp1.
        DATA temp3 LIKE LINE OF lt_arg.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE lt_arg INDEX 2 INTO temp3.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        mv_scan_type  = temp3.
        "implement further processing here...
        "...
        client->view_model_update( ).
        RETURN.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
        RETURN.

    ENDCASE.

    DATA temp5 TYPE string_table.
    CLEAR temp5.
    INSERT `${$parameters>/text}` INTO TABLE temp5.
    INSERT `${$parameters>/format}` INTO TABLE temp5.
    DATA temp6 TYPE xsdboolean.
    temp6 = boolc( abap_false = client->get( )-check_launchpad_active ).
    DATA temp7 TYPE xsdboolean.
    temp7 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( z2ui5_cl_xml_view=>factory( )->shell(
          )->page(
                 showheader      = temp6
                  title          = 'abap2UI5'
                  navbuttonpress = client->_event( val = 'BACK' )
                  shownavbutton  = temp7
              )->simple_form( title    = 'Information'
                              editable = abap_true
                  )->content( 'form'
                      )->label( 'mv_scan_input'
                      )->input( client->_bind_edit( mv_scan_input )
                      )->label( `mv_scan_type`
                      )->input( client->_bind_edit( mv_scan_type )
                      )->label( `scanner`
                      )->barcode_scanner_button(
                        scansuccess = client->_event( val = 'ON_SCAN_SUCCESS' t_arg = temp5 )
                        dialogtitle = `Barcode Scanner`
           )->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
