CLASS z2ui5_cl_demo_app_018 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA quantity TYPE string.
    DATA mv_textarea TYPE string.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.

    METHODS z2ui5_display_view_main.
    METHODS z2ui5_display_view_second.
    METHODS z2ui5_display_popup_input.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_018 IMPLEMENTATION.


  METHOD z2ui5_display_popup_input.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->dialog(
             title = 'Title'
             icon  = 'sap-icon://edit'
                  )->content(
                      )->text_area(
                          height = '100%'
                          width  = '100%'
                          value  = client->_bind_edit( mv_textarea )
                        )->button(
                          text  = 'Cancel'
                          press = client->_event( 'POPUP_CANCEL' )
                      )->button(
                          text  = 'Confirm'
                          press = client->_event( 'POPUP_CONFIRM' )
                          type  = 'Emphasized' ).
*                  )->get_parent(
*                  )->footer( )->overflow_toolbar(
*                      )->toolbar_spacer(
*                      )->button(
*                          text  = 'Cancel'
*                          press = client->_event( 'POPUP_CANCEL' )
*                      )->button(
*                          text  = 'Confirm'
*                          press = client->_event( 'POPUP_CONFIRM' )
*                          type  = 'Emphasized' ).

    client->popup_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_display_view_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Template'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1
            )->simple_form( title    = 'VIEW_MAIN'
                            editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'quantity'
                    )->input( client->_bind_edit( quantity )
                    )->label( 'text'
                    )->input(
                        value   = client->_bind_edit( mv_textarea )
                        enabled = abap_false
                    )->button(
                        text  = 'show popup input'
                        press = client->_event( 'SHOW_POPUP' )
                        )->get_parent( )->get_parent( )->footer(
                      )->overflow_toolbar(
              )->toolbar_spacer(
              )->overflow_toolbar_button(
                  text  = 'Clear'
                  press = client->_event( 'BUTTON_CLEAR' )
                  type  = 'Reject'
                  icon  = 'sap-icon://delete'
              )->button(
                  text  = 'Go to View Second'
                  press = client->_event( 'SHOW_VIEW_SECOND' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_display_view_second.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
          )->page(
                  title          = 'abap2UI5 - Template'
                  navbuttonpress = client->_event( val = 'BACK' )
                  shownavbutton  = temp2
              )->simple_form( 'VIEW_SECOND'
                  )->content( 'form'
      )->get_parent( )->get_parent( )->footer(
            )->overflow_toolbar(
                )->toolbar_spacer(
                )->overflow_toolbar_button(
                    text  = 'Clear'
                    press = client->_event( 'BUTTON_CLEAR' )
                    type  = 'Reject'
                    icon  = 'sap-icon://delete'
                )->button(
                    text  = 'Go to View Main'
                    press = client->_event( 'SHOW_VIEW_MAIN' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'SHOW_POPUP'.
        z2ui5_display_popup_input( ).

      WHEN 'POPUP_CONFIRM'.
        client->message_toast_display( |confirm| ).
        client->popup_destroy( ).

      WHEN 'POPUP_CANCEL'.
        CLEAR mv_textarea.
        client->message_toast_display( |cancel| ).
        client->popup_destroy( ).

      WHEN 'SHOW_VIEW_MAIN'.
        z2ui5_display_view_main( ).

      WHEN 'SHOW_VIEW_SECOND'.
        z2ui5_display_view_second( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    quantity = '500'.
    z2ui5_display_view_main( ).

  ENDMETHOD.
ENDCLASS.
