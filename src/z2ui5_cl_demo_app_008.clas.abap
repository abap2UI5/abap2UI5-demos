CLASS z2ui5_cl_demo_app_008 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_strip_active TYPE abap_bool.
    DATA strip_type TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_008 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    CASE client->get( )-event.

      WHEN 'BUTTON_MESSAGE_BOX_CONFIRM'.
        client->message_box_display( text = 'Approve purchase order 12345?'
                                     type = 'confirm' ).

      WHEN 'BUTTON_MESSAGE_BOX_ALERT'.
        client->message_box_display( text = 'The quantity you have reported exceeds the quantity planned.'
                                     type = 'alert' ).

      WHEN 'BUTTON_MESSAGE_BOX_ERROR'.
        client->message_box_display( text                                                   = 'Select a team in the "Development" area.' && cl_abap_char_utilities=>cr_lf &&
                                            '"Marketing" isn’t assigned to this area.' type = 'error' ).

      WHEN 'BUTTON_MESSAGE_BOX_INFO'.
        client->message_box_display( 'Your booking will be reserved for 24 hours.' ).

      WHEN 'BUTTON_MESSAGE_BOX_WARNING'.
        client->message_box_display( text = 'The project schedule was last updated over a year ago.'
                                     type = 'warning' ).

      WHEN 'BUTTON_MESSAGE_BOX_SUCCESS'.
        client->message_box_display( text = 'Project 1234567 was created and assigned to team "ABC".'
                                     type = 'success' ).

      WHEN 'BUTTON_MESSAGE_TOAST'.
        client->message_toast_display( 'this is a message toast' ).

      WHEN 'BUTTON_MESSAGE_TOAST2'.
        client->message_toast_display( text                    = 'this is a message toast'
                                       at                      = 'left bottom'
            offset                                             = '0 -15'
                                       animationtimingfunction = `ease-in`
                                       class                   = 'my-style' ).

      WHEN 'BUTTON_MESSAGE_STRIP_INFO'.
        check_strip_active = abap_true.
        strip_type = 'Information'.

      WHEN 'BUTTON_MESSAGE_STRIP_ERROR'.
        check_strip_active = abap_true.
        strip_type = 'Error'.

      WHEN 'BUTTON_MESSAGE_STRIP_SUCCESS'.
        check_strip_active = abap_true.
        strip_type = 'Success'.

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
        )->page(
            title           = 'abap2UI5 - Messages'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true
            )->header_content(
                )->link(
            )->get_parent( ).

    IF check_strip_active = abap_true.
      page->message_strip( text = 'This is a Message Strip'
                           type = strip_type ).
    ENDIF.

    page->grid( 'L6 M12 S12'
        )->content( 'layout'
            )->simple_form( 'Message Box' )->content( 'form'
                )->button(
                    text  = 'Confirm'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_CONFIRM' )
                )->button(
                    text  = 'Alert'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_ALERT' )
                )->button(
                    text  = 'Error'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_ERROR' )
                )->button(
                    text  = 'Info'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_INFO' )
                )->button(
                    text  = 'Warning'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_WARNING' )
                )->button(
                    text  = 'Success'
                    press = client->_event( 'BUTTON_MESSAGE_BOX_SUCCESS' ) ).

    page->grid( 'L6 M12 S12'
        )->content( 'layout'
            )->simple_form( 'Message Strip' )->content( 'form'
                )->button(
                    text  = 'success'
                    press = client->_event( 'BUTTON_MESSAGE_STRIP_SUCCESS' )
                )->button(
                    text  = 'error'
                    press = client->_event( 'BUTTON_MESSAGE_STRIP_ERROR' )
                )->button(
                    text  = 'information'
                    press = client->_event( 'BUTTON_MESSAGE_STRIP_INFO' ) ).

    page->grid( 'L6 M12 S12'
        )->content( 'layout'
            )->simple_form( 'Display' )->content( 'form'
                )->button(
                    text  = 'Message Toast'
                    press = client->_event( 'BUTTON_MESSAGE_TOAST' )
               )->button(
                    text  = 'Message Toast Customized'
                    press = client->_event( 'BUTTON_MESSAGE_TOAST2' ) ).


    client->view_display( view->stringify( ) ).
  ENDMETHOD.
ENDCLASS.
