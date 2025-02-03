CLASS z2ui5_cl_demo_app_323 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA mv_quantity TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS z2ui5_cl_demo_app_323 IMPLEMENTATION.

  METHOD z2ui5_if_app~main.

    IF client->check_on_navigated( ) IS NOT INITIAL.
      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).
      client->view_display( val = view->shell(
             )->page(
                     title          = 'abap2UI5 - Navigation with app state'
                     navbuttonpress = client->_event( 'BACK' )
                     shownavbutton  = client->check_app_prev_stack( )
          )->simple_form( title = 'Form Title' editable = abap_true
                     )->content( 'form'
                         )->title( 'Input'
                         )->label( 'quantity'
                         )->input( client->_bind_edit( mv_quantity )
                         )->button(
                             text  = 'share'
                             press = client->_event( val = 'BUTTON_POST' )
              )->stringify( ) ).
    ENDIF.

    CASE client->get( )-event.

      WHEN `BUTTON_POST`.
        client->follow_up_action( client->_event_client( z2ui5_if_client=>cs_event-CLIPBOARD_APP_STATE ) ).
        client->message_toast_display( `clipboard copied` ).

      WHEN `BACK`.
        client->nav_app_leave( ).
    ENDCASE.
  ENDMETHOD.



ENDCLASS.
