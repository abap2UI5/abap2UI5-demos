CLASS z2ui5_cl_demo_app_187 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

ENDCLASS.

CLASS z2ui5_cl_demo_app_187 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.
    DATA ls_msg TYPE bapiret2.


    IF client->check_on_init( ) IS NOT INITIAL.

      client->view_display( z2ui5_cl_xml_view=>factory( )->shell(
        )->page(
            title          = 'abap2UI5 - Popup To Confirm'
            navbuttonpress = client->_event( val = 'BACK' )
            shownavbutton  = client->check_app_prev_stack( )
        )->button(
            text  = 'SY'
            press = client->_event( 'SY' )
                )->button(
            text  = 'BAPIRET'
            press = client->_event( 'BAPIRET' )
                )->button(
            text  = 'CX_ROOT'
            press = client->_event( 'CX_ROOT' )
        )->stringify( ) ).

      RETURN.
    ENDIF.

    CASE client->get( )-event.

      WHEN 'SY'.
        DATA lv_dummy TYPE string.
        MESSAGE ID 'NET' TYPE 'E' NUMBER '001' INTO lv_dummy.
        client->message_box_display( sy ).

      WHEN 'BAPIRET'.



        CLEAR ls_msg.
        ls_msg-id = 'NET'.
        ls_msg-number = '001'.
        client->message_box_display( ls_msg ).

      WHEN 'CX_ROOT'.
        TRY.
            DATA lv_val TYPE i.
            lv_val = 1 / 0.
            DATA lx TYPE REF TO cx_root.
          CATCH cx_root INTO lx.
            client->message_box_display( lx ).
        ENDTRY.

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
